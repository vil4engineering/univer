import Foundation

enum AIError: LocalizedError, Sendable {
    case missingAPIKey(AIProviderKind)
    case invalidResponse
    case httpError(statusCode: Int, body: String)
    case decodingFailed(String)
    case streamingFailed(String)
    case toolNotFound(String)
    case toolExecutionFailed(String)
    case validationFailed(String)
    case cancelled
    case unsupportedCapability(String)
    case providerUnavailable(AIProviderKind)
    case embeddingFailed(String)
    case ragFailed(String)
    case foundationModelsUnavailable

    var errorDescription: String? {
        switch self {
        case .missingAPIKey(let provider):
            "Missing API key for \(provider.displayName). Add it in Settings."
        case .invalidResponse:
            "The model returned an invalid response."
        case .httpError(let code, let body):
            "HTTP \(code): \(body)"
        case .decodingFailed(let detail):
            "Failed to decode response: \(detail)"
        case .streamingFailed(let detail):
            "Streaming failed: \(detail)"
        case .toolNotFound(let name):
            "Tool not found: \(name)"
        case .toolExecutionFailed(let detail):
            "Tool execution failed: \(detail)"
        case .validationFailed(let detail):
            "Validation failed: \(detail)"
        case .cancelled:
            "Request was cancelled."
        case .unsupportedCapability(let detail):
            "Unsupported capability: \(detail)"
        case .providerUnavailable(let provider):
            "\(provider.displayName) is not available."
        case .embeddingFailed(let detail):
            "Embedding failed: \(detail)"
        case .ragFailed(let detail):
            "RAG failed: \(detail)"
        case .foundationModelsUnavailable:
            "Apple Foundation Models are not available on this device."
        }
    }
}
