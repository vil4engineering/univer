# Principle: Content philosophy

**Mandatory for every AI** working on Engineering Builder content (Author, Mentor, Reviewer, Curriculum Designer, Interviewer packs that write prose).

This is the long-term quality gate. Constitution rules 5, 6, 8, 10 expand here for *how chapters feel*.

Campus binding: [`TOPIC_TEMPLATE.md`](../../campus/TOPIC_TEMPLATE.md) · [chapter-shape.md](chapter-shape.md) · [teaching-model.md](teaching-model.md) · [language.md](language.md).

---

## Core stance

**Do not write about technologies. Write about ideas.**

Technology catalogs rot. Engineering problems and solution *ideas* survive API churn.

| Fragile spine | Durable spine |
|---------------|---------------|
| Swift → Classes / Structs / Enum / Protocol | Memory · Identity · Abstraction · Concurrency · Persistence · … |
| iOS → UIKit / SwiftUI / Combine | UI as state · Navigation ownership · Observation · … |

Frameworks and APIs appear as **implementations** of an idea - never as the chapter’s only reason to exist.

---

## Knowledge flow (every chapter)

```text
Problem
  → Why it appeared
  → History (short)
  → Solution idea
  → Implementations (APIs / eras)
  → Trade-offs
  → Practice
  → Interview
```

Example - memory:

```text
Memory is limited
  → Manual retain/release
  → Garbage collection
  → ARC
  → Ownership
  → Swift model today
```

Example - concurrency:

```text
Programs stopped getting faster “for free”
  → Threads
  → Locks
  → GCD
  → async/await
  → Actors
```

Ten years later the leaf APIs may change; the problem chain should still teach.

Align headings with [chapter-shape.md](chapter-shape.md). Depth = Levels 1–3.

---

## Hard rules (short list)

1. **One chapter = one fundamental question** (usually *why*).  
   See [teaching-model.md](teaching-model.md). Title must match the answer the body gives.  
   Bad: H1 “What is programming?” while the chapter only explains *why programming must exist*.  
   Bad: chapter series “Variable / Function / Class / Object” as the spine.

2. **Knowledge appears only when the reader needs it.**  
   Pain / question first, then the noun (Compiler, Actor, OS…). See [teaching-model.md](teaching-model.md).

3. **Start from a problem, not a definition.**  
   Bad: “Actor is a type that…”  
   Good: two threads and a bank balance - why is the total wrong? That pain led to models like Actors.

4. **Explain why before how.**  
   Matches constitution rule 5. Fundamental question in Learning Metadata; H1 invites.

5. **Each chapter must change the reader’s mental model.**  
   End with an explicit reflection (see below). Memorizing definitions is not the goal.

6. **Story over encyclopedia.**  
   Ban reference-manual chapter bodies. Narrative that makes the next section worth opening. Facts still must be accurate.  
   Prose must stay **living and short** — [writing.md](writing.md) § Living chapter prose (Owner-ratified).

7. **History serves the idea.**  
   History > dump of dates. Only enough to explain why the modern solution looks this way (~5–10% of the chapter).

8. **Diagrams explain ideas; they do not decorate.**  
   If removing the diagram loses no understanding, cut it.

9. **Theory → practice → production → interview.**  
   Incomplete stubs are OK (incremental fill). Faking a full reference section is not.

10. **Do not duplicate - link.**  
    One concept, one canonical topic. Cross-link the graph.

11. **Write for ten years.**  
    Prefer problem/idea language that remains true when Swift N+1 renames an API.

12. **Russian explains; English names the craft.**  
    [language.md](language.md).

---

## Closing reflection (required when a chapter is past stub)

Every chapter body ends with the same prompt (RU in published pages):

> **Что изменилось в твоём понимании после этой главы?**  
> Не «запомнил ли определения», а как сдвинулась ментальная модель.

Optional one-line Evidence cue for Path log: *model shift: …*

---

## First-page / Path Beta spirit (not a second SoT)

Opening intuition for Computer Science / Student B may be almost philosophical, e.g. disciplined helpers, not “smart” machines - programming as precise instruction. Place such pages under fundamentals / Path Beta when authored; do not fork a marketing homepage that duplicates Charter.

---

## Reviewer reject signals

Reject or request rewrite when:

- Chapter is a glossary of APIs **or of language terms** (variable/function/class spine) with no problem spine  
- Title says *what* while body answers *why* (or the reverse) without Owner rename  
- Opens with definition before stakes  
- Accurate but dry lecture / unexplained jargon stack (fails Beginner; see writing.md Living prose)  
- No path from idea → implementation → trade-off  
- Interview block re-teaches the whole essay  
- Diagram is ornamental  
- No reflection prompt on a non-stub chapter  

---

## Related

- [../constitution.md](../constitution.md)
- [teaching-model.md](teaching-model.md)
- [chapter-shape.md](chapter-shape.md)
- [university.md](university.md)
- [writing.md](writing.md)
- [knowledge-graph.md](knowledge-graph.md)
- [source-of-truth.md](source-of-truth.md)
