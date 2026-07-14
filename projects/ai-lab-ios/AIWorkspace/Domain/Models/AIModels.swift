import Foundation

enum AIProviderKind: String, CaseIterable, Codable, Identifiable, Sendable {
    case openAI
    case anthropic
    case gemini
    case foundationModels

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .openAI: "OpenAI"
        case .anthropic: "Anthropic"
        case .gemini: "Gemini"
        case .foundationModels: "Foundation Models"
        }
    }

    var iconName: String {
        switch self {
        case .openAI: "sparkles"
        case .anthropic: "brain.head.profile"
        case .gemini: "diamond.fill"
        case .foundationModels: "apple.logo"
        }
    }
}

struct AIModelDescriptor: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let provider: AIProviderKind
    let supportsStreaming: Bool
    let supportsVision: Bool
    let supportsTools: Bool
    let supportsStructuredOutput: Bool
    let contextWindow: Int
    let isOnDevice: Bool
}

struct ChatMessagePayload: Identifiable, Hashable, Sendable {
    let id: UUID
    var role: MessageRole
    var content: String
    var imageData: Data?
    var toolCalls: [ToolCallRequest]
    var toolResults: [ToolCallResult]
    var createdAt: Date

    init(
        id: UUID = UUID(),
        role: MessageRole,
        content: String,
        imageData: Data? = nil,
        toolCalls: [ToolCallRequest] = [],
        toolResults: [ToolCallResult] = [],
        createdAt: Date = .now
    ) {
        self.id = id
        self.role = role
        self.content = content
        self.imageData = imageData
        self.toolCalls = toolCalls
        self.toolResults = toolResults
        self.createdAt = createdAt
    }
}

enum MessageRole: String, Codable, Sendable {
    case system
    case user
    case assistant
    case tool
}

struct ChatRequest: Sendable {
    var messages: [ChatMessagePayload]
    var systemPrompt: String?
    var model: AIModelDescriptor
    var temperature: Double
    var tools: [ToolDefinition]
    var responseFormat: ResponseFormat?
    var stream: Bool
}

enum ResponseFormat: Sendable {
    case text
    case json(schema: JSONSchema?)
}

struct JSONSchema: Sendable {
    let name: String
    let schema: [String: AnySendable]
}

struct AnySendable: @unchecked Sendable {
    let value: Any
}

struct ChatStreamEvent: Sendable {
    enum EventKind: Sendable {
        case textDelta(String)
        case toolCallDelta(ToolCallRequest)
        case completed(ChatCompletionResult)
        case error(AIError)
    }

    let kind: EventKind
}

struct ChatCompletionResult: Sendable {
    let message: ChatMessagePayload
    let usage: TokenUsage?
    let rawResponse: String?
}

struct TokenUsage: Sendable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int

    var estimatedCostUSD: Double {
        // Placeholder pricing for demo metrics
        Double(promptTokens) * 0.000002 + Double(completionTokens) * 0.000006
    }
}

struct EmbeddingRequest: Sendable {
    let texts: [String]
    let model: String
}

struct EmbeddingResult: Sendable {
    let vectors: [[Float]]
    let model: String
    let usage: TokenUsage?
}

struct VectorDocument: Identifiable, Sendable {
    let id: UUID
    let text: String
    let vector: [Float]
    let metadata: [String: String]
}

struct RAGQuery: Sendable {
    let question: String
    let topK: Int
    let minScore: Float
}

struct RAGResult: Sendable {
    let answer: String
    let citations: [RAGCitation]
    let usage: TokenUsage?
}

struct RAGCitation: Identifiable, Sendable {
    let id: UUID
    let text: String
    let score: Float
    let source: String
}

struct ToolDefinition: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let description: String
    let parameters: ToolParameters
}

struct ToolParameters: Hashable, Sendable {
    let properties: [String: ToolProperty]
    let required: [String]
}

