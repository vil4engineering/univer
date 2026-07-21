# Model

Russian: модель

Category: Fundamentals

Importance: Essential

Status: full

## Definition

Model — обученная (или предобученная) функция: на вход данные, на выход предсказание или генерация. В продукте «модель» часто = конкретный checkpoint + API/runtime.

## Why it matters

Инженер выбирает модель (качество / cost / latency / on-device), версионирует её и отделяет **training artifacts** от **serving**.

## Example

`gpt-4.1-mini` в облаке vs on-device Foundation Model на iPhone — разные models под разные constraints.

## Related

- [Parameters](parameters.md)
- [Inference](inference.md)
- [Checkpoint](checkpoint.md)
- [LLM](llm.md)
- [Glossary portal](../../../glossary/)
