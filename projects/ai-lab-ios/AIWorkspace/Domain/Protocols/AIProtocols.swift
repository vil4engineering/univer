import Foundation

protocol LLMProvider: Sendable {
    var kind: AIProviderKind { get }
    var capabilities: ProviderCapabilities { get }
    var availableModels: [AIModelDescriptor] { get }

    func complete(_ request: ChatRequest) async throws -> ChatCompletionResult
    func stream(_ request: ChatRequest) -> AsyncThrowingStream<ChatStreamEvent, Error>
}

protocol EmbeddingProvider: Sendable {
    var kind: AIProviderKind { get }
    func embed(_ request: EmbeddingRequest) async throws -> EmbeddingResult
}

protocol VisionCapable: Sendable {
    func analyzeImage(
        data: Data,
        mimeType: String,
        prompt: String,
        model: AIModelDescriptor
    ) async throws -> ChatCompletionResult
}

protocol ToolExecutor: Sendable {
    var definition: ToolDefinition { get }
    func execute(argumentsJSON: String) async throws -> String
}

protocol VectorStore: Sendable {
    func upsert(_ documents: [VectorDocument]) async
    func search(query: [Float], topK: Int, minScore: Float) async -> [VectorDocument]
    func removeAll(in collection: String) async
    func count(in collection: String) async -> Int
}

protocol AICacheStore: Sendable {
    func response(for key: String) async -> String?
    func store(response: String, for key: String) async
    func embedding(for text: String) async -> [Float]?
    func store(embedding: [Float], for text: String) async
}

protocol AIRequestLogger: Sendable {
    func logRequest(
        module: String,
        provider: AIProviderKind,
        model: String,
        systemPrompt: String?,
        prompt: String,
        tools: [ToolDefinition]
    ) async

    func logResponse(
        module: String,
        rawResponse: String?,
        jsonPayload: String?,
        usage: TokenUsage?,
        error: AIError?
    ) async

    func recentTraces(limit: Int) async -> [DebugTrace]
}

protocol MetricsTracking: Sendable {
    func record(_ metrics: RequestMetrics) async
    func recentMetrics(limit: Int) async -> [RequestMetrics]
    func aggregate() async -> MetricsSummary
}

struct MetricsSummary: Sendable {
    let totalRequests: Int
    let averageTTFT: TimeInterval
    let averageFullResponse: TimeInterval
    let totalPromptTokens: Int
    let totalCompletionTokens: Int
    let totalEstimatedCostUSD: Double
}
