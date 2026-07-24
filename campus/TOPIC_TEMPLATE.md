# Topic template (v2)

Stable id + passport. Storage path may be Library; shape is academic.  
Chapter sections + why-first rule: [`.ai/principles/chapter-shape.md`](../.ai/principles/chapter-shape.md).

---

## Header

- **Topic id:**
- **Faculty:**
- **Path heat:**
- **Status:** `not_started` | `learning` | `practicing` | `interview_ready` | `mastered`
- **Confidence:** /5
- **Interview Heat:** ★…
- **Levels present:** 1 / 2 / 3
- **Fundamental question (why):**  
  e.g. *Why did plain threads / shared mutable state stop scaling safely?* — not only *What is an Actor?*

---

## Passport

1. What is it?  
2. Problem it solves  
3. Why the problem appeared  
4. What came before  
5. Why that was not enough  
6. Modern approach  
7. Where next (incl. AI when relevant)  
8. Where used  

History / lore only if it answers passport 3–5. North-star gate: *Does this help understand the engineering world?* Cut the rest.

Passport must visibly answer the **Fundamental question**.

---

## Evolution (then → now)

Short strip, not a legacy course. Show why the modern API looks the way it does.

Example shape: `NSURLConnection` → `URLSession` → `async/await` · or `UIButton` → `Configuration` → `SwiftUI Button`.

Link Sandbox / Evolution files if they exist outside the app target ([CODE_CONTRACT.md](CODE_CONTRACT.md)).

---

## Chapter body

Stable section order (emoji optional). Stub empty parts honestly — incremental fill ([OPERATING_MODES.md](OPERATING_MODES.md)).

### Интуиция

Why this exists · analogy (Level 1).

### История

How people arrived at this solution (short).

### Как это работает

Mechanism (Level 2 default).

### Внутри

Under the hood (Level 3 — earned; may be `deferred`).

### Пример

Minimal working example (code cite).

### Production

Real projects · what breaks · decision rules.

### Интервью

Questions · follow-ups · common mistakes (projection; may link `notes/Interview-Pack.md`).

### Лабораторная

Mission + playground / `projects/` / lab id.

### Что читать дальше

Apple · Swift Evolution · WWDC · books · articles.

### Рефлексия (обязательно, когда глава не stub)

> Что изменилось в твоём понимании после этой главы?  
> Не «запомнил ли определения», а как сдвинулась ментальная модель.

Philosophy: [`.ai/principles/content-philosophy.md`](../.ai/principles/content-philosophy.md).

---

## Levels (depth, not a second outline)

| Level | Role in chapter |
|-------|-----------------|
| **1** | Интуиция (+ tiny practice) |
| **2** | Как это работает · Пример · Production defaults |
| **3** | Внутри · deep trade-offs |

Default study exit: Level 2. Do not invent Level 4–6 headings.

---

## Completeness

- [ ] Understand  
- [ ] Explain  
- [ ] Demonstrate  
- [ ] Practice  
- [ ] Reuse  
- [ ] Teach (when applicable)

---

## Visual & practice (Pages DoD)

Aim for these when marking a topic toward `interview_ready` / `mastered` (browser-first):

- [ ] Diagram or process scheme  
- [ ] Life analogy (required for Level 1)  
- [ ] Code (Reference World / lab / Sandbox cite)  
- [ ] Experiment (“what if…”) or intentional failure → fix  
- [ ] Self-check / quiz  
- [ ] Official links (Apple Docs · WWDC · Evolution as applicable)  

No topic is complete without practice.

---

## English for Interview (optional block)

Key terms: …  
Spoken answer sketch (EN): …

---

## Evidence

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise  

## Skills used

(e.g. `wwdc-deepdive`, `architecture-review`)

## Open questions

Leave **unanswered** on the page. Forge answers in chat / mock interview, then write Evidence back ([OPERATING_MODES.md](OPERATING_MODES.md)).

## Next

Prerequisites · follow-ups · Lab ids · related Skills · related Engineering Patterns / symptoms (if any)
