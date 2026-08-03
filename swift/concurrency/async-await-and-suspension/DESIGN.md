# DESIGN — Чем suspension отличается от блокировки потока?

**Статус:** Design + Draft v1 · 2026-08-03 · Accept pending  
**Topic id:** `swift/concurrency/async-await-and-suspension`  
**Prev:** [structured-concurrency](../structured-concurrency/)

## Claims ledger

| Claim | Status |
|-------|--------|
| `await` suspends the task; does not necessarily block the OS thread | Fact · Swift concurrency model |
| Blocking (sync wait / heavy sync work) holds a thread | Fact |
| async/await is control-flow sugar over suspension points | Fact / teaching |
| Full executor/priority dump deferred | Scope |

**H1:** Чем suspension отличается от блокировки потока?  
**Why:** Почему «жду» в async-коде не то же самое, что «заморозил поток»?

## Accept

- [x] Один why · не API catalog  
- [ ] Formal Accept (pending)
