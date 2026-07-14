# ADR-0005: Protocol-First AI Layer

## Status

Accepted

## Context

The AI layer touches many capabilities: chat completion, streaming, embeddings, vision, tool execution, vector search, caching, logging, metrics.

Temptation: call `OpenAIProvider` directly from every ViewModel. That couples features to one vendor and makes Foundation Models integration awkward.

Project spec explicitly lists **Protocol-first** as an architectural principle.

## Decision

Define **small, focused protocols** in `Domain/Protocols/` before any concrete implementation:

| Protocol | Responsibility |
|----------|----------------|
| `LLMProvider` | Chat + stream |
| `EmbeddingProvider` | Text → vectors |
| `VisionCapable` | Image analysis |
| `ToolExecutor` | Single tool execution |
| `VectorStore` | Upsert + similarity search |
| `AICacheStore` | Response/embedding cache |
| `AIRequestLogger` | Debug traces |
| `MetricsTracking` | TTFT, tokens, cost |

Concrete types (`OpenAIProvider`, `InMemoryVectorStore`, `AILogger`) conform in the AI and Data layers. ViewModels depend on protocols or registries, not concrete classes.

## Consequences

### Positive

- **Dependency inversion** — high-level modules (Features) do not depend on low-level modules (OpenAI SDK shapes).
- **Capability discovery** — `ProviderCapabilities` struct enables the Models module matrix without `if provider is OpenAI`.
- **Swap-friendly** — RAG's `VectorStore` can move from in-memory to SQLite without touching Documents UI.
- **Interview gold** — easy to draw boxes and arrows on a whiteboard.

### Negative

- **Protocol proliferation** — many files; newcomers must read the protocol map first.
- **Type erasure pain** — `any LLMProvider` loses associated types; some call sites need casts (`as? VisionCapable`).
- **Duplication risk** — shared request building logic may repeat across adapters until extracted.

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **Concrete classes only** | Fast to start, impossible to swap providers or mock in tests. |
| **One `AIService` god class** | 2000-line file; every feature depends on everything. |
| **OpenAPI-generated clients per provider** | Good for REST, but does not unify streaming events or tool orchestration. |
| **Macros/codegen for protocols** | Overkill for portfolio scope. |

## Interview Sound Bite

> "Features talk to protocols. `LLMProvider` for chat, `VectorStore` for RAG retrieval, `ToolExecutor` per tool. Concrete adapters are replaceable — that's how we run OpenAI and Foundation Models through the same Chat screen."
