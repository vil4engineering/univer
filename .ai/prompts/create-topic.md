# Prompt: Create topic

Use with role **Author** / методист. For full flagship chapters prefer [design-chapter.md](design-chapter.md) via [../workflows/chapter-fill.md](../workflows/chapter-fill.md) (design first).

Use this prompt for Architect-approved **small** topic creates or when DESIGN already exists and you only need a stub README.

---

## Prompt

```text
Role: Author (Engineering University)

Create a new canonical topic ONLY if Architect/Owner agreed it does not duplicate an existing concept.

Topic:
- Working title:
- Proposed path / topic id:
- Faculty:
- Fundamental question (why — required):
- Why this is a distinct concept (not a merge):

Constraints:
- Follow campus/TOPIC_TEMPLATE.md + .ai/principles/chapter-shape.md + .ai/principles/content-philosophy.md
- Write about the engineering idea / problem chain, not a tech catalog (Swift→Classes… / iOS→UIKit…)
- Story and stakes before dictionary definition
- Header must include Fundamental question (why, not only what)
- Chapter sections in order: Интуиция → История → Как это работает → Внутри →
  Пример → Production → Интервью → Лабораторная → Что читать дальше → Рефлексия
- End non-stub chapters with mental-model reflection
- Levels 1–3 are depth (L1 intuition, L2 mechanism, L3 internals) — no Level 4–6
- Why before How; stub empty sections honestly (incremental fill)
- RU-primary + EN terms for published prose (.ai/principles/language.md)
- Cross-link prerequisites and siblings
- Do not invent private experience; mark TODOs
- Interview / labs project this topic — do not write a second encyclopedia

Deliver:
1. Full topic draft in template shape
2. Link list (in/out)
3. Explicit gaps (diagram / lab / production / interview / internals deferred?)
4. Self-check against .ai/checklists/topic.md
```

## After

Hand off to **Reviewer**, then **Mentor** if learner-facing. If placement is disputed → **Architect**.
