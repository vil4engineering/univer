# DESIGN — Зачем иерархия задач и отмена сверху вниз?

**Статус:** Design + Draft v1 · Owner: Maxim · 2026-08-03 · Accept pending Reviewer  
**Topic id:** `swift/concurrency/structured-concurrency`  
**Faculty:** Mobile Systems · Swift Concurrency  
**Paths:** after [gcd-and-callback-era](../gcd-and-callback-era/) · before async-await depth  
**Interview Heat:** ★★★★★  
**Levels:** 1–2

**Pipeline:** [handoff §8b](../../../.author/SWIFT_SHELF_HANDOFF.md)

---

## Claims ledger

| Claim | Status |
|-------|--------|
| Structured = parent scope owns child task lifetime | Fact · Swift concurrency model |
| Cancellation propagates downward in structured hierarchies | Fact · Apple docs / Swift book |
| Unstructured `Task { }` escapes that hierarchy | Fact |
| This chapter is why/structure, not full Task API catalog | Scope |
| `async let` / TaskGroup are mechanisms — light mention | Scope |

## Passport

**Fundamental why:** Почему concurrent work нужна иерархия lifetime — а не россыпь «запустил и забыл»?

**H1:** Зачем иерархия задач и отмена сверху вниз?

**Анти-цель:** полный Task API · actors · MainActor tour.

## Критерии приёмки дизайна

- [x] Один why  
- [x] Structured vs unstructured до API dump  
- [x] Cancellation как следствие структуры  
- [x] Link lab / warehouse note  
- [ ] Formal Accept (pending)
