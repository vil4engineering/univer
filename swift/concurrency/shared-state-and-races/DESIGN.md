# DESIGN — Почему общее изменяемое состояние ломается без правил?

**Статус:** Design + Draft v1 · Owner: Maxim · 2026-08-03 · Accept pending Reviewer  
**Topic id:** `swift/concurrency/shared-state-and-races`  
**Faculty:** Mobile Systems · Swift Concurrency  
**Paths:** after [processes-and-threads](../processes-and-threads/) · before GCD era  
**Interview Heat:** ★★★★★  
**Levels:** 1–2 · L3 лёгкий мост

**Pipeline:** [handoff §8b](../../../.author/SWIFT_SHELF_HANDOFF.md)

---

## Claims ledger

| Claim | Status |
|-------|--------|
| Data race = unsynchronized concurrent access to shared mutable state | Fact · memory model teaching |
| Race ≠ every concurrency bug (deadlock, priority inversion separate) | Fact |
| Locks serialize access but introduce new failure modes | Fact · heuristic on when |
| Immutable / value ownership reduces shared mutation | Interpretation · Swift-friendly |
| Actors/isolation deferred — this chapter names the pain | Scope |

## Passport

**Fundamental why:** Почему threads одного process, делящие память, ломают смысл программы без правил доступа?

**H1:** Почему общее изменяемое состояние ломается без правил?

**Анти-цель:** полный каталог примитивов синхронизации · actors API · TSan tutorial dump.

## Критерии приёмки дизайна

- [x] Один why  
- [x] Data race до API tourism  
- [x] Связь process/thread  
- [x] Не учить actors/GCD здесь  
- [x] Glossary Data race  
- [x] Formal Accept (2026-08-03 · Owner · theory v1)
