import Foundation

final class OpenAIProvider: LLMProvider, EmbeddingProvider, VisionCapable, @unchecked Sendable {
  let kind: AIProviderKind = .openAI
  private let settings: SettingsStore
  private let client = HTTPClient()
  private let baseURL = URL(string: "https://api.openai.com/v1")!

  init(settings: SettingsStore) {
    self.settings = settings
  }

  var capabilities: ProviderCapabilities {
    ProviderCapabilities(
      streaming: true,
      vision: true,
      tools: true,
      structuredOutput: true,
      embeddings: true,
      onDevice: false
    )
  }

  var availableModels: [AIModelDescriptor] {
    [
      AIModelDescriptor(
        id: "gpt-4o-mini",
        name: "GPT-4o Mini",
        provider: .openAI,
        supportsStreaming: true,
        supportsVision: true,
        supportsTools: true,
        supportsStructuredOutput: true,
        contextWindow: 128_000,
        isOnDevice: false
      ),
      AIModelDescriptor(
        id: "gpt-4o",
        name: "GPT-4o",
        provider: .openAI,
        supportsStreaming: true,
        supportsVision: true,
        supportsTools: true,
        supportsStructuredOutput: true,
        contextWindow: 128_000,
        isOnDevice: false
      )
    ]
  }

  func complete(_ request: ChatRequest) async throws -> ChatCompletionResult {
    let urlRequest = try buildChatRequest(request, stream: false)
    let (data, response) = try await client.data(for: urlRequest)
    try validateHTTP(response: response, data: data)
    return try parseChatResponse(data: data)
  }

  func stream(_ request: ChatRequest) -> AsyncThrowingStream<ChatStreamEvent, Error> {
    AsyncThrowingStream { continuation in
      let task = Task {
        do {
          let urlRequest = try self.buildChatRequest(request, stream: true)
          let (bytes, response) = try await self.client.bytes(for: urlRequest)
          if let http = response as? HTTPURLResponse, http.statusCode >= 400 {
            throw AIError.httpError(statusCode: http.statusCode, body: "Streaming request failed")
          }

          var accumulator = StreamingAccumulator()
          let start = Date()
          var firstTokenTime: TimeInterval?

          for try await line in bytes.lines {
            try Task.checkCancellation()
            guard let payload = SSEParser.payload(from: line),
                  let payloadData = payload.data(using: .utf8),
                  let json = try JSONSerialization.jsonObject(with: payloadData) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let delta = choices.first?["delta"] as? [String: Any]
            else { continue }

            if let content = delta["content"] as? String, !content.isEmpty {
              if firstTokenTime == nil {
                firstTokenTime = Date().timeIntervalSince(start)
              }
              accumulator.appendText(content)
              continuation.yield(ChatStreamEvent(kind: .textDelta(content)))
            }
          }

          let usage = TokenUsage(promptTokens: 0, completionTokens: 0, totalTokens: 0)
          let message = ChatMessagePayload(role: .assistant, content: accumulator.text)
          continuation.yield(
            ChatStreamEvent(
              kind: .completed(
                ChatCompletionResult(message: message, usage: usage, rawResponse: accumulator.text)
              )
            )
          )
          continuation.finish()
        } catch is CancellationError {
          continuation.finish(throwing: AIError.cancelled)
        } catch {
          continuation.yield(ChatStreamEvent(kind: .error(error as? AIError ?? .streamingFailed(error.localizedDescription))))
          continuation.finish(throwing: error)
        }
      }
      continuation.onTermination = { _ in task.cancel() }
    }
  }

  func embed(_ request: EmbeddingRequest) async throws -> EmbeddingResult {
    let apiKey = await MainActor.run { settings.apiKey(for: .openAI) }
    guard !apiKey.isEmpty else { throw AIError.missingAPIKey(.openAI) }

    let url = baseURL.appendingPathComponent("embeddings")
    var urlRequest = ProviderRequestBuilder.authorizedRequest(url: url, apiKey: apiKey)
    let body: [String: Any] = [
      "model": request.model,
      "input": request.texts
    ]
    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)

    let (data, response) = try await client.data(for: urlRequest)
    try validateHTTP(response: response, data: data)

    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
          let items = json["data"] as? [[String: Any]]
    else { throw AIError.invalidResponse }

