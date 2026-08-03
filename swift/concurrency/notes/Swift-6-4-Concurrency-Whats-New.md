# Swift 6.4 concurrency — what’s new (SwiftLee)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `503356` |
| Related | [Concurrency](../README.md) |

---

## In 30 seconds

Swift 6.4 concurrency highlights (WWDC 2026 era):

- **Async `defer`** (SE-0493) — `await` cleanup in defer.
- **Task cancellation shields** (SE-0504) — finish short cleanup while hiding cancel observation.
- **Warnings** for ignored throwing unstructured `Task { try await … }` (SE-0520).
- Typed throwing task initializers; **async `Result { }`** (SE-0530).
- Related: `weak let` (6.3) for Sendable; `~Sendable` (SE-0518).

## Source

https://www.avanderlee.com/concurrency/swift-6-4-whats-new-in-concurrency/

## Cross-link

Async defer chapter: [swift/async-defer](../../async-defer/README.md).

