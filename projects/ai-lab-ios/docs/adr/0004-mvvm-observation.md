# ADR-0004: MVVM with Observation Framework

## Status

Accepted

## Context

Each demo module (Chat, Tools, Documents, etc.) has its own screen with local state: input text, loading flags, error messages, streaming partial results, metrics.

Requirements from project spec:

- **MVVM** architecture
- **Observation** framework (not legacy Combine-based reactivity)
- **SwiftUI** views
- ViewModels orchestrate async AI calls without containing UI code

## Decision

Use **`@Observable` + `@MainActor` ViewModels** paired with SwiftUI views that bind via `@Bindable`.

```swift
@Observable
@MainActor
final class ChatViewModel {
    var messages: [ChatMessagePayload] = []
    var isGenerating = false
    var streamingText = ""
    // ...
}
```

Views:

```swift
struct ChatView: View {
    @Bindable var viewModel: ChatViewModel
}
```

Factory methods on `AppContainer` create ViewModels with injected dependencies. Views never construct services.

## Consequences

### Positive

- **Granular updates** — Observation tracks property access; SwiftUI re-renders only affected views (unlike `ObservableObject` broadcasting `objectWillChange` for any property).
- **No Combine imports in ViewModels** — async AI work uses `Task` + `async/await` directly.
- **Clear separation** — View = layout; ViewModel = state + orchestration; AI layer = network/parsing.
- **Per-module isolation** — each feature has its own ViewModel; Home only routes.

### Negative

- **iOS 17+ Observation** — team must know `@Observable` vs `@StateObject` differences.
- **MainActor discipline** — all UI state mutations must stay on main actor; network calls hop off implicitly via `await`.
- **Testing** — `@Observable` macro testing is newer; may need wrapper protocols for heavy unit tests.

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **UIKit + MVVM-C** | Project spec requires SwiftUI. |
| **`ObservableObject` + `@Published`** | Older pattern; triggers broader view invalidation; spec lists Observation. |
| **TCA (The Composable Architecture)** | Powerful but heavy for a learning portfolio; steep interview explanation cost. |
| **MVVM without ViewModels** | Logic in Views — untestable, violates spec. |
| **VIPER / Clean Swift** | Over-engineered for independent demo modules. |

## Interview Sound Bite

> "Each module is a small MVVM slice. ViewModels are `@Observable` and `@MainActor` — they own UI state and spawn `Task`s for AI calls. The view binds with `@Bindable` and doesn't know which LLM provider is active."
