# DESIGN — Зачем Sendable и strict concurrency?

**Статус:** Design + Draft v1 · Owner: Maxim · Phase B §D · 2026-08-03  
**Topic id:** `swift/concurrency/sendable-and-strict-concurrency`  
**Faculty:** Mobile Systems · Swift Concurrency  
**Paths:** ROADMAP M03 §D · after actors + cancellation · before testing  
**Interview Heat:** ★★★★★  
**Levels:** 1–2 обязательны · 3 = escape hatches pointer (nonisolated unsafe / unchecked Sendable)

**Pipeline:** [chapter-fill](../../../.ai/workflows/chapter-fill.md) · [Swift shelf handoff](../../../.author/SWIFT_SHELF_HANDOFF.md)

---

## Claims ledger (before Draft)

| Claim | Status |
|-------|--------|
| Sendable marks types safe to cross isolation domains without data race | Fact · Glossary + Swift Concurrency model |
| Sendable ≠ «all value types are safe» | Fact · teaching model |
| Sendable ≠ «all classes forbidden» | Fact · teaching model |
| Actor protects internal state; Sendable governs boundary crossing | Interpretation · architectural framing |
| Strict concurrency escalates Sendable/isolation checks to errors | Fact · compiler/build settings |
| `@unchecked Sendable` shifts proof burden to author | Fact · language semantics |
| No invented WWDC session numbers or benchmark claims | Scope · intentional |

---

## Passport

1. **What:** зачем Sendable и strict concurrency после actors/isolation.  
2. **Problem:** границы изоляции не закрыты, если non-Sendable бесшумно пересекает Task/actor/MainActor.  
3. **Why:** data races на boundary ловятся поздно без compile-time контракта.  
4. **Before:** «сам следи» + TSan на CI + `@unchecked` как default.  
5. **Why not enough:** isolation внутри actor не спасает shared class в unstructured Task.  
6. **Modern:** Sendable как маркер cross-domain; strict mode как gate в сборке.  
7. **Next:** testing concurrent systems · production migration.  
8. **Where used:** любой async API, Task boundaries, Swift 6 migration.

**Fundamental why:** Почему компилятору нужен Sendable, если actors уже сериализуют доступ?

**H1:** Зачем Sendable и strict concurrency?

**Анти-цель:** полный справочник Sendable conformances · Swift 6 migration runbook · `@unchecked` tourism.

---

## Критерии приёмки дизайна

- [x] Один why  
- [x] Sendable vs actor vs isolation до API dump  
- [x] Не «struct always / class never»  
- [x] Термины → Glossary (Sendable, Actor, Task, Data race)  
- [x] Связь с cancellation (orthogonal axes)  
- [x] Formal Design Review / Accept (2026-08-03 · Owner · theory v1)

## Phase B log

1. 2026-08-03 — §D unit 1/3; theory v1 under existing `swift/concurrency/`.
