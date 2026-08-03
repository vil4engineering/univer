# DESIGN — Почему одной «очереди дел» на процессоре стало мало?

**Статус:** Design + Draft v1 · Owner: Maxim · Phase B authorized via remediation plan 2026-08-03 · Accept pending Reviewer  
**Topic id:** `swift/concurrency/why-concurrency-exists`  
**Faculty:** Mobile Systems · Swift Concurrency  
**Paths:** ROADMAP M03 entry · after Swift basics · before threads/GCD deep dives  
**Interview Heat:** ★★★★  
**Levels:** 1–2 обязательны · 3 = лёгкий мост (не GCD/actors dump)

**Pipeline:** [chapter-fill](../../../.ai/workflows/chapter-fill.md) · [Swift shelf handoff](../../../.author/SWIFT_SHELF_HANDOFF.md)

---

## Claims ledger (before Draft)

| Claim | Status |
|-------|--------|
| Concurrency ≠ parallelism | Fact · Glossary + this chapter |
| Single core + blocking work hurts responsiveness | Fact · engineering commonplace; measure UI jank when asserting numbers |
| Multi-core phones made shared mutable state painful | Interpretation · historical framing |
| Threads are one mechanism, not the definition of concurrency | Fact · teaching model |
| GCD / actors / structured concurrency deferred to later chapters | Scope · intentional |

---

## Passport

1. **What:** почему concurrency вообще появилась как инженерная необходимость.  
2. **Problem:** одна линия исполнения не успевает за I/O, UI и несколькими ядрами без модели организации работы.  
3. **Why:** пользователь ждёт отзывчивости; железо даёт ядра; наивный shared state ломается.  
4. **Before:** «всё по порядку» на одном потоке мысли.  
5. **Why not enough:** блокировки, гонки, callback chaos — симптомы, не глава API.  
6. **Modern:** concurrency как *организация* работы; parallelism как *одновременное* исполнение.  
7. **Next:** processes/threads · shared state · GCD era · structured concurrency (hub notes/labs).  
8. **Where used:** любой iOS networking/UI path.

**Fundamental why:** Почему одной последовательной линии исполнения стало мало для реальных приложений?

**H1:** Почему одной «очереди дел» на процессоре стало мало?

**Анти-цель:** каталог `async`/`await` · actors · GCD API tourism · «concurrency = threads».

---

## Критерии приёмки дизайна

- [x] Один why  
- [x] Concurrency vs parallelism до API  
- [x] Execution Spine не урезан  
- [x] Не pre-explain actors/GCD  
- [x] Термины → Glossary  
- [x] Formal Design Review / Accept (2026-08-03 · Owner · theory v1)

## Phase B log

1. 2026-08-03 — first Phase B unit after remediation; theory chapter under existing `swift/concurrency/`.
