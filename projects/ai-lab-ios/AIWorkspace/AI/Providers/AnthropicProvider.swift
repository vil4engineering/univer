import Foundation

final class AnthropicProvider: LLMProvider, @unchecked Sendable {
  let kind: AIProviderKind = .anthropic
  private let settings: SettingsStore
  private let client = HTTPClient()
  private let baseURL = URL(string: "https://api.anthropic.com/v1")!

  init(settings: SettingsStore) {
    self.settings = settings
  }

  var capabilities: ProviderCapabilities {
    ProviderCapabilities(
      streaming: true,
      vision: true,
      tools: true,
      structuredOutput: true,
      embeddings: false,
      onDevice: false
    )
  }

  var availableModels: [AIModelDescriptor] {
    [
      AIModelDescriptor(
        id: "claude-sonnet-4-20250514",
        name: "Claude Sonnet 4",
        provider: .anthropic,
        supportsStreaming: true,
        supportsVision: true,
        supportsTools: true,
        supportsStructuredOutput: true,
        contextWindow: 200_000,
        isOnDevice: false
      )
    ]
  }

  func complete(_ request: ChatRequest) async throws -> ChatCompletionResult {
    let urlRequest = try buildRequest(request, stream: false)
    let (data, response) = try await client.data(for: urlRequest)
    try validateHTTP(response: response, data: data)

    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
          let contentBlocks = json["content"] as? [[String: Any]],
          let text = contentBlocks.first?["text"] as? String
    else { throw AIError.invalidResponse }

    let usage = parseUsage(json["usage"] as? [String: Any])
    return ChatCompletionResult(
      message: ChatMessagePayload(role: .assistant, content: text),
      usage: usage,
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
                  let type = json["type"] as? String
            else { continue }

            if type == "content_block_delta",
               let delta = json["delta"] as? [String: Any],
               let text = delta["text"] as? String {
              accumulator.appendText(text)
              continuation.yield(ChatStreamEvent(kind: .textDelta(text)))
            }

            if type == "message_stop" {
              let message = ChatMessagePayload(role: .assistant, content: accumulator.text)
              continuation.yield(
                ChatStreamEvent(
                  kind: .completed(
                    ChatCompletionResult(message: message, usage: nil, rawResponse: accumulator.text)
                  )
                )
              )
            }
          }
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

  private func buildRequest(_ request: ChatRequest, stream: Bool) throws -> URLRequest {
    let apiKey = settings.apiKey(for: .anthropic)
    guard !apiKey.isEmpty else { throw AIError.missingAPIKey(.anthropic) }

    var urlRequest = URLRequest(url: baseURL.appendingPathComponent("messages"))
    urlRequest.httpMethod = "POST"
    urlRequest.setValue(apiKey, forHTTPHeaderField: "x-api-key")
    urlRequest.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let messages = request.messages.map { message in
      ["role": message.role == .assistant ? "assistant" : "user", "content": message.content]
    }

    var body: [String: Any] = [
      "model": request.model.id,
      "max_tokens": 4096,
      "messages": messages,
      "temperature": request.temperature,
      "stream": stream
    ]

    if let systemPrompt = request.systemPrompt {
      body["system"] = systemPrompt
    }

    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
    return urlRequest
  }

  private func parseUsage(_ usage: [String: Any]?) -> TokenUsage? {
    guard let usage,
          let input = usage["input_tokens"] as? Int,
          let output = usage["output_tokens"] as? Int
    else { return nil }
    return TokenUsage(promptTokens: input, completionTokens: output, totalTokens: input + output)
  }

  private func validateHTTP(response: URLResponse, data: Data) throws {
    guard let http = response as? HTTPURLResponse else { return }
    guard (200...299).contains(http.statusCode) else {
      let body = String(data: data, encoding: .utf8) ?? ""
      throw AIError.httpError(statusCode: http.statusCode, body: body)
    }
  }
}
