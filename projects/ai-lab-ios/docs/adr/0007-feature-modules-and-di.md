# ADR-0007: Feature Modules with Manual Dependency Injection

## Status

Accepted

## Context

AI Workspace has **10+ independent demo modules** (Chat, Tools, Voice, Vision, Documents, Memory, Models, MCP, Settings, Debug). Each needs different dependencies:

- Chat → `ProviderRegistry`, `AILogger`, `MetricsCollector`, `CacheStore`, `ModelContext`
- Documents → `RAGService`, `ModelContext`
- Tools → `ProviderRegistry`, `ToolRegistry`
- Memory → `MemoryService`, `ProviderRegistry`

Requirements:

- **Feature Modules** structure (spec)
- **Dependency Injection** without heavy frameworks
- No global singletons (`AIService.shared` anti-pattern)
- Single composition root for testability

## Decision

Use **`AppContainer`** as the sole composition root with **factory methods** per feature:

```swift
@Observable @MainActor
final class AppContainer {
    let providerRegistry: ProviderRegistry
    let toolRegistry: ToolRegistry
    let ragService: RAGService
    // ...

    func makeChatViewModel() -> ChatViewModel { ... }
    func makeDocumentsViewModel() -> DocumentsViewModel { ... }
}
```

`AIWorkspaceApp` holds one `@State private var container = AppContainer()` and passes it via `.environment(container)`.

`HomeView` calls `container.makeXxxViewModel()` only when navigating to a module — lazy per-feature construction.

## Consequences

### Positive

- **Explicit dependency graph** — open `AppContainer.swift` and see the entire wiring.
- **No third-party DI** — no Swinject/Factory learning curve; pure Swift.
- **Feature isolation** — modules don't import each other; only Home routes between them.
- **Interview-friendly** — "composition root pattern" is a recognized term.

### Negative

- **Manual maintenance** — every new service updates `AppContainer` manually.
- **No scoped lifetimes** — ViewModels recreated on navigation unless cached (acceptable for demo).
- **Environment type safety** — `.environment(container)` is untyped if a view forgets to inject.
- **Testing** — must build test `AppContainer` or pass mocks via initializer overrides (not yet scaffolded).

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **Swinject / Factory** | Extra dependency; obscures wiring for portfolio readers. |
| **Singleton services** | Easy but untestable; hidden global state. |
| **SwiftUI `@Environment` per service** | 8+ environment keys; boilerplate explosion. |
| **Coordinator pattern** | Useful for deep linking; overkill for flat Home → Module nav. |
| **SPM micro-packages per feature** | Ideal at enterprise scale; premature for single-target demo. |

## Interview Sound Bite

> "`AppContainer` is the composition root. It constructs services once and exposes `makeChatViewModel()` factories. Features never reach for singletons — they receive protocols through initializers."
