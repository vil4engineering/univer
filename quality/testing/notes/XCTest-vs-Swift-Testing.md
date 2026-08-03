# XCTest vs Swift Testing

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `503182` |
| Related | [Testing](../README.md) |
| URL | https://www.linkedin.com/posts/vivek-kumar-singh-a81385a8_expect-swift-iosdevelopment-share-7475592601447071744-3pto/ |

---

## Дайджест

**XCTest vs Swift Testing** — эволюция тестирования в Swift.

Больше десяти лет **XCTest** — фундамент тестов на Apple platforms. **Swift Testing** (WWDC 2024) даёт более современный, выразительный и Swift-native подход:

- Меньше boilerplate
- Parameterized tests из коробки
- Лучше async/await
- Чище синтаксис: `@Test`, `#expect`

XCTest остаётся must-have для многих production apps; Swift Testing — направление экосистемы. Главное: качество тестов важнее выбора framework.

Пост: https://www.linkedin.com/posts/vivek-kumar-singh-a81385a8_expect-swift-iosdevelopment-share-7475592601447071744-3pto/

## One-liner на интервью

XCTest = десятилетие Apple testing foundation; Swift Testing (`@Test`, `#expect`, parameterized, async-native) = Swift-first direction. Могут жить в одном bundle — мигрируй file-by-file.
