# Hallucination

Russian: галлюцинация

Category: Evaluation

Importance: Essential

Status: full

## Definition

Hallucination — уверенный, но **ложный или необоснованный** ответ модели: выдуманные факты, API, цитаты, цифры.

## Why it matters

Главный риск LLM в продуктах с доверием (медицина, финансы, support). Лечится grounding (RAG), tool checks, evals и UX-оговорками.

## Example

Бот выдумывает несуществующий номер заказа. Фикс: retrieve из order DB + запрет отвечать без найденной записи.

## Related

- [Grounding](grounding.md)
- [RAG](rag.md)
- [Evaluation](evaluation.md)
- [Glossary portal](../../../glossary/)
