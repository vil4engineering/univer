# Concurrency

- **Topic id:** `swift/concurrency`
- **Faculty:** Mobile Systems
- **Path heat:** ROADMAP **M03** (library shelf · not a student checklist)
- **Status:** `learning`
- **Confidence:** 3/5
- **Interview Heat:** ★★★★★
- **Levels present:** 1 / 2 (3 partial in notes)

## Passport

1. **What:** модель параллелизма Swift: `Task`, structured concurrency, actors, isolation, `Sendable`, cooperative cancellation.
2. **Problem:** data races и непредсказуемый shared mutable state на многоядерных устройствах; callback hell и GCD без компиляторных гарантий.
3. **Why it appeared:** ручные очереди/локи не масштабируются для безопасного async API и UI boundaries.
4. **Before:** threads, GCD, OperationQueue, locks — работают, но гонки ловятся поздно.
5. **Why not enough:** нет единой модели cancellation/lifetime; легко «потерять» работу или заблокировать main.
6. **Modern approach:** Swift Concurrency — isolation + structured tasks; compiler assistance (strict concurrency).
7. **Where next:** async testing, SwiftUI observation borders, networking pipelines; AI streaming — отдельные топики.
8. **Where used:** почти любой iOS networking/UI update path, кэши, sync engines.

## Level 1 — Intuition

Один поток правды на кусок состояния (actor / MainActor). Дочерние задачи живут в иерархии родителя (structured). Отмена — кооперативная: проверяй `Task.isCancelled` / `try Task.checkCancellation()`.

Аналогия: ресторан — официант (MainActor) не готовит на плите часами; кухня (background tasks) возвращает блюдо, когда готово.

## Level 2 — Engineering

- **Structured concurrency:** дочерние `Task` / `async let` привязаны к scope; ошибки и cancellation распространяются осмысленно.
- **Unstructured:** `Task { }` с места sync — нужен явный lifetime; `Task.detached` не наследует isolation/`TaskLocal`.
- **Actor:** сериализует доступ к своему состоянию; reentrancy — `await` может «впустить» другую работу.
- **MainActor:** граница UI; тяжёлую синхронную работу туда не класть.
- **Sendable:** разрешение пересекать границы изоляции без data race (не магия immutability для любого `class`).

Default decision: shared mutable state → actor (или immutable value types); UI state → MainActor; long work → off MainActor, hop back.

## What breaks (production)

| Symptom | Check first |
|---------|-------------|
| UI freeze | sync work on MainActor; lock held across await |
| Random crashes / TSan | non-Sendable crossing; unprotected class shared |
| Duplicate requests | unstructured Task without coalescing/cancellation |
| Leak / zombie work | detached or escaped Task after screen dismiss |
| “Impossible” race on actor | reentrancy after await |

Tools: Thread Sanitizer, Instruments (Time Profiler / Points of Interest), `os_signpost`, strict concurrency build settings.

## Interview projection

См. [notes/Interview-Pack.md](notes/Interview-Pack.md) — короткие ответы + ссылки сюда. Не дублировать полное объяснение в bank.

## Reading route (theory 0→12)

Канонический порядок Living-глав. Начни с 0, иди по «Дальше».

| # | Chapter |
|---|---------|
| 0 | [Почему одной очереди дел мало?](why-concurrency-exists/) |
| 1 | [Process и thread](processes-and-threads/) |
| 2 | [Shared state и data race](shared-state-and-races/) |
| 3 | [GCD и callback era](gcd-and-callback-era/) |
| 4 | [Structured concurrency](structured-concurrency/) |
| 5 | [Suspension vs блокировка](async-await-and-suspension/) |
| 6 | [Task / unstructured](tasks-and-unstructured-work/) |
| 7 | [Actors / isolation](actors-and-isolation/) |
| 8 | [MainActor / UI](mainactor-and-ui/) |
| 9 | [Cancellation cooperative](cancellation-and-cooperation/) |
| 10 | [Sendable / strict concurrency](sendable-and-strict-concurrency/) |
| 11 | [Testing concurrent systems](testing-concurrent-systems/) |
| 12 | [Production / GCD migration](production-architecture-and-migration/) |

Owner progress + agent contract: [`.author/SWIFT_SHELF_HANDOFF.md`](../../.author/SWIFT_SHELF_HANDOFF.md).

**Shelf status:** Living route **0→12 CLOSED** as a library book. Next concurrency depth only on explicit Owner path/why — do not invent a volume.

**Share:** `https://vil4labs.github.io/univer/#/swift/concurrency/` · chapter = same base + folder (see [campus/LINKING.md](../../campus/LINKING.md)).

## Materials

- Reading route above (preferred)
- Interview pack: [notes/Interview-Pack.md](notes/Interview-Pack.md)
- Intro digest: [notes/Swift-Concurrency-Intro-Social.md](notes/Swift-Concurrency-Intro-Social.md) — [SwiftConcurrencyPrimer.playground](SwiftConcurrencyPrimer.playground)
- Structured concurrency: [notes/Structured-Concurrency-What-Structured-Means.md](notes/Structured-Concurrency-What-Structured-Means.md) — [StructuredConcurrencyLab.playground](StructuredConcurrencyLab.playground)
- MainActor deep dive (examples): [notes/MainActor-Avanderlee.md](notes/MainActor-Avanderlee.md)
- Image loading lab: [ImageLoadingConcurrencyLab.playground](ImageLoadingConcurrencyLab.playground)
- Actors vs queues: [ActorsQueuesLocksInterview.playground](ActorsQueuesLocksInterview.playground)
- Related: [../async-defer/](../async-defer/) · ROADMAP [M03](../../campus/ROADMAP_SENIOR.md)

## Next

- Prerequisites: M02 Swift (value/ref, ARC mental model)
- Labs: Primer · StructuredConcurrencyLab · ActorsQueuesLocks · ImageLoading
- Follow-ups: §D complete (10–12) · MainActor VM boundaries · Level 3 executors · [legacy archive](notes/legacy-warehouse-archive.md)
- Skills: `interview-preparation` · workflow [`.ai/workflows/interview-prep-session.md`](../../.ai/workflows/interview-prep-session.md)

## Open questions

- [x] Legacy warehouse TL;DR removed from hub (archive under notes/)
- [ ] Level 3 onion: executors / priority — **only** if Owner names a claim (not a queue)
- ~~Evidence playground runs~~ — optional for any reader; not a Publish/agent gate

## Reviewer pass (2026-07-24)

Verdict: **Request changes addressed in passport/L1/L2; Accept for learning bootstrap.**  
Majors fixed: empty level stubs at top replaced with SoT passport.  
Notes (2026-07-24): legacy TL;DR was noisy. **2026-08-03 Owner:** warehouse moved to notes archive; Reading route is SoT. Architect: **keep** `swift/concurrency`.

---

## Hub hygiene (2026-08-03)

Legacy TL;DR / migration dumps **removed from this page** so passport + Reading route stay the only SoT.

Archive (optional depth, **not** second passport): [notes/legacy-warehouse-archive.md](notes/legacy-warehouse-archive.md).

**Forbidden:** restore warehouse TL;DR into this README.
