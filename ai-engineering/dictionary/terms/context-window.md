# Context Window

Russian: контекстное окно

Category: LLM

Importance: Essential

Status: full

## Definition

Context Window — максимум токенов, которые модель обрабатывает за один запрос: system + history + retrieved docs + tool results + место под output.

## Why it matters

Переполнение окна = обрезка, рост цены и деградация качества. Проектирование session memory и RAG начинается с лимита окна.

## Example

Модель с окном 128k: длинный чат + большой RAG dump съедают бюджет; нужен chunking и context compression.

## Related

- [Token](token.md)
- [Token Budget](token-budget.md)
- [Conversation History](conversation-history.md)
- [Topic: Context Window](../../context-window/)
- [Glossary portal](../../../glossary/)
