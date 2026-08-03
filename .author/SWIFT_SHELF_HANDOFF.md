# Swift shelf — Owner progress plan

**Audience:** authors / agents · **Not Learn chrome**  
**Role:** living **checkbox plan** for Swift shelf + concurrency fill (repo SoT)  
**Updated:** 2026-08-03 (§D + residuals close)  
**Cursor note:** this file is the progress UI — not the old remediation-only chat plan.

External ChatGPT-project prompts = **opinion only**. Decisions live here + `AGENTS` / IA / `.ai`.

---

## Progress dashboard

| Phase | State |
|-------|--------|
| A · Audit heal (T1–T6) | Done |
| B · Concurrency theory 0–9 + §B quality | Done |
| C · Final polish | Done 2026-08-03 |
| D · Later books (Sendable / testing / …) | **Done** theory v1 2026-08-03 |

**Rule (Owner):** A + B before C. C closed. **D** shipped (theory 10–12). Further depth only on new Owner ask.

Closeout report: [`reviews/audits/2026-08-concurrency-shelf-closeout.md`](../reviews/audits/2026-08-concurrency-shelf-closeout.md).  
Dual-pass journal: [`reviews/0002-concurrency-theory-chain.md`](../reviews/0002-concurrency-theory-chain.md).

---

## A. Audit heal (2026-08)

- [x] T1 гл.0 — spine · `ты` · Evidence stub · DESIGN↔0001b
- [x] T2 `what-is-swift` — Human on spine recall
- [x] T3 `method-dispatch` — DESIGN Accept · heuristics
- [x] T4 `syntax` Q42/Q43 — ABI as heuristic
- [x] T5 `async-defer` — toolchain caveat at sample
- [x] T6 Image-Caching + Q35 — unsourced WWDC26 removed
- [x] T7 this progress plan created · audit remediation note

---

## B. Concurrency theory units (Living README v1)

Path root: [`swift/concurrency/`](../swift/concurrency/)

- [x] 0 [`why-concurrency-exists/`](../swift/concurrency/why-concurrency-exists/)
- [x] 1 [`processes-and-threads/`](../swift/concurrency/processes-and-threads/)
- [x] 2 [`shared-state-and-races/`](../swift/concurrency/shared-state-and-races/)
- [x] 3 [`gcd-and-callback-era/`](../swift/concurrency/gcd-and-callback-era/)
- [x] 4 [`structured-concurrency/`](../swift/concurrency/structured-concurrency/)
- [x] 5 [`async-await-and-suspension/`](../swift/concurrency/async-await-and-suspension/) · **v1.1 depth**
- [x] 6 [`tasks-and-unstructured-work/`](../swift/concurrency/tasks-and-unstructured-work/) · **v1.1 depth**
- [x] 7 [`actors-and-isolation/`](../swift/concurrency/actors-and-isolation/) · **v1.1 depth**
- [x] 8 [`mainactor-and-ui/`](../swift/concurrency/mainactor-and-ui/) · **v1.1 depth**
- [x] 9 [`cancellation-and-cooperation/`](../swift/concurrency/cancellation-and-cooperation/) · **v1.1 depth**

### B quality (finish before polish C)

- [x] Formal DESIGN Accept for units 0–9 (Owner 2026-08-03 · theory v1)
- [x] Hub [`README.md`](../swift/concurrency/README.md) **Reading route 0→9** (extended 0→12 in D)
- [x] Cross-links «Дальше» walked 0→9→hub (now 0→12→hub)
- [x] Glossary terms for core chain (Concurrency · Parallelism · Process · Thread · Data race · + existing actor/task/…)
- [x] Evidence stubs honest on all units 0–9

**B gate:** when all above `[x]` → Owner may start **C**.

---

## C. Final polish (**done** 2026-08-03)

- [x] `check_library_sync.py` → OK
- [x] Broader `swift/syntax` Q-card anti-encyclopedia pass
- [x] `async-defer` ↔ unit 9 cleanup note tightened
- [x] `literal-executor`: **Write README** + sidebar + PART_I + TOPIC_TREE (residual closed 2026-08-03)
- [x] гл.0 Evidence Path reminder for Timur
- [x] Evidence stubs on units 0–9 (done in B)
- [x] DESIGN Accept 0–9 (done in B)
- [x] Hub legacy warehouse → [`notes/legacy-warehouse-archive.md`](../swift/concurrency/notes/legacy-warehouse-archive.md)
- [ ] `Library/Swift/` / IA — Owner Design only (still out)

---

## D. Later concurrency depth (**done** theory v1 2026-08-03)

- [x] Sendable / strict concurrency — [`sendable-and-strict-concurrency/`](../swift/concurrency/sendable-and-strict-concurrency/)
- [x] Testing concurrent systems — [`testing-concurrent-systems/`](../swift/concurrency/testing-concurrent-systems/)
- [x] Production architecture / migration — [`production-architecture-and-migration/`](../swift/concurrency/production-architecture-and-migration/)
- [x] Interview-pack projection refresh from units 0–12
- [x] Dual-pass style journal [`reviews/0002-concurrency-theory-chain.md`](../reviews/0002-concurrency-theory-chain.md)

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
2. Do **not** start **C** until **B** is fully `[x]`.  
3. After each ship: tick the box in this file in the same commit.  
4. Final polish = section **C** only when Owner says so.  

**Next Owner command:** Timur study route 0→12 + Path Evidence · or new claims (executors / AsyncStream / …).
