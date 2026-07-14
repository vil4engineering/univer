import Foundation
import SwiftData
import Observation

@Observable
@MainActor
final class AppContainer {
    let modelContainer: ModelContainer
    let settingsStore: SettingsStore
    let logger: AILogger
    let metricsCollector: MetricsCollector
    let cacheStore: CacheStore
    let providerRegistry: ProviderRegistry
    let toolRegistry: ToolRegistry
    let vectorStore: InMemoryVectorStore
    let embeddingService: EmbeddingService
    let ragService: RAGService
    let memoryService: MemoryService

    init() {
        let schema = Schema([
            ChatSession.self,
            ChatMessage.self,
            DocumentChunk.self,
            MemoryEntry.self,
            AILogEntry.self,
            CachedResponse.self
        ])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
        modelContainer = try! ModelContainer(for: schema, configurations: [configuration])

        settingsStore = SettingsStore()
        logger = AILogger(modelContext: modelContainer.mainContext)
        metricsCollector = MetricsCollector()
        cacheStore = CacheStore(modelContext: modelContainer.mainContext)
        providerRegistry = ProviderRegistry(settings: settingsStore)
        toolRegistry = ToolRegistry()
        vectorStore = InMemoryVectorStore()
        embeddingService = EmbeddingService(
            providerRegistry: providerRegistry,
            cacheStore: cacheStore
        )
        ragService = RAGService(
            embeddingService: embeddingService,
            vectorStore: vectorStore,
            providerRegistry: providerRegistry
        )
        memoryService = MemoryService(
            embeddingService: embeddingService,
            vectorStore: vectorStore,
            modelContext: modelContainer.mainContext
        )
    }

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel()
    }

    func makeChatViewModel() -> ChatViewModel {
        ChatViewModel(
            providerRegistry: providerRegistry,
            logger: logger,
            metricsCollector: metricsCollector,
            cacheStore: cacheStore,
            modelContext: modelContainer.mainContext
        )
    }

    func makeStructuredOutputViewModel() -> StructuredOutputViewModel {
        StructuredOutputViewModel(
            providerRegistry: providerRegistry,
            logger: logger,
            metricsCollector: metricsCollector
        )
    }

    func makeToolsViewModel() -> ToolsViewModel {
        ToolsViewModel(
            providerRegistry: providerRegistry,
            toolRegistry: toolRegistry,
            logger: logger,
            metricsCollector: metricsCollector
        )
    }

    func makeVoiceViewModel() -> VoiceViewModel {
        VoiceViewModel(
            providerRegistry: providerRegistry,
            logger: logger,
            metricsCollector: metricsCollector
        )
    }

    func makeVisionViewModel() -> VisionViewModel {
        VisionViewModel(
            providerRegistry: providerRegistry,
            logger: logger,
            metricsCollector: metricsCollector
        )
    }

    func makeDocumentsViewModel() -> DocumentsViewModel {
        DocumentsViewModel(
            ragService: ragService,
            logger: logger,
            metricsCollector: metricsCollector,
            modelContext: modelContainer.mainContext
        )
    }

    func makeMemoryViewModel() -> MemoryViewModel {
        MemoryViewModel(
            memoryService: memoryService,
            providerRegistry: providerRegistry,
            logger: logger
        )
    }

    func makeModelsViewModel() -> ModelsViewModel {
        ModelsViewModel(
            providerRegistry: providerRegistry,
            settingsStore: settingsStore
        )
    }

    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(settingsStore: settingsStore)
    }

    func makeDebugViewModel() -> DebugViewModel {
        DebugViewModel(
            logger: logger,
            metricsCollector: metricsCollector
        )
    }

    func makeMCPViewModel() -> MCPViewModel {
        MCPViewModel(logger: logger)
    }
}
