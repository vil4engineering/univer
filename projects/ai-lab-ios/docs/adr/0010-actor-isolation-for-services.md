# ADR-0010: Actor Isolation for AI Services

## Status

Accepted

## Context

AI Workspace runs under **Swift 6 strict concurrency** (`SWIFT_STRICT_CONCURRENCY = complete`). Multiple services hold mutable state:

- `AILogger` — appends log entries, pending traces
- `MetricsCollector` — in-memory metrics array
- `CacheStore` — embedding cache dictionary
- `InMemoryVectorStore` — vector collections
- `ToolRegistry` — executor map
- `EmbeddingService`, `RAGService`, `MemoryService` — coordinate async calls

Concurrent access from multiple ViewModels (Chat + Documents + Memory) risks data races if services use unchecked shared mutable state.

## Decision

Implement stateful AI and data services as **`actor` types**:

```swift
actor AILogger: AIRequestLogger { ... }
actor MetricsCollector: MetricsTracking { ... }
actor CacheStore: AICacheStore { ... }
actor InMemoryVectorStore: VectorStore { ... }
actor ToolRegistry { ... }
actor EmbeddingService { ... }
actor RAGService { ... }
actor MemoryService { ... }
```

Callers `await` every method — serialization is automatic. `ProviderRegistry` and provider classes use `@unchecked Sendable` where they wrap `SettingsStore` (MainActor-bound) with documented boundaries.

ViewModels stay `@MainActor`; they hop to actors via `await` without manual locks.

## Consequences

### Positive

- **Data race safety** — compiler enforces actor isolation under Swift 6.
- **No manual locks** — `NSLock` / `DispatchQueue` avoided in service layer.
- **Clear async boundaries** — every mutation is an `await` point; easy to reason about.
- **Portfolio signal** — demonstrates modern Swift Concurrency, not just async syntax.

### Negative

- **Await overhead** — every cache read is `await`; negligible for I/O-bound AI work.
- **Reentrancy** — actors can suspend; state may change between `await` lines inside same method.
- **@unchecked Sendable providers** — `SettingsStore` access from providers relies on MainActor discipline.
- **Testing** — actor tests must be `async`; slightly more ceremony.

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **`NSLock` + class** | Works but fights Swift 6 checking; not idiomatic. |
| **MainActor for all services** | Blocks main thread during embedding/search loops. |
| **`DispatchQueue` serial queue** | Pre-async/await pattern; harder to compose with `Task.cancel()`. |
| **Immutable structs only** | Copy-on-write collections expensive for large vector stores. |
| **`nonisolated(unsafe)` everywhere** | Defeats purpose of strict concurrency. |

## Interview Sound Bite

> "Stateful AI services are actors — logger, cache, vector store, tool registry. ViewModels on MainActor await them. Strict concurrency is on, so the compiler catches shared mutable state instead of shipping data races."
