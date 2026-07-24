# Principle: Chapter shape

Canonical topic pages share one **chapter shape**. Depth still uses Levels **1–3** (`campus/TOPIC_TEMPLATE.md`) — this principle does **not** invent Level 4–6.

**Stack (do not mix):** [teaching-model.md](teaching-model.md) (*why* we teach) → **this file** (*which sections*) → [`campus/TOPIC_TEMPLATE.md`](../../campus/TOPIC_TEMPLATE.md) (*Markdown chrome*).

Constitution rule 5: **Answer Why before How.**

---

## Fundamental question (required)

Every chapter answers **one fundamental engineering question** — usually a **why**, not a dictionary **what**.

**Binding expansion:** [teaching-model.md](teaching-model.md) — one chapter = one question; ban term-catalog curricula; Execution Spine Foundations module.

| Weak opener | Strong opener |
|-------------|----------------|
| What is ARC? | Why did memory management become a problem computers had to solve? |
| What is an Actor? | Why did plain threads / shared mutable state stop scaling safely? |
| What is SwiftUI? | Why did Apple move away from primarily imperative UI trees? |
| What is programming? (as dictionary) | Why did programming have to exist at all? |

Put the question in the topic **Header**. Passport and Intuition must answer it before API tourism.

**Title must match the question the body answers.** If they diverge, rename (Owner) — do not ship the mismatch.  
On the published page the question is the **H1** (Reader Header) — not a gray “Fundamental question:” label. See [`campus/TOPIC_TEMPLATE.md`](../../campus/TOPIC_TEMPLATE.md).

If you cannot state the why-question, the chapter is not ready to Author beyond a stub.

---

## Chapter sections (stable order)

Use these headings in published RU prose (emoji optional — Docsify-friendly plain titles preferred).

| Section | Intent | Maps to |
|---------|--------|---------|
| **Интуиция** | Why this topic exists; life analogy | Level 1 |
| **История** | How people arrived here (short; explains modern choice) | Passport 3–5 · Evolution |
| **Как это работает** | Mechanism at engineer depth | Level 2 |
| **Внутри** | Under the hood / runtime / trade-offs | Level 3 (earned) |
| **Пример** | Minimal working example | Code / Sandbox |
| **Production** | Real use · failure modes · decisions | What breaks · Decisions |
| **Интервью** | Likely questions · follow-ups · common mistakes | Interview projection |
| **Лабораторная** | Try yourself | Lab / playground / `projects/` link |
| **Конспект** | Plain readable takeaways — **text only, no links inside**. Student re-reads the idea without a wiki of blue underlines. | After practice / before pointers |
| **Упомянуто в главе** | **All** topic pointers live here (and optional первоисточники) — not sprinkled through the body | Related · Next |
| **Что читать дальше** | May merge into Упомянуто; same rule: links only in the footer block | References |
| **Дальше** | **Next chapter only** — not Path Beta/Alpha, faculty, or «часть курса» | Student footer |

Aligns with ROADMAP lesson spine (Problem → … → References) without a second encyclopedia.

### Pointers rule (readability)

```text
Body + Конспект  →  prose only (names of topics OK, no markdown links)
Упомянуто / footer →  all links live here
```

Do **not** sprinkle `[Swift](…)`, `[Execution Spine](…)`, «первый урок» mid-paragraph.  
That turns the chapter into a blue underline wiki and breaks reading flow.  
Header chrome (trajectory / module link once at top) is allowed; body stays readable.

**Building blocks** (Cold open · Axiom · Spine · New model · History · Production · Interview · Level gate): see [teaching-model.md](teaching-model.md) — recognizable style, not a second outline.

---

## Levels (depth on one page)

| Level | Role in chapter |
|-------|-----------------|
| **1** | Интуиция (+ tiny practice) · **may stop at Level gate** |
| **2** | Как это работает · Пример · Production defaults |
| **3** | Внутри · deep trade-offs |

Default study exit: Level 2. Do not invent Level 4–6 headings.  
One multi-layer page > separate beginner/senior courses — [teaching-model.md](teaching-model.md).

---

## Incremental fill

Do **not** fake empty sections. Allowed:

- Stub heading + one sentence + Open question  
- `deferred` on **Внутри** until L3 is earned  
- Interview pack as a linked note that only **projects** this chapter  

Fill order for Mode A prep:

```text
Fundamental question → Интуиция → Как это работает → Пример
  → Интервью (questions) → Лабораторная link
  → История / Production as needed → Внутри when earned
```

---

## Anti-patterns

- Chapter titled only as API glossary (“Список методов URLSession”)
- History longer than the mechanism it explains
- Interview section that re-teaches the whole chapter
- Lab with no link to a real file / playground / project path
- English-only chapter body (see [language.md](language.md))

---

## Related

- [../constitution.md](../constitution.md) (rules 5, 8, 10)
- [teaching-model.md](teaching-model.md)
- [content-philosophy.md](content-philosophy.md)
- [university.md](university.md)
- [writing.md](writing.md)
- `campus/TOPIC_TEMPLATE.md`
- `campus/ROADMAP_SENIOR.md` (lesson template)
- [`../../fundamentals/PART_I.md`](../../fundamentals/PART_I.md)
- `../prompts/create-topic.md`
