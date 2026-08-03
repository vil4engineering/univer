# Swift 6.4 concurrency — what's new (SwiftLee)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `503356` |
| Related | [Concurrency](../README.md) |

---

## За 30 секунд

Главное по concurrency в Swift 6.4 (эра WWDC 2026):

- **Async `defer`** (SE-0493) — `await` в cleanup внутри defer.
- **Task cancellation shields** (SE-0504) — доделать короткий cleanup, скрыв наблюдение cancel.
- **Warnings** за проигнорированный throwing в unstructured `Task { try await … }` (SE-0520).
- Typed throwing task initializers; **async `Result { }`** (SE-0530).
- Рядом: `weak let` (6.3) для Sendable; `~Sendable` (SE-0518).

## Источник

https://www.avanderlee.com/concurrency/swift-6-4-whats-new-in-concurrency/

## Cross-link

Глава async defer: [swift/async-defer](../../async-defer/README.md).
