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

Every major topic is a **multi-layer node**, not only an API surface:

| Layer | Intent |
|-------|--------|
| 0 | What is it? (one minute) |
| 1 | On fingers / life analogy |
| 2 | Engineer practice |
| 3 | Under the hood |
| 4 | Sources / runtime / SIL when needed |
| 5 | Research (WWDC, Evolution, papers) |

You may stop at any layer. Layers 0–2 are the default obligation; 3+ only where they earn their place.

History is not ornament and not the goal. **History exists only to explain the technology.**

### North-star gate

Before adding material, ask:

> Does this help someone better understand the engineering world?

If no — it does not enter the university, even if it is entertaining.

### We study problems, not APIs

APIs change. Problems remain.

Every topic should show: problem → earlier solutions → today’s solution → where the industry is moving (including toward AI systems when relevant) — without fortune-telling.

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

## Living product + laboratory spaces

The university needs **live code**, not only Markdown.

### Core World (product)

One continuously evolving application that is interesting to open even without studying.

Rule: **technology appears because it improves the product**, not to demo an API.

Still **intentionally undecided** which app — a living reference world (e.g. Football Universe / companion-style) beats a demo zoo. Staged `projects/` are candidates. PitStop stays separate; ideas may flow both ways. See [campus/REFERENCE_WORLDS.md](campus/REFERENCE_WORLDS.md) and [campus/CODE_CONTRACT.md](campus/CODE_CONTRACT.md).

### Spaces

| Space | Role | Quality bar |
|-------|------|-------------|
| Core World | Ships, runs on device | Production-style |
| Laboratory modules | Extend the world for a lesson | Clean + linked to a topic |
| Sandbox / Evolution | Compare APIs, break rules; may be outside target | Compiles + teaches |

### Never teach the tool before the problem

Swagger, Figma, Jira, Instruments appear when a mission needs them.

---

## Laboratories

Every important topic should contain **experiments** (“What happens if…?”).

Playgrounds and labs live **inside** the university. See [campus/labs/](campus/labs/).

---

## Languages

- **Russian** — primary prose for mental models (campus voice for v0.1).  
- **English** — mandatory terms, APIs, Apple docs, WWDC, Swift Evolution, and optional **English for Interview** blocks.  

Do **not** ship dual EN+RU mirrored pages or an EN-only encyclopedia voice. Details: [campus/LANGUAGE.md](campus/LANGUAGE.md).

---

## GitHub and GitHub Pages

| Surface | Role |
|---------|------|
| GitHub repo | Source of truth |
| GitHub Pages | First product UI (schemes, diagrams, code, practice) |

Git, PRs, reviews, and CI are curriculum. See [campus/CODE_CONTRACT.md](campus/CODE_CONTRACT.md).

---

## Progress is measurable

Reading an article is at most **Learning**.

States: `Not started` → `Learning` → `Practicing` → `Interview ready` → `Mastered`.

**Mastered** requires Evidence (explain, interview, code, under-the-hood, task). Confidence 1–5. Interview Heat prioritizes offer-critical topics.

Rhythms: full-time bootcamp while job-seeking; later short morning + evening maintenance (no heavy night overload). Specs: [campus/OPERATING_MODES.md](campus/OPERATING_MODES.md), [campus/PROGRESS.md](campus/PROGRESS.md).

Interview Mode is a consequence of competence.

---

## Engineering Stories

Connect to confirmed work when evidence exists. Never invent. Private facts stay in `career`.

---

## External boundaries

| Repository | Role |
|------------|------|
| career | Career presentation / SOT |
| ios-hunter | Career tooling |
| pitstop-ios | Real product (inspire, do not merge) |

University is the learning center. Research starts here; products may spin out.

---

## Anti-goals (hard)

- No Wikipedia / science museum  
- No duplicating Apple docs  
- Prefer depth over shallow coverage  
- History only to explain *why*  
- No Foo/Bar when a Reference World works  
- No topic without a practice path  
- No “finished forever” — evolve with WWDC / Swift / industry  

---

## Naming

Use **Engineering University**. Do not call it a knowledge base.

---

## Long-term Goal

A living map of the engineering world — iOS as deepest specialization — that Student B can enter from zero and Student A can use to structure gaps, stay current, and pass Senior interviews as a side effect of understanding.

If in five years we want to restart from Layer 0 ourselves, the architecture was right.

---

## Success / Failure

**Success:** better decisions under uncertainty; explain · demonstrate · test · reuse · teach; Evidence; living Core World.  
**Failure:** note pile, demo zoo, API checklist, or entertaining encyclopedia without decisions.
