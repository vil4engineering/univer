# DESIGN — Что дали очереди и callback — и почему этого мало?

**Статус:** Design + Draft v1 · Owner: Maxim · 2026-08-03 · Accept pending Reviewer  
**Topic id:** `swift/concurrency/gcd-and-callback-era`  
**Faculty:** Mobile Systems · Swift Concurrency  
**Paths:** after [shared-state-and-races](../shared-state-and-races/) · before structured concurrency  
**Interview Heat:** ★★★★  
**Levels:** 1–2

**Pipeline:** [handoff §8b](../../../.author/SWIFT_SHELF_HANDOFF.md)

---

## Claims ledger

| Claim | Status |
|-------|--------|
| GCD queues serialize/fan-out work without raw Thread management | Fact · Apple concurrency model |
| Callbacks compose poorly (pyramid, lifetime, error paths) | Fact · engineering commonplace |
| GCD still present under/alongside Swift Concurrency | Fact · interoperability |
| This chapter is historical + pain, not GCD API catalog | Scope |
| Structured concurrency is the next answer, not taught here | Scope |

## Passport

**Fundamental why:** Почему очереди и callback стали ответом на threads/races — и какая боль осталась?

**H1:** Что дали очереди и callback — и почему этого мало?

**Анти-цель:** полный GCD API reference · OperationQueue encyclopedia · async/await rewrite.

## Критерии приёмки дизайна

- [x] Один why  
- [x] Queue/callback как ответ на shared work  
- [x] Честная боль pyramid / lifetime  
- [x] Не учить structured concurrency API здесь  
- [x] Formal Accept (2026-08-03 · Owner · theory v1)
