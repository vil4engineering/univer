# DESIGN — Зачем программе process и thread?

**Статус:** Design + Draft v1 · Owner: Maxim · 2026-08-03 · Accept pending Reviewer  
**Topic id:** `swift/concurrency/processes-and-threads`  
**Faculty:** Mobile Systems · Swift Concurrency  
**Paths:** after [why-concurrency-exists](../why-concurrency-exists/) · before shared-state  
**Interview Heat:** ★★★★  
**Levels:** 1–2 · L3 лёгкий мост (не scheduler dump)

**Pipeline:** [chapter-fill](../../../.ai/workflows/chapter-fill.md) · [handoff §8b](../../../.author/SWIFT_SHELF_HANDOFF.md)

---

## Claims ledger

| Claim | Status |
|-------|--------|
| Process = адресное пространство + ресурсы OS | Fact · OS teaching commonplace |
| Thread = единица планирования CPU внутри process | Fact · simplify; label heuristic on scheduling details |
| Thread ≠ definition of concurrency | Fact · continues prior chapter |
| Main thread / UI thread is a convention + platform rule, not magic | Fact · iOS UIKit/AppKit expectation |
| Creating raw `Thread` freely is rarely the modern default | Recommendation · prefer higher abstractions later |

---

## Passport

**Fundamental why:** Почему OS даёт process и thread — и почему это ещё не «Swift Concurrency»?

**H1:** Зачем программе process и thread?

**Анти-цель:** GCD API · actors · Thread API cookbook · полный OS course.

## Критерии приёмки дизайна

- [x] Один why  
- [x] Process vs thread до API tourism  
- [x] Связь с why-concurrency-exists  
- [x] Не учить GCD/actors здесь  
- [x] Glossary Process / Thread  
- [x] Formal Accept (2026-08-03 · Owner · theory v1)
