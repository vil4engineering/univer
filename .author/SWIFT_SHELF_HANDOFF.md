# Swift shelf — Owner progress plan

**Audience:** authors / agents · **Not Learn chrome**  
**Role:** living **checkbox plan** for Swift shelf + concurrency fill (repo SoT)  
**Updated:** 2026-08-03  
**Cursor note:** this file is the progress UI — not the old remediation-only chat plan.

External ChatGPT-project prompts = **opinion only**. Decisions live here + `AGENTS` / IA / `.ai`.

---

## Progress dashboard

| Phase | State |
|-------|--------|
| A · Audit heal (T1–T6) | Done |
| B · Concurrency theory 0–9 (README) | Done (theory v1) |
| C · Final polish (§ below) | **Not done** ← you are here |
| D · Later books (Sendable / testing / …) | Not started |

**Overall:** theory chain exists; **quality / Accept / sync / polish still open**. Do not treat «Shipped theory» as «finished product».

---

## A. Audit heal (2026-08)

- [x] T1 гл.0 — spine · `ты` · Evidence stub · DESIGN↔0001b
- [x] T2 `what-is-swift` — Human on spine recall
- [x] T3 `method-dispatch` — DESIGN Accept · heuristics
- [x] T4 `syntax` Q42/Q43 — ABI as heuristic
- [x] T5 `async-defer` — toolchain caveat at sample
- [x] T6 Image-Caching + Q35 — unsourced WWDC26 removed
- [x] T7 this handoff created · audit remediation note

---

## B. Concurrency theory units (Living README v1)

Path root: [`swift/concurrency/`](../swift/concurrency/)

- [x] 0 [`why-concurrency-exists/`](../swift/concurrency/why-concurrency-exists/) — почему одной очереди мало
- [x] 1 [`processes-and-threads/`](../swift/concurrency/processes-and-threads/) — process / thread
- [x] 2 [`shared-state-and-races/`](../swift/concurrency/shared-state-and-races/) — shared mutable / data race
- [x] 3 [`gcd-and-callback-era/`](../swift/concurrency/gcd-and-callback-era/) — очереди / callback pain
- [x] 4 [`structured-concurrency/`](../swift/concurrency/structured-concurrency/) — иерархия / отмена вниз
- [x] 5 [`async-await-and-suspension/`](../swift/concurrency/async-await-and-suspension/) — suspension ≠ block thread
- [x] 6 [`tasks-and-unstructured-work/`](../swift/concurrency/tasks-and-unstructured-work/) — `Task { }` lifetime
- [x] 7 [`actors-and-isolation/`](../swift/concurrency/actors-and-isolation/) — isolation ≠ thread-per-object
- [x] 8 [`mainactor-and-ui/`](../swift/concurrency/mainactor-and-ui/) — UI world / MainActor
- [x] 9 [`cancellation-and-cooperation/`](../swift/concurrency/cancellation-and-cooperation/) — cooperative cancel

**Per-unit quality (still open for many chapters):**

- [ ] Formal DESIGN Accept checked for each unit 0–9 (most still `pending Reviewer`)
- [ ] Hub [`README.md`](../swift/concurrency/README.md) reading route matches 0→9 order (polish)
- [ ] Cross-links «Дальше» walked end-to-end without dead ends
- [ ] Glossary terms linked from every unit where introduced
- [ ] Evidence stubs honest; no fake Path write-back

---

## C. Final polish (checkbox backlog — **not finished**)

Run only when Owner says «финальная полировка». One pass; commit locally; push when asked.

### C1 · Catalog / sync

- [ ] `python3 scripts/check_library_sync.py` → OK  
  - [ ] Add `swift/what-is-swift` to [`scripts/topic_tree.py`](../scripts/topic_tree.py)  
  - [ ] Add `ai-engineering/materials` to `TOPIC_TREE` (or document exclusion if intentional)
- [ ] Regenerate library map only if Owner wants tracked `campus/library/README.md` update

### C2 · Anti-encyclopedia / honesty

- [ ] Broader `swift/syntax` Q-card pass (beyond Q42): no competing Glossary definitions
- [ ] Confirm unit 9 ↔ [`async-defer`](../swift/async-defer/) link is enough (or promote cleanup note into cancellation)

### C3 · Foundations gap

- [ ] `fundamentals/literal-executor`: explicit Owner defer note on DESIGN **or** Write README after Approve (no silent Publish)

### C4 · Evidence / study loop

- [ ] гл.0 Evidence: reminder Path write-back when Timur studies (keep stub honest)
- [ ] Optional: same Evidence stub pattern on concurrency units missing it

### C5 · DESIGN Accept sync

- [ ] `why-concurrency-exists/DESIGN.md` Formal Accept
- [ ] `processes-and-threads/DESIGN.md` Formal Accept
- [ ] `shared-state-and-races/DESIGN.md` Formal Accept
- [ ] `gcd-and-callback-era/DESIGN.md` Formal Accept
- [ ] `structured-concurrency/DESIGN.md` Formal Accept
- [ ] `async-await-and-suspension/DESIGN.md` Formal Accept
- [ ] `tasks-and-unstructured-work/DESIGN.md` Formal Accept
- [ ] `actors-and-isolation/DESIGN.md` Formal Accept
- [ ] `mainactor-and-ui/DESIGN.md` Formal Accept
- [ ] `cancellation-and-cooperation/DESIGN.md` Formal Accept

### C6 · Owner-only later (not this polish)

- [ ] Any `Library/Swift/` rename / AUTHOR·GRAPH scaffold — **Owner Design required**
- [ ] Sidebar / IA epic — **not** this file’s job

---

## D. Later concurrency depth (after C)

- [ ] Sendable / strict concurrency chapter
- [ ] Testing concurrent systems
- [ ] Production architecture / migration
- [ ] Interview-pack projection refresh from units 0–9

---

## Binding fences (always on)

### Reconciliation

| | |
|--|--|
| **Canon now** | [`swift/`](../swift/) (incl. concurrency) |
| **Target maps** | Opinion until Owner Design in-repo |
| **No soft-fork** | Do not create parallel `Library/Swift/` |

### DoD

**Готово (theory)** = one why · Living `ты` · honest claims · DESIGN when present.  
**Готово (product)** = theory + Formal Accept + sync OK + polish C checked.  
Labs / Evidence write-back may stay **async**.

### Spines

Execution (verbatim):  
`задача → человек → алгоритм → программа → Compiler → Machine Code → CPU → действие в мире`

Concurrency spine must not truncate Execution Spine.

### Anti-encyclopedia · claims · WIP · language

- Definitions → [`glossary/`](../glossary/)  
- Claims ledger before each new Draft  
- One unit in flight  
- Learn = **RU-primary + EN terms**

### Rhythm

```text
claims ledger → one topic → library glance → atomic commit → update checkboxes here → stop
```

---

## How agents use this file

1. Open **Progress dashboard** + unchecked boxes first.  
2. Do **not** mark C/D done without Owner.  
3. After each ship: tick the box in this file in the same commit.  
4. Final polish = clear every `[ ]` under **C** (except C6).  

**Next Owner command:** «финальная полировка» → start section **C**.
