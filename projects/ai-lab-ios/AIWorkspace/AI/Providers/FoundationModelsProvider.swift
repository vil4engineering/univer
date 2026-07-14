import Foundation

#if canImport(FoundationModels)
import FoundationModels
#endif

final class FoundationModelsProvider: LLMProvider, @unchecked Sendable {
  let kind: AIProviderKind = .foundationModels

  var capabilities: ProviderCapabilities {
    ProviderCapabilities(
      streaming: true,
      vision: false,
      tools: true,
      structuredOutput: true,
      embeddings: false,
      onDevice: true
    )
  }

  var availableModels: [AIModelDescriptor] {
    [
      AIModelDescriptor(
        id: "apple-foundation-default",
        name: "Apple On-Device",
        provider: .foundationModels,
        supportsStreaming: true,
        supportsVision: false,
        supportsTools: true,
        supportsStructuredOutput: true,
        contextWindow: 4096,
        isOnDevice: true
      )
    ]
  }

  func complete(_ request: ChatRequest) async throws -> ChatCompletionResult {
    #if canImport(FoundationModels)
    throw AIError.foundationModelsUnavailable
    #else
    throw AIError.foundationModelsUnavailable
    #endif
  }

  func stream(_ request: ChatRequest) -> AsyncThrowingStream<ChatStreamEvent, Error> {
    AsyncThrowingStream { continuation in
      continuation.finish(throwing: AIError.foundationModelsUnavailable)
    }
  }
}
