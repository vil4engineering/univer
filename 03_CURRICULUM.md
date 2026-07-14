# 03 · Curriculum

**Project:** Engineering University  
**Status:** Phase 1 governance  
**Related:** [02_PHILOSOPHY.md](02_PHILOSOPHY.md) · [04_STRUCTURE.md](04_STRUCTURE.md) · [05_PATHS.md](05_PATHS.md)

## Curriculum is not a directory tree

Students study a **program**.

They do not study `swift/`, `ios-sdk/`, or any Git folder as the unit of learning.

Existing folders may host materials for topics. Mapping from curriculum units to files is a storage concern — see [04_STRUCTURE.md](04_STRUCTURE.md).

## Faculties

| Faculty | Purpose |
|---------|---------|
| Faculty of Computer Science | Fundamentals, algorithms, mathematics, problem solving |
| Faculty of Software Engineering | Architecture, quality, systems thinking, delivery |
| Faculty of Mobile Engineering | Apple platforms, Swift, UI, device and OS constraints |
| Faculty of AI Engineering | Reliable AI systems by maturity |
| Faculty of Product Engineering | Judgment, trade-offs, coherent shipping |
| Faculty of Career Development | Interview readiness, growth habits — not ownership of the career repository |

Faculties own **subjects**. Subjects appear in **semesters** and **paths**.

## Program shape

```text
Curriculum
├── Faculty …
│   └── Subject …
├── Semester 1 … N
├── Topics (subject units)
├── Labs
└── Projects
```

Semesters are ordered learning blocks.  
Topics are subject units inside faculties.  
Labs are one-question experiments.  
Projects are larger constructions (including, later, the Living Application).

## Subject template

Every subject should eventually declare:

| Field | Intent |
|-------|--------|
| Problem | What real difficulty motivates this subject? |
| Need | What capability is missing without it? |
| Concept | Mental model and vocabulary |
| Implementation | What is built |
| Laboratory | One engineering question |
| Reflection | What was learned; what failed |
| Completeness gates | Explain · Demonstrate · Test · Reuse |
| Interview Readiness | Questions, trade-offs, pitfalls, depth tiers |
| Teaching note | How Student A/B can teach this |

A subject may be incomplete. It must not pretend to be complete.

## Semester model (initial sketch)

Exact semester contents will be revised after governance review. This sketch defines direction only.

### Semester 1 — Foundations of thinking

- Problem solving habits
- Computer science entry
- Basic programming craft
- Small verified programs
- First reflections and simple interview questions

Primary audience: Student B; Student A reviews gaps.

### Semester 2 — Building correct software

- Types, structure, and clarity
- Testing as a habit
- Debugging and feedback loops
- First software-engineering subjects

### Semester 3 — Systems on a device

- Mobile constraints
- UI and state
- Data and networking problems as needs
- Architecture as response to scale of problem — not fashion

### Semester 4 — Concurrency, quality, judgment

- Harder correctness problems
- Performance and reliability as design forces
- Interview Readiness intensifies for Student A

### Semester 5 — AI as engineering

Follow the AI maturity spine (below), not a vendor checklist.

### Semester 6+ — Integration and teaching

- Cross-faculty problems
- Project work toward Living Application criteria
- Teaching loops between students
- Continuous evolution

Semesters can be re-sliced later. The rule remains: **harder real problems over time**.

## Faculty of AI Engineering — maturity spine

Do not organize this faculty primarily as:

Tokens → Tools → Agents → …

Organize growth as engineering maturity:

```text
AI Foundations
  → Model Integration
  → Structured Outputs
  → Tool Calling
  → Evaluations
  → Reliable AI Systems
  → Agent Systems
```

Technology names (embeddings, RAG, MCP, Foundation Models, etc.) appear **inside** these stages when a problem requires them.

## Interview Program (embedded)

There is no separate "interview-only university."

Interview Readiness is a required closing stage of each subject:

```text
Subject
  → Lab
  → Reflection
  → Interview Readiness
```

Faculty of Career Development curates cross-cutting interview craft (answer depth, communication under pressure) without absorbing the external career repository.

## Source materials (current repository)

Today’s topic folders and playgrounds are **candidate materials** for faculties and labs. They are not the curriculum map.

Promotion rules (later phases):

- Strong explain + demo material → Topic candidate
- One clear question + experiment → Lab candidate
- Overlapping offline/sync/deeplink writeups → Merge candidates at curriculum level first
- Explain-only AI pages → Incomplete until labs/projects close Completeness gates

## What Phase 1 does not do

This document does not migrate folders into Semester directories.  
It defines how the university thinks about learning so later migration has a north star.
