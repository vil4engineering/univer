# Architecture Decision Records

Short, interview-ready documents that explain **why** AI Workspace is built the way it is.

Each ADR follows the same structure:

| Section | Purpose |
|---------|---------|
| **Status** | Accepted, Superseded, or Deprecated |
| **Context** | Problem and constraints |
| **Decision** | What we chose |
| **Consequences** | Trade-offs — positive and negative |
| **Alternatives** | What else we considered and why we rejected it |

## Index

| ADR | Title | One-liner for interviews |
|-----|-------|--------------------------|
| [0001](0001-provider-abstraction.md) | Provider Abstraction | UI never talks to OpenAI directly — it talks to `LLMProvider` |
| [0002](0002-async-streaming.md) | AsyncSequence for Streaming | SSE chunks flow through `AsyncThrowingStream`, not Combine |
| [0003](0003-swiftdata-persistence.md) | SwiftData over Raw SQLite | Structured app data in SwiftData; vectors stay separate |
| [0004](0004-mvvm-observation.md) | MVVM with Observation | `@Observable` ViewModels instead of `ObservableObject` + Combine |
| [0005](0005-protocol-first-ai-layer.md) | Protocol-First AI Layer | Capabilities defined as protocols, not concrete SDK types |
| [0006](0006-in-memory-vector-store.md) | In-Memory Vector Store | RAG demo uses cosine search in memory; persistence is a swap |
| [0007](0007-feature-modules-and-di.md) | Feature Modules + Manual DI | No singletons; `AppContainer` wires dependencies per feature |
| [0008](0008-local-tool-registry.md) | Local Tool Registry | Function calling executes on-device tools via a registry |
| [0009](0009-unified-embedding-provider.md) | Unified Embedding Provider | One embedding source keeps vector dimensions consistent for RAG |
| [0010](0010-actor-isolation-for-services.md) | Actor Isolation for Services | `actor` types protect mutable AI service state under Swift 6 concurrency |
| [0011](0011-sse-over-websocket.md) | SSE over WebSocket | LLM APIs stream via HTTP SSE — no WebSocket client needed |
| [0012](0012-rag-over-fine-tuning.md) | RAG over Fine-Tuning | RAG for document knowledge; fine-tuning reserved for behavior |

## How to Use in an Interview

1. Pick the ADR that matches the question ("How did you handle multiple LLMs?").
2. State the **problem** in one sentence.
3. Name the **decision** and one **trade-off** you accepted.
4. Mention what you would change at scale (see *Consequences* in each ADR).

## Template

```markdown
# ADR-NNNN: Title

## Status
Accepted

## Context
...

## Decision
...

## Consequences
### Positive
- ...

### Negative
- ...

## Alternatives Considered
| Alternative | Why not |
|-------------|---------|
| ... | ... |
```
