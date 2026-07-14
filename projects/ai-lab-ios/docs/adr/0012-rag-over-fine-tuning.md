# ADR-0012: RAG over Fine-Tuning for Document Q&A

## Status

Accepted

## Context

The Documents module must answer questions about user-uploaded content (PDFs, notes). Two fundamentally different approaches exist:

| Approach | Idea |
|----------|------|
| **RAG** (Retrieval-Augmented Generation) | Index documents → retrieve relevant chunks at query time → LLM answers with context |
| **Fine-tuning** | Train/adapt model weights on document corpus → model "memorizes" content |

AI Workspace is a **portfolio demo** that must teach RAG concepts: chunking, embeddings, cosine similarity, citations. It must also support the interview question: *"What's the difference between RAG and fine-tuning?"*

Constraints:

- Documents change frequently (user uploads new PDF)
- No GPU training infrastructure
- Must show **citations** (which chunk supported the answer)
- Budget-friendly for a personal demo

## Decision

Use **RAG** as the document Q&A strategy:

```
Document → Chunk (800 tokens, 120 overlap)
        → Embed (text-embedding-3-small)
        → VectorStore
Query   → Embed → Top-K cosine search
        → Build prompt with retrieved chunks
        → LLM generate answer with [source] citations
```

Do **not** fine-tune model weights. Do **not** stuff entire documents into the system prompt (context stuffing) except via retrieved chunks.

## Consequences

### Positive

- **Dynamic documents** — upload new PDF → re-index → immediately queryable. No retraining cycle.
- **Citations** — each answer traces to specific chunks; critical for trust and debugging.
- **Any LLM** — retrieval is model-agnostic; Claude can answer over chunks embedded by OpenAI.
- **Cost model** — pay per query (embed + generate), not per training run.
- **Teachable** — demonstrates embeddings, vector search, and prompt augmentation — all on the resume list.
- **Honest limitations** — easy to show when RAG fails (bad chunks, missing retrieval).

### Negative

- **Retrieval quality ceiling** — bad chunking or wrong top-K → wrong answers, even with a smart LLM.
- **Latency** — embed query + search + generate = 2+ API calls per question.
- **No true "learning"** — model doesn't internalize document style or domain; every answer depends on retrieval.
- **Context window still matters** — too many chunks → truncated context → incomplete answers.

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **Fine-tuning (OpenAI / LoRA)** | Expensive; slow iteration; can't update one page without retraining; no chunk-level citations; overkill for demo. |
| **Full document in system prompt** | Breaks at ~100+ pages; no retrieval lesson; wastes tokens on irrelevant content. |
| **Keyword search (BM25) only** | No semantic matching; fails on "What's the cancellation policy?" vs "refund rules". Good as hybrid, not alone. |
| **Long-context only (1M Gemini)** | Hides retrieval architecture; still expensive; no citation granularity; doesn't teach embeddings. |
| **Knowledge Graph + RAG** | Powerful but scope creep for Phase 1. |

## RAG vs Fine-Tuning — Interview Comparison

| Dimension | RAG | Fine-tuning |
|-----------|-----|-------------|
| **Updates** | Re-index new docs in minutes | Retrain; hours/days |
| **Cost** | Per-query inference | Training + inference |
| **Citations** | Natural (chunk IDs) | Opaque (weights) |
| **Private data leak risk** | Data in prompt per request | Baked into weights |
| **Best for** | FAQ, docs, manuals, policies | Style, tone, format, domain behavior |
| **This project** | **Yes** | No |

## When Fine-Tuning Would Be Added

A future **Phase 5** module could demo fine-tuning for **behavior** (e.g. "always respond in British English") while RAG handles **knowledge** (document content). These are complementary, not competing.

## Interview Sound Bite

> "RAG for knowledge, fine-tuning for behavior. Documents change — I chunk, embed, retrieve by cosine similarity, and inject top-K into the prompt with citations. Fine-tuning would bake static knowledge into weights, cost money to update, and wouldn't tell me which paragraph the answer came from."

## Related

- [ADR-0006: In-Memory Vector Store](0006-in-memory-vector-store.md)
- [ADR-0009: Unified Embedding Provider](0009-unified-embedding-provider.md)
