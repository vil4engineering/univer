# Parameters

Russian: параметры

Category: Fundamentals

Importance: Essential

Status: full

## Definition

Parameters — числа внутри модели (веса, смещения и т.д.), которые определяют поведение. «7B / 70B» — порядок величины числа параметров.

## Why it matters

Размер влияет на качество, VRAM/RAM, latency и cost. Fine-tuning меняет (часть) параметров; inference только читает их.

## Example

Квантизация уменьшает память на параметры, чтобы вместить модель на устройство, ценой возможной потери качества.

## Related

- [Weights](weights.md)
- [Model](model.md)
- [Checkpoint](checkpoint.md)
- [Glossary portal](../../../glossary/)
