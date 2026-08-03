# DESIGN — Как тестировать concurrent код без sleep и флаков?

**Статус:** Design + Draft v1 · Owner: Maxim · Phase B §D · 2026-08-03  
**Topic id:** `swift/concurrency/testing-concurrent-systems`  
**Faculty:** Mobile Systems · Swift Concurrency  
**Paths:** ROADMAP M03 §D · after Sendable · before production migration  
**Interview Heat:** ★★★★  
**Levels:** 1–2 обязательны · 3 = harness/labs pointer

**Pipeline:** [chapter-fill](../../../.ai/workflows/chapter-fill.md) · [Swift shelf handoff](../../../.author/SWIFT_SHELF_HANDOFF.md)

---

## Claims ledger (before Draft)

| Claim | Status |
|-------|--------|
| Wall-clock sleep is unreliable sync barrier in async tests | Fact · engineering commonplace |
| Determinism comes from injected dependencies (protocols), not real time/network | Interpretation · test design pattern |
| Cancellation paths need explicit test scenarios | Fact · links cancellation chapter |
| Async tests should use async/await completion, not polling sleep | Fact · XCTest / Swift Testing model |
| `@MainActor` production code often needs `@MainActor` tests | Fact · isolation rules |
| Thread Sanitizer complements but does not replace contract tests | Interpretation · testing strategy |
| No invented WWDC numbers or benchmark claims | Scope · intentional |

---

## Passport

1. **What:** как тестировать concurrent/async код без sleep и флаков.  
2. **Problem:** wall-clock и real I/O делают тесты недетерминированными; cancel paths не покрыты.  
3. **Why:** регресс на async границах иначе ловится только в проде/TSan.  
4. **Before:** sleep · semaphores · real network в unit.  
5. **Why not enough:** flake budget съедает CI; cancel/zombie work не проверяется.  
6. **Modern:** inject clock/protocols · async tests · cancel scenarios.  
7. **Next:** production architecture / GCD migration.  
8. **Where used:** ViewModels, loaders, search debounce, screen lifecycle.

**Fundamental why:** Почему «подожди секунду» ломает тесты concurrent кода?

**H1:** Как тестировать concurrent код без sleep и флаков?

**Анти-цель:** полный Swift Testing migration guide · catalog every XCTest API · integration test encyclopedia.

---

## Критерии приёмки дизайна

- [x] Один why  
- [x] Inject/determinism before tool catalog  
- [x] Cancellation test path explicit  
- [x] Термины → Glossary (Task, Data race where relevant)  
- [x] Link Sendable chapter as prerequisite  
- [x] Formal Design Review / Accept (2026-08-03 · Owner · theory v1)

## Phase B log

1. 2026-08-03 — §D unit 2/3; theory v1 under existing `swift/concurrency/`.
