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
| **Интуиция** | Cold open · stakes · first life image | Level 1 |
| **История** | Pain → why the idea appeared (short) | Passport · Evolution |
| **Ментальная модель** | **Required** when past stub — structured model (below) | Level 1–2 bridge |
| **Как это работает** | Mechanism at engineer depth | Level 2 |
| **Внутри** | Under the hood / runtime / trade-offs | Level 3 (earned) |
| **Пример** | Minimal working example | Code / Sandbox |
| **Production** | Real use · failure modes · decisions | What breaks · Decisions |
| **Ошибочные модели** | **Required** when past stub — ❌ wrong vs ✅ right | Interview / Beginner gate |
| **Интервью** | Likely questions · follow-ups | Interview projection |
| **Лабораторная** | Try yourself | Lab / playground / `projects/` link |
| **Конспект** | Plain readable takeaways — **text only, no markdown links** | After practice |
| **Дальше** | **Next chapter only** | Student footer |

No «Упомянуто» dump at chapter end. Dictionary terms → **Glossary**.

### Ментальная модель (required shape)

Not a second essay. Short structured block after История (or merged into Интуиция only if the chapter is tiny — prefer the named heading).

| Slot | Asks |
|------|------|
| Проблема | What pain forced this idea? |
| Аналогия | Plant · warehouse · post · conveyor · library · city · orchestra… |
| Инженерная модель | How it looks in Computer Science |
| Swift / iOS | Illustration only — not the definition |
| Почему лучше | Why this beat the previous solution |

**Depth test (binding):** if you cannot explain the topic through a life analogy *and* a causal history, the chapter is not ready — you have not understood it deeply enough yet. Analogies outlive API churn (Timur / next decade).

Pedagogy order (anti-catalog):

```text
Problem → History → Analogy → Architecture → Implementation → Production → Interview
```

Not: Definition → API → code sample.

### Ошибочные модели (required shape)

Table or short pairs:

| ❌ Wrong | ✅ Right |
|----------|----------|
| … | … |

Catch dictionary myths (e.g. “Stack is where structs live”) before Interview.

### Term → Glossary rule

```text
Body prose stays readable.
Term needs a digression → <a class="eu-term" href="…/glossary/#glossary-rest">REST</a>
  (subtle shade; tap goes straight to Glossary — same hub as sidebar)
Конспект → no links
Footer → only «Дальше: next chapter»
```

Do **not** sprinkle ordinary blue wiki links. Do **not** park a glossary dump at the bottom of every chapter.  
Canonical short defs: [`glossary/README.md`](../../glossary/README.md) (A–Z + Domain).
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
Fundamental question → Интуиция → История → Ментальная модель
  → Как это работает → Ошибочные модели → Пример
  → Интервью (questions) → Лабораторная link
  → Production as needed → Внутри when earned
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
