# Inference

Russian: инференс

Category: Fundamentals

Importance: Essential

Status: full

## Definition

Inference — запуск **уже обученной** модели на новых данных: получить ответ, класс, embedding. Это то, что делает пользовательский запрос в проде.

## Why it matters

Продуктовые SLO (latency, cost, availability) живут на inference path. Training — отдельный пайплайн.

## Example

```python
# псевдокод
answer = client.chat.completions.create(model="…", messages=messages)
```

На iOS то же самое через URLSession к API или Foundation Models session.on-device.

## Related

- [Model](model.md)
- [Serving](serving.md)
- [Latency](latency.md)
- [Training](training.md)
- [Glossary portal](../../../glossary/)
