# DESIGN — Как жить с concurrency в проде и мигрировать с GCD?

**Статус:** Design + Draft v1 · Owner: Maxim · Phase B §D · 2026-08-03  
**Topic id:** `swift/concurrency/production-architecture-and-migration`  
**Faculty:** Mobile Systems · Swift Concurrency  
**Paths:** ROADMAP M03 §D capstone · after testing · return to hub  
**Interview Heat:** ★★★★  
**Levels:** 1–2 обязательны · 3 = executors/custom runtime pointer

**Pipeline:** [chapter-fill](../../../.ai/workflows/chapter-fill.md) · [Swift shelf handoff](../../../.author/SWIFT_SHELF_HANDOFF.md)

---

## Claims ledger (before Draft)

| Claim | Status |
|-------|--------|
| Production concurrency is layered: UI / domain / infra / legacy adapter | Interpretation · architecture pattern |
| GCD and Swift Concurrency coexist during migration for years | Fact · industry reality |
| Phased per-module migration beats monolith big bang | Interpretation · engineering strategy |
| Module DoD includes Sendable boundaries, cancel, and tests | Interpretation · ties §D arc |
| Hub «What breaks» maps symptoms to checks | Fact · hub SoT |
| Adapters via continuations bridge legacy callbacks | Fact · Swift Concurrency pattern |
| No invented WWDC numbers or benchmark claims | Scope · intentional |

---

## Passport

1. **What:** production architecture и миграция с GCD после theory arc 0–11.  
2. **Problem:** big bang rewrite и смешение UI/domain/legacy без границ.  
3. **Why:** симптомы freeze/TSan/zombie/duplicate — архитектурные, не «ещё один Task».  
4. **Before:** GCD everywhere · callbacks · manual queue discipline.  
5. **Why not enough:** без adapters и module DoD миграция ломает CI и не снижает races.  
6. **Modern:** layered boundaries · phased strict · measurable DoD.  
7. **Next:** hub labs · Level 3 notes · interview pack.  
8. **Where used:** любое зрелое iOS codebase с legacy networking/UI.

**Fundamental why:** Почему production migration — это границы и фазы, а не «всё на async»?

**H1:** Как жить с concurrency в проде и мигрировать с GCD?

**Анти-цель:** полный GCD→async cookbook · Swift 6 migration manifest · выдуманные метрики.

---

## Критерии приёмки дизайна

- [x] Один why  
- [x] Layers + phased migration before API dump  
- [x] Links hub What breaks · prior §D chapters  
- [x] Термины → Glossary (Sendable, Actor, Task)  
- [x] DoD без «zero GCD overnight»  
- [x] Formal Design Review / Accept (2026-08-03 · Owner · theory v1)

## Phase B log

1. 2026-08-03 — §D unit 3/3; theory v1 capstone under existing `swift/concurrency/`.
