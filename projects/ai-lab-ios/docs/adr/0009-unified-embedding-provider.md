# ADR-0009: Unified Embedding Provider for RAG

## Status

Accepted

## Context

RAG and Memory modules need to convert text into **dense vectors** for similarity search. Three cloud providers in the project can theoretically produce embeddings:

- OpenAI (`text-embedding-3-small`)
- Gemini (embedContent API)
- Anthropic (no embeddings API)

Problems with multi-provider embeddings:

- **Different dimensions** — OpenAI 1536, others vary; vectors from different models are not comparable
- **Mixed index corruption** — re-embedding half a document corpus with a new model breaks search
- **Complexity** — `EmbeddingService` would need normalization, model versioning, re-index logic

## Decision

Route all embedding requests through **OpenAI as the single embedding provider**, regardless of which LLM generates the final answer.

```swift
actor EmbeddingService {
    func embed(texts: [String], model: String = "text-embedding-3-small") async throws -> [[Float]]
}
```

`CacheStore` caches vectors by input text to avoid redundant API calls.

Documents can be **answered by Claude or Gemini** while chunks were **embedded by OpenAI** — retrieval and generation are decoupled.

## Consequences

### Positive

- **Consistent vector space** — all chunks and queries are comparable.
- **Simpler RAG pipeline** — one embed call shape, one dimensionality.
- **Cost control** — caching embeddings reduces repeat indexing cost.
- **Valid production pattern** — many apps use a dedicated embedding model ≠ chat model.

### Negative

- **OpenAI key required for RAG** — even if user chats with Anthropic only.
- **Offline gap** — no embeddings without network (Foundation Models embedding TBD).
- **Vendor coupling for vectors** — migration requires full re-index.
- **Gemini embedding code** — scaffolded but intentionally not used in RAG path.

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **Per-provider embeddings** | Dimension mismatch; index invalidation nightmare. |
| **On-device embeddings (Core ML)** | Excellent future ADR; not Phase 1 scope. |
| **Keyword search only (no embeddings)** | Cannot demo semantic search or "RAG vs grep" interview question. |
| **Hybrid: BM25 + vectors** | Great at scale; added complexity for demo. |
| **Same model for embed + generate** | Some models support both; not true for Claude. |

## Interview Sound Bite

> "Retrieval and generation are separate concerns. I embed everything with one model so vectors live in the same space, then any LLM can answer over that context. Switching chat provider doesn't force re-indexing."
