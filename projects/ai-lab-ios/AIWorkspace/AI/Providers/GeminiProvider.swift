import Foundation

final class GeminiProvider: LLMProvider, EmbeddingProvider, VisionCapable, @unchecked Sendable {
  let kind: AIProviderKind = .gemini
  private let settings: SettingsStore
  private let client = HTTPClient()

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
        id: "gemini-2.0-flash",
        name: "Gemini 2.0 Flash",
        provider: .gemini,
        supportsStreaming: true,
        supportsVision: true,
        supportsTools: true,
        supportsStructuredOutput: true,
        contextWindow: 1_000_000,
        isOnDevice: false
      )
    ]
  }

  func complete(_ request: ChatRequest) async throws -> ChatCompletionResult {
    let urlRequest = try buildRequest(request, stream: false)
    let (data, response) = try await client.data(for: urlRequest)
    try validateHTTP(response: response, data: data)

    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
          let candidates = json["candidates"] as? [[String: Any]],
          let content = candidates.first?["content"] as? [String: Any],
          let parts = content["parts"] as? [[String: Any]],
          let text = parts.first?["text"] as? String
    else { throw AIError.invalidResponse }

    return ChatCompletionResult(
      message: ChatMessagePayload(role: .assistant, content: text),
      usage: nil,
      rawResponse: String(data: data, encoding: .utf8)
    )
  }

  func stream(_ request: ChatRequest) -> AsyncThrowingStream<ChatStreamEvent, Error> {
    AsyncThrowingStream { continuation in
      let task = Task {
        do {
          let urlRequest = try self.buildRequest(request, stream: true)
          let (bytes, response) = try await self.client.bytes(for: urlRequest)
          if let http = response as? HTTPURLResponse, http.statusCode >= 400 {
            throw AIError.httpError(statusCode: http.statusCode, body: "Streaming request failed")
          }

          var accumulator = StreamingAccumulator()
          for try await line in bytes.lines {
            try Task.checkCancellation()
            guard line.hasPrefix("data:") else { continue }
            let payload = String(line.dropFirst(5)).trimmingCharacters(in: .whitespaces)
            guard let payloadData = payload.data(using: .utf8),
                  let json = try JSONSerialization.jsonObject(with: payloadData) as? [String: Any],
                  let candidates = json["candidates"] as? [[String: Any]],
                  let content = candidates.first?["content"] as? [String: Any],
                  let parts = content["parts"] as? [[String: Any]],
                  let text = parts.first?["text"] as? String
            else { continue }

            accumulator.appendText(text)
            continuation.yield(ChatStreamEvent(kind: .textDelta(text)))
          }

          let message = ChatMessagePayload(role: .assistant, content: accumulator.text)
          continuation.yield(
            ChatStreamEvent(
              kind: .completed(
                ChatCompletionResult(message: message, usage: nil, rawResponse: accumulator.text)
              )
            )
          )
          continuation.finish()
        } catch is CancellationError {
          continuation.finish(throwing: AIError.cancelled)
        } catch {
          continuation.finish(throwing: error)
        }
      }
      continuation.onTermination = { _ in task.cancel() }
    }
  }

  func embed(_ request: EmbeddingRequest) async throws -> EmbeddingResult {
    let apiKey = settings.apiKey(for: .gemini)
    guard !apiKey.isEmpty else { throw AIError.missingAPIKey(.gemini) }

    let model = request.model
    let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/\(model):embedContent?key=\(apiKey)")!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let body: [String: Any] = [
      "content": ["parts": request.texts.map { ["text": $0] }]]
    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)

    let (data, response) = try await client.data(for: urlRequest)
    try validateHTTP(response: response, data: data)
    throw AIError.embeddingFailed("Gemini batch embedding parsing not implemented in demo scaffold")
  }

  func analyzeImage(
    data: Data,
    mimeType: String,
    prompt: String,
    model: AIModelDescriptor
  ) async throws -> ChatCompletionResult {
    let request = ChatRequest(
      messages: [ChatMessagePayload(role: .user, content: prompt, imageData: data)],
      systemPrompt: nil,
      model: model,
      temperature: 0.2,
      tools: [],
      responseFormat: .text,
      stream: false
    )
    _ = mimeType
    return try await complete(request)
  }

  private func buildRequest(_ request: ChatRequest, stream: Bool) throws -> URLRequest {
    let apiKey = settings.apiKey(for: .gemini)
    guard !apiKey.isEmpty else { throw AIError.missingAPIKey(.gemini) }

    let action = stream ? "streamGenerateContent" : "generateContent"
    let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/\(request.model.id):\(action)?alt=sse&key=\(apiKey)")!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let contents = request.messages.map { message -> [String: Any] in
      var parts: [[String: Any]] = [["text": message.content]]
      if let imageData = message.imageData {
        parts.append([
          "inline_data": [
            "mime_type": "image/jpeg",
            "data": imageData.base64EncodedString()
          ]
        ])
      }
      return [
        "role": message.role == .assistant ? "model" : "user",
        "parts": parts
      ]
    }

    var body: [String: Any] = [
      "contents": contents,
      "generationConfig": ["temperature": request.temperature]
    ]

    if let systemPrompt = request.systemPrompt {
      body["systemInstruction"] = ["parts": [["text": systemPrompt]]]
    }

    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
    return urlRequest
  }

  private func validateHTTP(response: URLResponse, data: Data) throws {
    guard let http = response as? HTTPURLResponse else { return }
    guard (200...299).contains(http.statusCode) else {
      let body = String(data: data, encoding: .utf8) ?? ""
      throw AIError.httpError(statusCode: http.statusCode, body: body)
    }
  }
}
