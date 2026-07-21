# Token

Russian: токен

Category: Tokens

Importance: Essential

Status: full

## Definition

Token — атомарная единица текста для модели (часто подслово). Tokenizer режет строку на token IDs; от их числа зависят cost, latency и context window.

## Why it matters

Инженер считает бюджет в токенах, не в «символах». Один и тот же текст на разных языках даёт разное число токенов.

## Example

```swift
// Интуиция: длина prompt в символах ≠ tokens
let approxTokens = prompt.count / 4 // грубо для EN; для RU/CJK хуже
```

См. также playground/API tokenizer у провайдера.

## Related

- [Tokenizer](tokenizer.md)
- [Input Tokens](input-tokens.md)
- [Output Tokens](output-tokens.md)
- [Topic: Tokens](../../tokens/)
- [Glossary portal](../../../glossary/)
