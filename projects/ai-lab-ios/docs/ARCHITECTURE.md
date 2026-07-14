# Architecture

Detailed architecture documentation for AI Workspace.

> **Architecture Decision Records:** [docs/adr/](adr/README.md) — why each major choice was made, with trade-offs and alternatives.

## Layers

### 1. Features (SwiftUI + MVVM)

Each feature module is self-contained:

- **View** — SwiftUI, no business logic
- **ViewModel** — `@Observable`, `@MainActor`, orchestrates use cases
- **Navigation** — `HomeView` routes to modules via `DemoModule` enum

### 2. Domain

Protocol-first contracts:

| Protocol | Responsibility |
|----------|----------------|
| `LLMProvider` | Chat completion + streaming |
| `EmbeddingProvider` | Text → vectors |
| `VisionCapable` | Image analysis |
| `ToolExecutor` | Local tool execution |
| `VectorStore` | Vector CRUD + similarity search |
| `AICacheStore` | Response & embedding cache |
| `AIRequestLogger` | Debug traces |
| `MetricsTracking` | TTFT, tokens, cost |

### 3. AI Layer

```
ProviderRegistry
├── OpenAIProvider      (chat, stream, embed, vision)
├── AnthropicProvider   (chat, stream)
├── GeminiProvider      (chat, stream, vision)
└── FoundationModelsProvider (on-device scaffold)

ToolRegistry
├── WeatherTool
├── CalendarTool
├── RemindersTool
├── ContactsTool
├── NotesTool
├── ClipboardTool
└── SearchTool

RAGService → EmbeddingService → VectorStore
MemoryService → EmbeddingService → VectorStore
```

### 4. Data Layer

- **SwiftData** — chat history, document chunks, memory entries, logs, cache
- **InMemoryVectorStore** — vectors for RAG and memory (swap for production DB)

### 5. Core

- `AppContainer` — dependency injection root
- `SettingsStore` — API keys, defaults
- `AILogger` — request/response tracing
- `MetricsCollector` — performance metrics
- `CacheStore` — embedding & response caching

## Dependency Injection

```swift
@main
struct AIWorkspaceApp: App {
    @State private var container = AppContainer()

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: container.makeHomeViewModel())
                .environment(container)
                .modelContainer(container.modelContainer)
        }
    }
}
```

ViewModels are created via factory methods on `AppContainer`. No singletons.

## Streaming Architecture

```swift
func stream(_ request: ChatRequest) -> AsyncThrowingStream<ChatStreamEvent, Error>
```

Events:
- `.textDelta(String)` — partial text
- `.toolCallDelta(ToolCallRequest)` — tool call chunk
- `.completed(ChatCompletionResult)` — final result with usage
- `.error(AIError)` — non-fatal stream error

Cancellation: `Task.cancel()` → `continuation.onTermination` → provider aborts.

## Tool Calling Flow

```
User: "Remind me tomorrow to call John"
  ↓
LLMProvider.complete(tools: [createReminder, ...])
  ↓
Model returns tool_call: createReminder({title: "call John", dueDate: "tomorrow"})
  ↓
ToolRegistry.execute(call)
  ↓
RemindersTool → local execution (demo)
  ↓
Tool result fed back to LLM
  ↓
Final natural language response
```

## RAG Flow

```
PDF/Text
  ↓ DocumentChunker (size=800, overlap=120)
Chunks[]
  ↓ EmbeddingService (OpenAI text-embedding-3-small)
Vectors[]
  ↓ InMemoryVectorStore.upsert()
Indexed

Query: "What are the key points?"
  ↓ embed query
  ↓ cosine similarity search (topK=4)
  ↓ build context with citations
  ↓ LLM.generate(context + question)
Answer with [source] citations
```

## Memory Flow

```
"I prefer British English"
  ↓ embed
  ↓ store in vector collection "memory"
  ↓ persist MemoryEntry in SwiftData

Later query: "What language do I prefer?"
  ↓ semantic search in memory collection
  ↓ inject top memories into prompt
  ↓ LLM answers with personalization
```

## Metrics

Every module records `RequestMetrics`:
- Time To First Token (TTFT)
- Full Response Time
- Prompt / Completion Tokens
- Estimated Cost (USD)

Visible in **Debug** module and per-module metric badges.

## Scaling Directions

1. **Vector store** → SQLite with vec0 / Core ML embeddings
2. **Provider streaming tools** → per-provider tool delta parsers
3. **MCP** → stdio/SSE transport, wire into ToolOrchestrator
4. **Rate limiting** → actor-based token bucket per provider
5. **Offline** → Foundation Models for chat when cloud unavailable
6. **Background** → `BGTaskScheduler` for embedding refresh
