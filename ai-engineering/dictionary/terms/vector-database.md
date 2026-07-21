# Vector Database

Russian: векторная база данных

Category: Embeddings

Importance: Essential

Status: full

## Definition

Vector Database хранит embeddings, строит ANN-индекс и умеет искать ближайших соседей с фильтрами по метаданным.

## Why it matters

Production RAG нужен не «массив float в RAM», а индекс, фильтрация (tenant, lang), upsert и мониторинг.

## Example

Индексировать FAQ в Qdrant/Pinecone; на запрос — `search(embedding, filter=product_id)`.

## Related

- [ANN Search](ann-search.md)
- [Embedding](embedding.md)
- [FAISS](faiss.md)
- [Qdrant](qdrant.md)
- [Topic: Vector Search](../../vector-search/)
- [Glossary portal](../../../glossary/)
