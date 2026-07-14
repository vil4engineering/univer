# ADR-0006: In-Memory Vector Store for RAG Demo

## Status

Accepted (with explicit migration path)

## Context

The Documents (RAG) and Memory modules need:

1. Store text chunks with embedding vectors
2. Query by **cosine similarity** against a user question
3. Return top-K results with scores for citations

Production RAG systems use specialized stores (Pinecone, pgvector, sqlite-vec). This project is a **portfolio demo**, not a production deployment.

Constraints:

- Must demonstrate chunking → embed → search → generate pipeline
- Must keep setup friction low (no external database server)
- Should document a clear upgrade path for interviews

## Decision

Implement **`InMemoryVectorStore`** — an `actor` holding `[VectorDocument]` grouped by collection name (`documents`, `memory`).

Search algorithm:

```swift
cosineSimilarity(queryVector, document.vector) → sort → topK → filter by minScore
```

Chunking via `DocumentChunker` (size 800, overlap 120). Embeddings via `EmbeddingService` (see [ADR-0009](0009-unified-embedding-provider.md)).

SwiftData stores chunk **metadata** (`DocumentChunk`, `MemoryEntry`); vectors live in the actor for fast demo iteration.

## Consequences

### Positive

- **Zero infrastructure** — clone repo, add API key, run RAG immediately.
- **Transparent algorithm** — cosine similarity is visible in code; great for explaining embeddings in interviews.
- **Easy to test** — unit tests for `VectorMath.cosineSimilarity` and `DocumentChunker`.
- **Clean swap boundary** — `VectorStore` protocol means production store drops in without UI changes.

### Negative

- **Not persistent across launches** — re-index documents after app restart (metadata in SwiftData survives; vectors do not unless re-embedded).
- **O(n) search** — fine for dozens of chunks; breaks at thousands.
- **RAM usage** — large PDFs with many chunks consume memory.
- **No ANN index** — no HNSW/IVF; brute-force similarity only.

## Alternatives Considered

| Alternative | Why not (for now) |
|-------------|-------------------|
| **sqlite-vec / GRDB + vec0** | Best production path; adds setup complexity for Phase 1. |
| **Core ML on-device embeddings + Accelerate** | Good offline story; separate ADR scope. |
| **SwiftData blob + full scan** | Works but slower and muddies relational vs vector concerns. |
| **Remote Pinecone** | Requires account, network, API key — distracts from learning pipeline. |
| **Store vectors in UserDefaults** | Absurd at scale; no query API. |

## Migration Path (documented for interviews)

1. Implement `SQLiteVectorStore: VectorStore` with vec0 extension
2. Persist vectors on index; load on app launch
3. Add background `BGTaskScheduler` refresh for stale embeddings
4. Consider ANN when collection > ~10K vectors

## Interview Sound Bite

> "I deliberately separated the vector store behind a protocol and started in-memory to prove the RAG pipeline. Cosine search is brute-force — I'd swap in sqlite-vec for persistence and ANN at scale without touching the Documents ViewModel."
