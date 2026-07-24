# Principle: Teaching model

**Primary pedagogy SoT of Engineering University** — the document that should still govern chapter 100.

This is not a style guide. It answers *why chapters are built this way*.

Sibling key SoTs:

| Doc | Answers |
|-----|---------|
| **This file** | Why we teach this way |
| [content-philosophy.md](content-philosophy.md) | What “good knowledge” feels like (ideas > tech) |
| [review-criteria.md](review-criteria.md) | How we score a chapter |
| [content-lifecycle.md](content-lifecycle.md) | How a chapter moves from idea to Evidence |

Presentation stack (do not mix):

```text
teaching-model.md           ← why we teach this way
        ↓
chapter-shape.md            ← which parts a chapter has
        ↓
campus/TOPIC_TEMPLATE.md    ← how it looks in Markdown
```

Process: [content-lifecycle.md](content-lifecycle.md) · playbook [../workflows/chapter-fill.md](../workflows/chapter-fill.md).  
Expands constitution rule 5 (**Why before How**).

---

## Platform stance

We are building an **educational platform**, not a folder of articles.

A chapter is a **product** (architecture, contract, implementation, review history, version) — see [content-lifecycle.md](content-lifecycle.md).  
Treat each new chapter with the same seriousness as designing a software subsystem.

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

**Why chapters start from a problem:** definitions without pain become dictionaries. Pain creates the need to read the next sentence.

**H1** invites; **fundamental why** (Learning Metadata) may be the sharper problem form.  
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

## Building blocks (recognizable style)

Not every chapter needs every block. Together they form the **Engineering University voice**.

| Block | Intent | Typical markup |
|-------|--------|----------------|
| **Cold open** | Intrigue before definition | First section / scene |
| **Engineering Axiom** | Rare, durable principle (~30–40 across the whole university) | `<aside class="eu-axiom">` |
| **Spine diagram** | One vertical map of the idea; reuse in the module | Mermaid / figure; highlight “you are here” later |
| **New model** | Explicit before → after | Table or two columns |
| **History insert** | Pain → why the idea appeared (not name catalog) | Short section |
| **Production bridge** | Spec hole, failure, constraint in the real world | Paragraph / vignette |
| **Interview bridge** | Projection Q / mistakes | Section or `Interview-Pack` |
| **Level gate** | Where L1 may stop | `<p class="eu-level-gate">` |

**Engineering Axiom** is scarce on purpose. Do not label every tip as an axiom.

---

## Levels on one page (multi-layer, not two courses)

Same chapter serves beginner and senior without forking into separate curricula.

| Level | Reader gets | Gate line (example) |
|-------|-------------|---------------------|
| **1** | Idea / mental model | «Level 1 — понимание идеи: достаточно досюда» |
| **2** | Engineering detail, trade-offs, production | Continue below the gate |
| **3** | Internals / research depth | Earned; may be `deferred` ([chapter-shape](chapter-shape.md)) |

Default study exit for Path Beta: **Level 1–2**. Level 3 is not fake completeness.

---

## Why the chapter spine looks like this

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

| Stage | Why it exists |
|-------|----------------|
| Cold open | Create desire to continue |
| Problem / why | Align title with real question |
| History | Show the idea is earned, not fashionable |
| Idea / how | Mechanism without API tourism |
| Abstractions | Teach cost of hiding |
| Production | Bind to real engineering |
| Interview | Projection, not a second textbook |
| Practice | Force the model to move |
| Mental model | Prove the chapter changed thinking |
| Next | Keep the graph alive |

Flagship chapters should also carry:

- One **spine diagram** reusable in the module  
- **Software / Hardware** (or equivalent) when later chapters need the nouns  

---

## What counts as a successful chapter

A chapter succeeds when **all** of the following hold:

1. **Mental-model shift** — reader can state before → after in one sentence  
2. **Question match** — body answers the H1 / fundamental why  
3. **Need-to-know** — no noun before its pain  
4. **Four gates** pass — Beginner · Engineer · Interview · University ([review-criteria.md](review-criteria.md))  
5. **Survives API churn** — idea-level spine; Swift/iOS are illustrations  
6. **Reader Header** — first screen teaches, does not look like a JIRA card  

“Nice prose” without a model shift is **not** success.

Scoring detail: [review-criteria.md](review-criteria.md).

---

## Anti-pattern: term catalog curricula

```text
What is a variable → function → class → object → …
```

That is a **dictionary**. Concepts appear because the syllabus listed a noun.  
Here, each idea appears as an **answer to a problem** previous pages made painful.

---

## Part I — Foundations (first module)

Example of the model applied — not a second SoT. Human map: [`fundamentals/PART_I.md`](../../fundamentals/PART_I.md).

| # | Working title (H1) | Fundamental why | Topic id | Status |
|---|--------------------|-----------------|----------|--------|
| 0 | Почему существует программирование? | Почему компьютеру вообще нужны программы? | `fundamentals/what-is-programming` | **v1.2 Publish** |
| 1–9 | (see Part I map) | one why each | planned ids | planned |

Do **not** mass-create empty topics — [content-lifecycle.md](content-lifecycle.md) + [chapter-fill](../workflows/chapter-fill.md).

---

## Naming rule

1. Pick the **why-question** first.  
2. H1 should make the reader expect that answer.  
3. Folder slug may stay stable English; rename later when the module stabilizes.  
4. Paths / catalog follow the **why title**, not the old dictionary name.

---

## Related

- [content-philosophy.md](content-philosophy.md)
- [review-criteria.md](review-criteria.md)
- [content-lifecycle.md](content-lifecycle.md)
- [chapter-shape.md](chapter-shape.md)
- [`../../campus/TOPIC_TEMPLATE.md`](../../campus/TOPIC_TEMPLATE.md)
- [university.md](university.md)
- [../constitution.md](../constitution.md) (rule 5)
