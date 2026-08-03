# Swift shelf — Owner progress + agent contract

**Audience:** authors / agents · **Not Learn chrome**  
**Role:** living checkbox SoT for Swift shelf + **library fill contract**  
**Updated:** 2026-08-03 (fragile spots closed · library framing)  

External ChatGPT-project prompts = **opinion only**. Decisions live here + `AGENTS` / IA / `.ai`.

---

## Product framing (Owner)

Эта полка — **библиотека глав**, которые можно открыть по ссылке (браузер или агент) и разобраться в теме.  

**Не** учебный план Тимура. **Не** Path Evidence как гейт. Читатель учится когда может; Owner наполняет полку.

Shareable entry: hub Reading route → конкретная глава `README.md` (см. [campus/LINKING.md](../campus/LINKING.md)).

---

## Progress dashboard

| Phase | State |
|-------|--------|
| A · Audit heal (T1–T6) | Done |
| B · Concurrency theory 0–9 + §B quality | Done |
| C · Final polish | Done |
| D · Sendable / testing / production | Done (theory v1) |

**Concurrency Living book 0→12: CLOSED.**  
Дальше concurrency — **только** если Owner назвал явный topic path / H1. Не выдумывать «том 2».

Closeout: [`reviews/audits/2026-08-concurrency-shelf-closeout.md`](../reviews/audits/2026-08-concurrency-shelf-closeout.md).  
Accept journal: [`reviews/0002-concurrency-theory-chain.md`](../reviews/0002-concurrency-theory-chain.md).

---

## A–D checkboxes (historical)

### A. Audit heal

- [x] T1–T7 (гл.0 · what-is-swift · method-dispatch · syntax · async-defer · Image-Caching · this plan)

### B. Theory 0–9

- [x] Units 0–9 under [`swift/concurrency/`](../swift/concurrency/) · v1.1 depth on 5–9  
- [x] Hub Reading route · Дальше chain · Glossary · Formal Accept theory

### C. Polish

- [x] library sync · syntax anti-encyclopedia · async-defer ↔ cancel · literal-executor Write · hub warehouse archived  
- [ ] `Library/Swift/` soft-fork — **forbidden** without Owner Design

### D. Depth 10–12

- [x] Sendable · testing · production · Interview-pack · review 0002

---

## Binding fences (fragile spots — CLOSED)

### 1. No automatic «next chapter»

| | |
|--|--|
| **Closed book** | Concurrency 0→12 done |
| **Agent** | Without Owner naming `path` + why → **stop**. Do not invent executors/AsyncStream/«том» |
| **Parked ideas** | Level 3 executors / priority — claim only, not a queue |

### 2. Accept levels (do not confuse)

| Level | Meaning |
|-------|---------|
| **Owner Formal Accept (theory)** | DESIGN + Living README ship; risk accepted for library study |
| **Reviewer dual-pass (`reviews/NNNN`)** | Four gates + ten criteria (эталон: 0001b) |
| **Batch 0002** | Concurrency chain Accept at library bar — **not** per-unit 0001b |

Do not claim «0001b-level Accept» unless a per-topic review journal exists.

### 3. Hub SoT vs archive

| SoT | Not SoT |
|-----|---------|
| Passport · Reading route · Materials | [`notes/legacy-warehouse-archive.md`](../swift/concurrency/notes/legacy-warehouse-archive.md) |

**Forbidden:** paste TL;DR warehouse back into hub `README.md`.

### 4. Library DoD (Publish)

**Готово для ссылки** = one why · Living `ты` · honest claims · `README.md` opens on Pages · Дальше/hub wired · DESIGN when used.

**Не гейт:** Path logs · Evidence checkboxes · «Тимур прошёл» · lab runs.

Evidence block on a page = optional self-check for the **reader**, not an agent todo and not a student flag.

### 5. `TOPIC_TREE` / sync

[`scripts/check_library_sync.py`](../scripts/check_library_sync.py) sees only **section / top-level topic** folders with `README.md` (e.g. `swift/concurrency`).  

Nested Living units (`swift/concurrency/sendable-…`) are **not** tree rows.  

New **top-level** topic → add to `scripts/topic_tree.py` before claiming sync OK.

### 6. Architecture fence

«Заполни тему» ≠ менять `_sidebar.md`, IA, `.ai/` constitution, or create `Library/Swift/`.  
Sidebar/IA only with explicit Owner Design.

### 7. Git remotes

| | |
|--|--|
| **This clone `origin`** | `https://github.com/vil4labs/univer.git` — verify `git remote -v` before push |
| **Public product names** | org / Pages = `vil4labs` (see AGENTS · LINKING) |

Do not invent push target from AGENTS slug alone.

### 8. Claims honesty

No invented WWDC session IDs, benchmarks, or toolchain guarantees.  
Definitions → [`glossary/`](../glossary/) with `eu-term`.

---

## Rhythm (fill next topic)

Owner must give: **path** · **H1 / why** · Approve if DESIGN-first.

```text
claims ledger → DESIGN (if new) → Owner Approve → one README
  → Дальше / hub / glossary glance
  → topic_tree + check_library_sync (only if new top-level)
  → tick this file if shelf progress changed → stop
```

**Stop** after one topic. No multi-chapter «plans». No auto-continue.

Playbook: [`.ai/workflows/chapter-fill.md`](../.ai/workflows/chapter-fill.md).

---

## How agents use this file

1. Read **Product framing** + **dashboard** + **fences**.  
2. If concurrency unchecked work is gone — shelf closed; ask Owner for the next **named** topic.  
3. Never use a person (Тимур) as a progress gate.  
4. Ship linkable library pages; commit/push only when Owner asks.