    let vectors: [[Float]] = try items.map { item in
      guard let embedding = item["embedding"] as? [Double] else {
        throw AIError.decodingFailed("Missing embedding vector")
      }
      return embedding.map(Float.init)
    }

    return EmbeddingResult(vectors: vectors, model: request.model, usage: nil)
  }

  func analyzeImage(
    data: Data,
    mimeType: String,
    prompt: String,
    model: AIModelDescriptor
  ) async throws -> ChatCompletionResult {
    let base64 = data.base64EncodedString()
    let request = ChatRequest(
      messages: [
        ChatMessagePayload(
          role: .user,
          content: prompt,
          imageData: data
        )
      ],
      systemPrompt: nil,
      model: model,
      temperature: 0.2,
      tools: [],
      responseFormat: .text,
      stream: false
    )
    _ = base64
    _ = mimeType
    return try await complete(request)
  }

  private func buildChatRequest(_ request: ChatRequest, stream: Bool) throws -> URLRequest {
    let apiKey = settings.apiKey(for: .openAI)
    guard !apiKey.isEmpty else { throw AIError.missingAPIKey(.openAI) }

    let url = baseURL.appendingPathComponent("chat/completions")
    var urlRequest = ProviderRequestBuilder.authorizedRequest(url: url, apiKey: apiKey)

    var messages: [[String: Any]] = []
    if let systemPrompt = request.systemPrompt {
      messages.append(["role": "system", "content": systemPrompt])
    }
    for message in request.messages {
      if let imageData = message.imageData {
        messages.append([
          "role": message.role.rawValue,
          "content": [
            ["type": "text", "text": message.content],
            [
              "type": "image_url",
              "image_url": ["url": "data:image/jpeg;base64,\(imageData.base64EncodedString())"]
            ]
          ]
        ])
      } else {
        messages.append(["role": message.role.rawValue, "content": message.content])
      }
    }

    var body: [String: Any] = [
      "model": request.model.id,
      "messages": messages,
      "temperature": request.temperature,
      "stream": stream
    ]

    if !request.tools.isEmpty {
      body["tools"] = request.tools.map { tool in
        [
          "type": "function",
          "function": [
            "name": tool.name,
            "description": tool.description,
            "parameters": toolParametersJSON(tool.parameters)
          ]
        ]
      }
    }

    if case .json(let schema) = request.responseFormat {
      var format: [String: Any] = ["type": "json_object"]
      if let schema {
        format["json_schema"] = [
          "name": schema.name,
          "schema": schema.schema.mapValues(\.value)
        ]
      }
      body["response_format"] = format
    }

    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
    return urlRequest
  }

  private func toolParametersJSON(_ parameters: ToolParameters) -> [String: Any] {
    var properties: [String: Any] = [:]
    for (key, property) in parameters.properties {
      var propertyJSON: [String: Any] = [
        "type": property.type,
        "description": property.description
      ]
      if let enumValues = property.enumValues {
        propertyJSON["enum"] = enumValues
      }
      properties[key] = propertyJSON
    }
    return [
      "type": "object",
      "properties": properties,
      "required": parameters.required
    ]
  }

  private func parseChatResponse(data: Data) throws -> ChatCompletionResult {
    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
          let choices = json["choices"] as? [[String: Any]],
          let message = choices.first?["message"] as? [String: Any],
          let content = message["content"] as? String
    else { throw AIError.invalidResponse }

    let usage = parseUsage(json["usage"] as? [String: Any])
    return ChatCompletionResult(
      message: ChatMessagePayload(role: .assistant, content: content),
      usage: usage,
      rawResponse: String(data: data, encoding: .utf8)
    )
  }

  private func parseUsage(_ usage: [String: Any]?) -> TokenUsage? {
    guard let usage,
          let prompt = usage["prompt_tokens"] as? Int,
          let completion = usage["completion_tokens"] as? Int,
          let total = usage["total_tokens"] as? Int
    else { return nil }
    return TokenUsage(promptTokens: prompt, completionTokens: completion, totalTokens: total)
  }

  private func validateHTTP(response: URLResponse, data: Data) throws {
    guard let http = response as? HTTPURLResponse else { return }
    guard (200...299).contains(http.statusCode) else {
      let body = String(data: data, encoding: .utf8) ?? ""
      throw AIError.httpError(statusCode: http.statusCode, body: body)
    }
  }
}
