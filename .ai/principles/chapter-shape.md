# Principle: Chapter shape

Canonical topic pages share one **chapter shape**. Depth still uses Levels **1–3** (`campus/TOPIC_TEMPLATE.md`) — this principle does **not** invent Level 4–6.

Constitution rule 5: **Answer Why before How.**

---

## Fundamental question (required)

Every chapter answers **one fundamental engineering question** — usually a **why**, not a dictionary **what**.

| Weak opener | Strong opener |
|-------------|----------------|
| What is ARC? | Why did memory management become a problem computers had to solve? |
| What is an Actor? | Why did plain threads / shared mutable state stop scaling safely? |
| What is SwiftUI? | Why did Apple move away from primarily imperative UI trees? |

Put the question in the topic **Header**. Passport and Intuition must answer it before API tourism.

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
| **Что читать дальше** | Apple · Evolution · WWDC · books · articles | References · Next |

Aligns with ROADMAP lesson spine (Problem → … → References) without a second encyclopedia.

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
- [content-philosophy.md](content-philosophy.md)
- [university.md](university.md)
- [writing.md](writing.md)
- `campus/TOPIC_TEMPLATE.md`
- `campus/ROADMAP_SENIOR.md` (lesson template)
- `../prompts/create-topic.md`
