# Topic template (v2)

Stable id + passport. Storage path may be Library; shape is academic.

**Stack (do not mix):**

```text
.ai/principles/teaching-model.md  ← why we teach this way
        ↓
.ai/principles/chapter-shape.md   ← which parts a chapter has
        ↓
campus/TOPIC_TEMPLATE.md          ← how it looks in Markdown (this file)
```

Also: [DISPLAY_0.1.md](DISPLAY_0.1.md) (**Student Mode** vs **Author Mode**).

---

## Header — three layers (do not mix)

A flat bullet list of Topic id / Status / Confidence / Fundamental question at the top reads like a **JIRA card**. Split metadata by audience.

### 1. Reader Header (always visible — Student Mode)

Answers only: *What am I studying right now?*

```markdown
<p class="chapter-kicker">Computer Science · Foundations · Execution Spine</p>

# Почему существует программирование?

<p class="chapter-deck">
Программирование — это не написание кода.
Это способ объяснить машине, как решить задачу.
</p>

<p class="chapter-meta">
≈ 20 мин · Interview ★★★ · Beta · Step 1 · Глава 0
</p>
```

Rules:

- **H1 = the chapter question** (usually *why*), not a metadata label  
- One short **deck** (1–2 sentences) — invitation to read  
- One **meta line**: time · interview heat · path step · chapter number  
- No Topic id, Status, Confidence, Owner Approve, Design links in this band  

### 2. Learning Metadata (collapsible — still for learners)

```markdown
<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Computer Science |
| **Path** | Beta · Step 1 · Execution Spine / 0 |
| **Prerequisites** | — |
| **Next** | [Execution Spine](../PART_I.md) (module map) |
| **Interview** | ★★★ |
| **Difficulty** | Easy |
| **Time** | ≈ 20 min |
| **Levels** | 1–2 |

</details>
```

### 3. Engineering Metadata (Author only — bottom of page)

Put under `<details><summary>For contributors</summary>` at the **end** of the chapter — never in Path tables, never above the lesson body.

Do not show DESIGN / review ids / topic id in Student Path UI.

```markdown
<details>
<summary>Engineering · авторы</summary>

| | |
|--|--|
| **Topic id** | `fundamentals/…` |
| **Status** | `learning` |
| **Version** | v1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Review** | link to `reviews/NNNN-…` |
| **Confidence** | — /5 |
| **Assets** | TODO / done |
| **Last updated** | YYYY-MM-DD |

</details>
```

Then optional cold-open quote / intuition hook — then `---` — then chapter body.

### Anti-patterns

- Mixing all three layers into one bullet list under H1  
- Putting **Fundamental question:** as a labeled field when it should *be* the H1  
- Showing Owner Approve / pipeline in Student Mode  
- Academic meta-label *Fundamental question:* instead of inviting prose  

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

Passport must visibly answer the **chapter question (H1)**. Passport detail may live in DESIGN for authors; the published page leads with Reader Header + body.

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

### Конспект

Plain text takeaways — **no links inside**. Reading flow first.

### Упомянуто в главе

**All** topic pointers and первоисточники — here only, not mid-body.  
Do not sprinkle blue links through paragraphs (makes the page unreadable).

### Что читать дальше

Optional; may merge into Упомянуто. Same rule: links only in this footer zone.

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
