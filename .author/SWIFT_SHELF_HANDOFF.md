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

1. **Heal canon** (2026-08 remediation T1–T6) — done when audit remediation note says so.  
2. **Expand** one concurrency unit under existing `swift/concurrency/` (prefer earliest gap: why concurrency exists).  
3. No mass-generate of the full concurrency book in one run.

## 9. Pointers

- Hub: [`swift/concurrency/README.md`](../swift/concurrency/README.md)  
- **First Phase B unit (2026-08-03):** [`swift/concurrency/why-concurrency-exists/`](../swift/concurrency/why-concurrency-exists/)  
- Related warehouse note: [`swift/async-defer/`](../swift/async-defer/) (cancellation chapter later)  
- Playbooks: [chapter-fill](../.ai/workflows/chapter-fill.md) · [improve-topic](../.ai/workflows/improve-topic.md)

## 10. Parking lot (snapshot 2026-08-03)

- Broader Glossary vs syntax Q-card anti-encyclopedia pass  
- Promote `async-defer` into a cancellation chapter  
- `check_library_sync.py` FAILED drift on main  
- `fundamentals/literal-executor` DESIGN-only (no README yet)  
- Evidence write-back for гл.0 when Timur studies  
- Any `Library/Swift/` Design proposal — Owner only, later
