# Swift shelf handoff (Owner)

**Audience:** authors / agents · **Not Learn chrome**  
**Status:** Binding for Swift shelf work after 2026-08 remediation  
**Date:** 2026-08-03

Read this **before** any Swift shelf / concurrency publication unit.  
External drafts (e.g. ChatGPT-project generation prompts) are **opinion only**. Final decisions live in this repo.

## Binding SoTs (order)

1. [`AGENTS.md`](../AGENTS.md) · identity · Maxim/Timur  
2. [`campus/IA_1.0.md`](../campus/IA_1.0.md) · Learn ≠ Author ≠ Engine  
3. [`.ai/`](../.ai/) principles + workflows (especially chapter-fill, teaching-model, language, writing)  
4. **This handoff** for Swift shelf fences  
5. External prompts — optional input, never co-equal with the above

## 1. Reconciliation contract

| | |
|--|--|
| **Canon now** | Warehouse / faculty tree under [`swift/`](../swift/) (incl. [`swift/concurrency/`](../swift/concurrency/)) |
| **Target maps** (`Library/Swift/…`, AUTHOR.md/GRAPH.md mass scaffold) | Roadmap **opinion** until Owner Design lands **in-repo** |
| **Rename / new root** | Owner Design only — do not soft-fork a second library |

## 2. Definition of Done

**Готово = теория покрыта:** one why, Living prose (`ты`), honest claims, publish-gate sync when DESIGN exists.

Labs, playgrounds, and Path **Evidence write-back** may follow **asynchronously**. Honest Evidence stubs are OK. Do not invent student experience.

## 3. Spines

**Execution Spine** (verbatim in recalls):

`задача → человек → алгоритм → программа → Compiler → Machine Code → CPU → действие в мире`

**Concurrency spine** (conceptual later path): sequential work → scaling limits → threads/shared state → coordination failures → GCD/callbacks → structured concurrency → isolation/sendability → production.

Concurrency chapters must **not** truncate or rewrite the Execution Spine. Cite it when placing Swift on the program step.

## 4. Anti-encyclopedia

- Reusable definitions → [`glossary/`](../glossary/) only.  
- Chapters introduce terms in context and **link**; they do not keep a competing dictionary.  
- Interview Q cards = projection, not a second SoT for ABI/layout folklore.

## 5. Claims ledger (mandatory before Draft of a new unit)

List 5–10 claims that need a primary source or an explicit heuristic/TODO label. Prefer Apple docs, SE proposals, Swift language docs, WWDC sessions, source. Do not invent benchmarks, WWDC outcomes, or toolchain guarantees.

## 6. WIP gate

- One publication unit in flight.  
- Do not start the next unit while Phase A audit blockers are open **unless** residuals are listed explicitly in [`reviews/audits/`](../reviews/audits/).  
- After each unit: library glance (university path · glossary · cross-links · spines) → atomic commit → park ideas → Owner picks next.

## 7. Language

Learn / chapters: **RU-primary + EN terms** — [`campus/LANGUAGE.md`](../campus/LANGUAGE.md).  
Not English-by-default. Interview EN blocks OK. `.ai/` stays English.

## 8. Sequence (this quarter)

1. **Heal canon** (2026-08 remediation T1–T6) — **done** (see audit remediation).  
2. **Expand** concurrency under existing `swift/concurrency/` — **one Living chapter per run**.  
3. No mass-generate of the full concurrency book in one run.

## 8b. Further fill roadmap (in-repo SoT — look here)

Ordered theory units under [`swift/concurrency/`](../swift/concurrency/). Status updates when a unit ships.

| # | Topic id (repo path) | Fundamental why (short) | Status |
|---|----------------------|-------------------------|--------|
| 0 | [`why-concurrency-exists/`](../swift/concurrency/why-concurrency-exists/) | Почему одной очереди дел мало? | **Shipped** 2026-08-03 (theory) |
| 1 | [`processes-and-threads/`](../swift/concurrency/processes-and-threads/) | Зачем OS даёт process/thread — и чем они не равны «concurrency»? | **Shipped** 2026-08-03 (theory) |
| 2 | [`shared-state-and-races/`](../swift/concurrency/shared-state-and-races/) | Почему общее изменяемое состояние ломается без правил? | **Shipped** 2026-08-03 (theory) |
| 3 | [`gcd-and-callback-era/`](../swift/concurrency/gcd-and-callback-era/) | Что дали очереди/callback — и почему этого мало? | **Shipped** 2026-08-03 (theory) |
| 4 | `structured-concurrency/` | Зачем иерархия задач и отмена сверху вниз? | **Next** (notes + StructuredConcurrencyLab) |
| 5 | `async-await-and-suspension/` | Чем suspension отличается от блокировки потока? | Queued |
| 6 | `tasks-and-unstructured-work/` | Когда `Task { }` — инструмент, а когда дырка lifetime? | Queued |
| 7 | `actors-and-isolation/` | Почему isolation, а не «поток на объект»? | Queued |
| 8 | `mainactor-and-ui/` | Зачем граница UI отдельным миром? | Queued |
| 9 | `cancellation-and-cooperation/` | Почему отмена кооперативная? (may absorb `async-defer`) | Queued |
| … | later: sendable, testing, production migration | — | Parking |

**Rhythm (unchanged):** claims ledger → one topic theory (RU-primary) → library glance → atomic commit (+ glossary micro-commit) → stop → Owner confirms next row.

**Do not:** create `Library/Swift/`; skip rows; mass-scaffold empty folders for the whole table.

## 9. Pointers

- Hub: [`swift/concurrency/README.md`](../swift/concurrency/README.md)  
- **Shipped:** [`why-concurrency-exists/`](../swift/concurrency/why-concurrency-exists/) · [`processes-and-threads/`](../swift/concurrency/processes-and-threads/) · [`shared-state-and-races/`](../swift/concurrency/shared-state-and-races/) · [`gcd-and-callback-era/`](../swift/concurrency/gcd-and-callback-era/)  
- **Next unit:** `structured-concurrency/` (roadmap §8b row 4)  
- Related warehouse: [`swift/async-defer/`](../swift/async-defer/) · evolution note [`notes/Concurrency-Evolution-From-Threads-to-Modern-Swift.md`](../swift/concurrency/notes/Concurrency-Evolution-From-Threads-to-Modern-Swift.md) · [GCD.playground](../swift/concurrency/GCD.playground)  
- Playbooks: [chapter-fill](../.ai/workflows/chapter-fill.md) · [improve-topic](../.ai/workflows/improve-topic.md)

## 10. Parking lot (snapshot)

- Broader Glossary vs syntax Q-card anti-encyclopedia pass  
- Promote `async-defer` into cancellation chapter (roadmap #9)  
- `check_library_sync.py` FAILED drift on main  
- `fundamentals/literal-executor` DESIGN-only (no README yet)  
- Evidence write-back for гл.0 when Timur studies  
- Any `Library/Swift/` Design proposal — Owner only, later  
- Formal Accept Reviewer pass for `why-concurrency-exists` DESIGN