# Principle: Writing

## Style

- Be concise. Cut unnecessary adjectives.
- Prefer precise engineering language.
- Avoid AI-sounding filler and generic hype.
- Support statements with evidence when possible.
- Separate: Facts | Interpretations | Opinions | Speculation.
- Never present speculation as fact.
- Prefer **story + stakes** over reference-manual tone ([content-philosophy.md](content-philosophy.md)).

## Living chapter prose (Owner-ratified)

Published Learning chapters keep the stable [chapter-shape](chapter-shape.md) sections, but the **voice inside those sections** must feel alive — spoken to Timur at the table, not a lecture or handbook.

**Target feel:** short paragraphs, concrete images, everyday verbs, few unexplained heavy terms. Shape stays; language gets lighter.

| Do | Do not |
|----|--------|
| 1–3 sentence paragraphs; cut filler | Lecture cadence, long textbook blocks |
| Concrete picture before abstract noun (box, switch, friend) | Open with dictionary / API tourism |
| Explain a hard term in plain words — or defer / cut | Drop jargon (Fetch-Decode-Execute dump, ISA, race catalog) without a bridge |
| Keep `ты` and warm direct address ([language.md](language.md)) | Formal `вы`, marketing plural, AI hype |
| **Внутри** / **Production** — light bridge or honest stub | Fake depth that belongs to a later chapter |
| Production = one engineer habit (e.g. “hole in the instruction”) | Bug-class catalogs that bury the habit |
| One clear mental-model punch per section | Second why, encyclopedia asides, “as we will see later” padding |

**Depth rule:** Levels still earn **Внутри** (L3). Prefer a short, vivid bridge over a miniature next-chapter. If the next Spine chapter owns the idea (e.g. Binary), stop at the door.

**Reference feel (not a template to copy):** Owner-approved tone for `fundamentals/literal-executor` — lively, short, almost no unexplained jargon; Production as “look for the hole in the instruction.”

Reviewer: fail **Beginner** gate when the chapter is accurate but reads like a dry lecture or unexplained term stack. See [review-criteria.md](review-criteria.md).

## Educational checks

Before finishing a section, ask:

- What misconception may the reader have?
- What prerequisite is missing?
- Can this be visualized?
- Can it be implemented?
- Can it be measured?
- Can it be debugged?

## Language (published content)

See [language.md](language.md) (Language Policy).

Short form:

- Campus / path / faculty / topic pages: **RU-primary** prose + **EN terms** as-is.
- Do not invent artificial translations of industry terms.
- Do not create dual EN+RU mirrored encyclopedias.
- Optional Interview English blocks for spoken answers — not a full page twin.
- `.ai/` governance docs stay English (agent operating language).
- Campus SoT: `campus/LANGUAGE.md`.

## Topic shape

Follow `campus/TOPIC_TEMPLATE.md` + [chapter-shape.md](chapter-shape.md):

- Header + **Fundamental question (why)** + passport
- Chapter sections (Интуиция … Что читать дальше)
- Levels 1–3 as depth
- Completeness / visual & practice / Evidence
- Open questions and Next (prerequisites, labs, skills)

## Do not

- Invent personal production experience or private career facts
- Write interview “answers” that introduce a second full explanation
- Stop at definition-only pages for important concepts
- Use framework cookbooks as a substitute for concepts

## Related

- [language.md](language.md)
- [chapter-shape.md](chapter-shape.md)
- [content-philosophy.md](content-philosophy.md)
- [university.md](university.md)
- [../roles/author.md](../roles/author.md)
- [../roles/mentor.md](../roles/mentor.md)
