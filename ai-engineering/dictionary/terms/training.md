# Training

Russian: обучение

Category: Fundamentals

Importance: Essential

Status: full

## Definition

Training — процесс подбора параметров модели по данным и функции потерь, чтобы улучшить качество на задаче.

## Why it matters

Даже если вы только вызываете API, нужно понимать, что модель «заморожена» после train/fine-tune и не «помнит» ваш прод-трафик сама по себе (если нет отдельной memory/RAG).

## Example

Команда дообучает маленькую классификатор-intent модель на своих логах; LLM в чате при этом остаётся API без вашего training.

## Related

- [Pretraining](pretraining.md)
- [Fine-tuning](fine-tuning.md)
- [Parameters](parameters.md)
- [Glossary portal](../../../glossary/)
