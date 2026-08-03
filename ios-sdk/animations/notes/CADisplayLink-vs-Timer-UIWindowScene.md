# CADisplayLink vs Timer (UIWindowScene / iOS 27)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | partial |
| Source | Telegram Saved `504822` |
| Related | [Animations README](../README.md) |

---

## За 30 секунд

**Timer** — wall-clock интервалы. **CADisplayLink** — vsync / границы кадра. Для визуальной плавности, привязанной к refresh rate, бери DisplayLink; для грубой периодики (countdown, polling) — Timer.

## Pitfalls (из Saved digest)

- Invalidate link при dismiss / disconnect scene.
- Для multi-window предпочитай scene-aware API (`UIWindowScene`).
- Не крути UI animation clocks через Timer, если важна cadence ProMotion.

## Связано

Graphics / animations chapters; Instruments frame hitch debugging.