struct ToolProperty: Hashable, Sendable {
    let type: String
    let description: String
    let enumValues: [String]?
}

struct ToolCallRequest: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    var argumentsJSON: String
}

struct ToolCallResult: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let output: String
    let isError: Bool
}

struct ProviderCapabilities: Sendable {
    let streaming: Bool
    let vision: Bool
    let tools: Bool
    let structuredOutput: Bool
    let embeddings: Bool
    let onDevice: Bool
}

struct RequestMetrics: Identifiable, Sendable {
    let id: UUID
    let module: String
    let provider: AIProviderKind
    let model: String
    let timeToFirstToken: TimeInterval?
    let fullResponseTime: TimeInterval
    let promptTokens: Int
    let completionTokens: Int
    let estimatedCostUSD: Double
    let timestamp: Date
}

struct DebugTrace: Identifiable, Sendable {
    let id: UUID
    let module: String
    let systemPrompt: String?
    let prompt: String
    let tools: [ToolDefinition]
    let rawResponse: String?
    let jsonPayload: String?
    let error: String?
    let timestamp: Date
}

enum DemoModule: String, CaseIterable, Identifiable, Sendable {
    case chat
    case structuredOutput
    case tools
    case voice
    case vision
    case documents
    case memory
    case models
    case foundationModels
    case mcp
    case settings
    case debug

    var id: String { rawValue }

    var title: String {
        switch self {
        case .chat: "Chat"
        case .structuredOutput: "Structured Output"
        case .tools: "Tools"
        case .voice: "Voice"
        case .vision: "Vision"
        case .documents: "Documents"
        case .memory: "Memory"
        case .models: "Models"
        case .foundationModels: "Foundation Models"
        case .mcp: "MCP"
        case .settings: "Settings"
        case .debug: "Debug"
        }
    }

    var subtitle: String {
        switch self {
        case .chat: "Streaming LLM chat with history"
        case .structuredOutput: "JSON Schema → Codable"
        case .tools: "Function calling & tool registry"
        case .voice: "Speech → LLM → TTS pipeline"
        case .vision: "Image & document analysis"
        case .documents: "RAG with embeddings"
        case .memory: "Long-term semantic memory"
        case .models: "Multi-provider switching"
        case .foundationModels: "On-device vs cloud"
        case .mcp: "Model Context Protocol"
        case .settings: "API keys & preferences"
        case .debug: "Prompts, tokens & traces"
        }
    }

    var iconName: String {
        switch self {
        case .chat: "bubble.left.and.bubble.right.fill"
        case .structuredOutput: "curlybraces"
        case .tools: "wrench.and.screwdriver.fill"
        case .voice: "waveform.circle.fill"
        case .vision: "eye.fill"
        case .documents: "doc.text.magnifyingglass"
        case .memory: "brain.fill"
        case .models: "cpu.fill"
        case .foundationModels: "apple.logo"
        case .mcp: "network"
        case .settings: "gearshape.fill"
        case .debug: "ladybug.fill"
        }
    }

    var topics: [String] {
        switch self {
        case .chat: ["SSE", "Streaming", "Prompt Engineering", "Context Window"]
        case .structuredOutput: ["JSON Schema", "Codable", "Validation"]
        case .tools: ["Tool Definition", "Function Calling", "Multi-step"]
        case .voice: ["Speech Recognition", "TTS", "VAD", "Latency"]
        case .vision: ["Vision Models", "OCR", "Image Understanding"]
        case .documents: ["Chunking", "Embeddings", "RAG", "Citations"]
        case .memory: ["Semantic Search", "Vector DB", "Memory Architecture"]
        case .models: ["Provider Abstraction", "Adapter Pattern"]
        case .foundationModels: ["On-device", "Privacy", "Offline"]
        case .mcp: ["Protocol", "Tools", "Resources"]
        case .settings: ["API Keys", "Configuration"]
        case .debug: ["Tracing", "Token Usage", "Latency"]
        }
    }
}
