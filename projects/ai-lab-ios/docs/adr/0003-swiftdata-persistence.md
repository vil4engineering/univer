# ADR-0003: SwiftData for App Persistence

## Status

Accepted

## Context

AI Workspace persists several **structured, relational** data types:

- Chat sessions and messages (history)
- Document chunk metadata (RAG indexing records)
- Memory entries (long-term preferences)
- AI request logs (debug traces)
- Cached LLM responses

Requirements:

- Native iOS integration (project stack lists SwiftData)
- Swift-friendly models with relationships (session → messages)
- Minimal boilerplate compared to raw SQL
- Works alongside SwiftUI via `.modelContainer()`

Vector embeddings are a separate concern — high-dimensional float arrays queried by cosine similarity, not typical relational access patterns.

## Decision

Use **SwiftData** (`@Model` classes + `ModelContext`) for all structured app entities.

```swift
@Model final class ChatSession { ... }
@Model final class ChatMessage { ... }
@Model final class DocumentChunk { ... }
@Model final class MemoryEntry { ... }
@Model final class AILogEntry { ... }
@Model final class CachedResponse { ... }
```

Inject `ModelContainer` from `AppContainer` at the app root. ViewModels receive `ModelContext` for inserts/fetches.

**Embeddings and vector search** stay in `InMemoryVectorStore` (see [ADR-0006](0006-in-memory-vector-store.md)) — not in SwiftData.

## Consequences

### Positive

- **Less boilerplate** — no manual SQL migrations for a portfolio project.
- **Swift-native** — `@Model` macros, `#Predicate`, `FetchDescriptor` align with modern Swift.
- **Relationship cascade** — `ChatSession` → `ChatMessage` with `.cascade` delete is declarative.
- **SwiftUI integration** — `.modelContainer()` wiring is one line at app entry.

### Negative

- **iOS 17+ only** — acceptable given project targets iOS 18.
- **Not ideal for vectors** — storing `[Float]` blobs in SwiftData works for memory entries but cosine search across thousands of vectors is slow without an index.
- **Debugging** — schema inspection is harder than opening a `.sqlite` file in DB Browser.
- **Migration story** — production apps need versioned migrations; portfolio scope defers this.

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **Raw SQLite via GRDB** | More control, but heavy setup for a demo app; duplicates Apple's direction. |
| **Core Data** | SwiftData is the successor; new project should not start on Core Data. |
| **UserDefaults / JSON files** | No relationships, no queries, poor fit for chat history and logs. |
| **Realm** | Third-party dependency; not in project stack. |
| **Store everything in vector DB** | Chat messages are not embedding queries; wrong tool for the job. |

## Interview Sound Bite

> "SwiftData for relational app state — chats, logs, cache keys. Vectors live in a separate store because similarity search is a different access pattern than CRUD. At scale I'd add sqlite-vec or a dedicated vector DB, not force embeddings into SwiftData."
