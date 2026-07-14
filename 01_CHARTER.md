# 01 · Engineering University Charter

> Building engineers, not collecting knowledge.

**Document role:** Canonical constitution — what Engineering University is, and how it differs from a knowledge base, a course, or a book  
**Status:** Phase 1 governance  
**Related:** [02_PHILOSOPHY.md](02_PHILOSOPHY.md) · [03_CURRICULUM.md](03_CURRICULUM.md) · [05_PATHS.md](05_PATHS.md) · [PROJECT_STATUS.md](PROJECT_STATUS.md)

The name may change. **This idea must not.**

---

## Mission

Engineering University is a living engineering education platform.

Its purpose is not to document technologies.

Its purpose is to systematically develop **engineering thinking**.

The university exists to transform knowledge into engineering competence.

---

## Distinguishing principle

**The university must not teach “what to think.”**  
**It must teach “how to make engineering decisions.”**

That is the primary difference from most courses, books, and knowledge bases.

If this principle is kept, structure, laboratories, the Living Application, and interview preparation all arrange themselves around it.

---

## Vision

Most technical resources answer:

> “How does this work?”

Engineering University answers:

> “Why does it exist?”  
> “When should it be used?”  
> “What problem does it solve?”  
> “What are the trade-offs?”  
> “How do experienced engineers make this decision?”

The goal is to build engineers capable of making **good decisions under uncertainty**.

| Typical format | Optimizes for | Usually skips |
|----------------|---------------|---------------|
| Knowledge base | Finding notes | Practice, proof, reuse, progress |
| Video course | Consuming lessons | Ownership, constraints, teaching back |
| Framework book | Syntax and APIs | Organizational trade-offs |
| Interview cheat sheet | Memorized answers | Natural competence |
| **Engineering University** | **Decision quality under uncertainty** | Trivia and folder tourism |

---

## Students

The university is designed for **two primary goals** (not for a mass public audience).

The repository may be public and contain nothing secret — **public reach is not the product goal.**

### Goal 1 — Student A (experienced engineer)

Structure knowledge, close gaps, and keep engineering material in **one place** for fast retrieval — while growing toward Senior+, Lead, Staff, Architect through decision quality (not API tourism).

### Goal 2 — Student B (beginner in the family)

Interest and entry-level competence through practice and a whole picture of computing — not a dry textbook. Same principles, lighter depth.

Eventually the same material should be readable by both at different onion layers.

### Topic depth (onion)

Every major topic is a **layered whole picture**, not only an API surface:

| Layer | Content |
|-------|---------|
| Surface | How to use it today |
| Why / before | Problem people solved; what existed earlier |
| Origin | History, people, links, diagrams — **when it earns its place** |
| Experiment | Lab: “what happens if…?” |

Example: URLSession is dull as method lists; interesting as a chapter in the story of the internet and Apple’s networking stack.

History is not mandatory ornament. Use it when it reveals the whole picture.

---

## Core Principles

### Knowledge is incomplete until it is used

Every topic must be:

- understood  
- demonstrated  
- practiced  
- tested  
- reused  
- explained  

Writing about a pattern is never enough.

### Engineering before technology

Technologies change. Engineering principles remain.

The university teaches principles first.

### Decisions over APIs

Every technology exists because somebody solved a problem.

Understanding decisions is more valuable than memorizing APIs.

### How to decide, not what to think

Do not hand down dogma (“always use X”).

Teach the frame: problem → constraints → options → trade-offs → choice → evidence → revise.

### Systems thinking

Topics never exist in isolation.

Every concept should connect to architecture, product, business, performance, maintainability, and team scalability.

### Evidence over opinion

Engineering decisions should be supported by documentation, measurements, experiments, and production experience — when available.

### Honest engineering

The university never invents experience.

Unknown is acceptable.  
Incorrect certainty is not.

Private career presentation stays in the external `career` repository. Public lessons stay generalized, teachable, and tied only to confirmed evidence.

---

## Learning Pipeline

Every topic follows the same lifecycle:

```text
Concept
  → Intuition
  → Mental Model
  → Visualization
  → Theory
  → Code
  → Laboratory
  → Experiment
  → Reflection
  → Real Project
  → Interview
  → Teaching
```

**Knowledge is considered complete only after it can be taught.**

(Aligned Completeness gates: explain · demonstrate · test · reuse — see [02_PHILOSOPHY.md](02_PHILOSOPHY.md).)

---

## Curriculum

The university is organized around **competencies**, not frameworks.

Examples:

- Ownership  
- Architecture  
- Product Engineering  
- Decision Making  
- Communication  
- Security  
- Performance  
- Testing  
- Leadership  

Frameworks are tools.  
Competencies are the destination.

Faculties, including **Faculty of Engineering Leadership**, map competencies into subjects — see [03_CURRICULUM.md](03_CURRICULUM.md).

---

## Living Laboratory

The university aims for **one continuously evolving application**.

That application exists to **validate** engineering knowledge — not to ship a product for its own sake.

Every important concept should eventually appear inside it when mature enough:

Concurrency · Observation · Persistence · Networking · Architecture · Performance · Testing · Security · …

The concrete app remains **intentionally undecided** until educational criteria are met. Staged projects under `projects/` are parking-lot candidates or teaching cases — not automatic winners. See [PROJECT_STATUS.md](PROJECT_STATUS.md).

---

## Laboratories

Every important topic should contain **experiments**.

Not tutorials. Experiments.

Students are encouraged to answer:

> “What happens if…?”

Playgrounds and labs belong **inside** the university as part of learning — not forever as orphan repos beside it.

---

## Engineering Stories

Knowledge without experience is incomplete.

Every competency should connect to real work **whenever confirmed evidence exists**.

No fictional stories.  
No exaggerated claims.  
If coverage is missing, say so.

Confirmed project evidence lives in the private career system of record; university lessons cite it carefully without treating the `career` repository as owned content.

---

## Interview Engineering

Interview preparation is a **consequence of competence**.

The university does not optimize for memorized answers.

It optimizes for genuine understanding.

If understanding is deep enough, interview answers become natural.

---

## Progress

Progress is measured by competencies.

Not pages read.  
Not videos watched.  
Not hours spent.

The only meaningful metric:

> “What engineering decisions can I confidently make today that I could not make yesterday?”

Assessment, Knowledge Graph, and Engineering Portfolio make that progress visible over time — see [04_STRUCTURE.md](04_STRUCTURE.md).

---

## External boundaries

Structure and governance first. Absorb nothing by accident.

These stay independent; the university may cite them:

| Repository | Role |
|------------|------|
| career | Professional presentation / career SOT |
| ios-hunter | Career tooling |
| pitstop-ios | Product (frozen) |

---

## Naming

Use **Engineering University**.

Do not describe this project as a “knowledge base.”

---

## Long-term Goal

Engineering University should become a complete **engineering operating system** for continuous professional growth — not only interview prep, not only iOS.

Student A grows decision quality under uncertainty.  
Student B grows from first principles into the same way of deciding — at a depth they can hold.

---

## Success

The university succeeds when graduates (including its two students) make better engineering decisions under uncertainty — and can explain, demonstrate, test, reuse, and teach why.

## Failure

The university fails if it becomes a searchable pile of notes, a video checklist, or a folder of demos — even if every file looks complete.
