# Principle: Teaching model

**Binding pedagogical architecture** for Engineering University.

This is a **key SoT** next to content philosophy: *why we teach this way*.

```text
teaching-model.md     ← why we teach this way (pedagogy)
        ↓
chapter-shape.md      ← which parts a chapter has (sections)
        ↓
campus/TOPIC_TEMPLATE.md  ← how it looks in Markdown (Reader / Learning / Engineering)
```

Do not mix the three layers.  
Quality feel: [content-philosophy.md](content-philosophy.md).  
Reviews: [`reviews/`](../../reviews/) · [../checklists/chapter-review.md](../checklists/chapter-review.md).

Expands constitution rule 5 (**Why before How**).

---

## One chapter = one fundamental question

Every chapter **answers one fundamental engineering question**.

It does **not** “cover a topic” or “define a term.”

| Weak (dictionary / term chapter) | Strong (problem chapter) |
|----------------------------------|---------------------------|
| Memory Management | Why does memory run out? |
| Compiler | Why doesn’t the computer understand Swift? |
| Operating System | Why can’t programs talk to hardware directly? |
| Networking | Why can two computers understand each other at all? |
| SwiftUI | Why did declarative UI become possible only now? |
| What is a variable? | (Usually not a chapter — a concept inside a why) |

**H1** invites the reader; **fundamental why** (Learning Metadata) may be the sharper problem form.  
Example — Part I / 0: H1 *Почему существует программирование?* · why *Почему компьютеру вообще нужны программы?*

If prose answers *why* but H1 says dictionary *what*, rename (Owner) — do not leave the mismatch.

---

## Knowledge appears only when the reader needs it

**Principle:** introduce a concept only after the reader feels the problem it solves.

```text
Pain / question first
  → then the noun (Compiler, Actor, OS, …)
```

| Textbook habit | University habit |
|----------------|------------------|
| “A Compiler is…” | “Why doesn’t the computer understand Swift?” → then Compiler |
| Term list as spine | Problem chain as spine |

Russian: **понятие вводят только тогда, когда читатель уже понял проблему, которую оно решает.**

If this holds across the catalog, chapters become one pedagogical system — not a pile of good articles.

---

## Anti-pattern: term catalog curricula

Most textbooks look like:

```text
What is a variable → function → class → object → …
```

That is a **dictionary**. Concepts appear because the syllabus listed a noun.

Here, each new idea appears as an **answer to a problem** that previous pages made painful.

---

## Chapter spine (stable pedagogy)

Local RU headings: [chapter-shape.md](chapter-shape.md). Pedagogy order:

```text
Emotional / concrete open
  → Problem
  → Why it appeared (history short — pain, not name list)
  → Idea
  → How it works
  → Abstractions (cost of hiding)
  → Production bridge
  → Interview projection
  → Practice
  → Mental model before → after
  → Next chapter (graph)
```

Flagship chapters should also carry:

- One **spine diagram** reusable in the module  
- **Software / Hardware** (or equivalent) when later OS/platform chapters need the nouns  

---

## Part I — Foundations (module spine)

| # | Working title (H1) | Fundamental why | Planned topic id | Status |
|---|--------------------|-----------------|------------------|--------|
| 0 | Почему существует программирование? | Почему компьютеру вообще нужны программы? | `fundamentals/what-is-programming` | **v1.1** |
| 1 | Что такое компьютер? | Почему нам нужен буквальный исполнитель? | `fundamentals/what-is-a-computer` | planned |
| 2 | Как компьютер исполняет программу? | Почему инструкция превращается в действие в мире? | `fundamentals/how-computer-runs-a-program` | planned |
| 3 | Binary | Почему компьютеры понимают только Binary? | `fundamentals/binary` | planned |
| 4 | Machine Code | Почему CPU не исполняет текст программы «как есть»? | `fundamentals/machine-code` | planned |
| 5 | Assembly | Почему появился язык ближе к человеку, но ещё у железа? | `fundamentals/assembly` | planned |
| 6 | Compiler | Почему компьютер не понимает Swift? | `fundamentals/compiler` | planned |
| 7 | Алгоритмы | Почему недостаточно «сказать примерно, что делать»? | `fundamentals/algorithms` | planned |
| 8 | Языки программирования | Почему языков много, а идея одна? | `fundamentals/programming-languages` | planned |
| 9 | Что значит быть Software Engineer? | Почему «написать код» недостаточно? | `fundamentals/what-is-a-software-engineer` | planned |

**Strict dictionary** “what is programming?” comes **after** executor, instruction, algorithm, program. Chapter 0 creates the *need*.

Human map: [`fundamentals/PART_I.md`](../../fundamentals/PART_I.md).  
Do **not** mass-create empty topics — [chapter-fill](../workflows/chapter-fill.md) only.

---

## Naming rule

1. Pick the **why-question** first.  
2. H1 should make the reader expect that answer (invitation OK if Learning Metadata holds the sharper why).  
3. Folder slug may stay stable English; rename later when Part I stabilizes (Architect if links explode).  
4. Paths / catalog follow the **why title**, not the old dictionary name.

---

## Related

- [content-philosophy.md](content-philosophy.md) — key sibling SoT (ideas over tech)
- [chapter-shape.md](chapter-shape.md) — sections
- [`../../campus/TOPIC_TEMPLATE.md`](../../campus/TOPIC_TEMPLATE.md) — Markdown chrome
- [university.md](university.md)
- [../constitution.md](../constitution.md) (rule 5)
- [`../../fundamentals/PART_I.md`](../../fundamentals/PART_I.md)
