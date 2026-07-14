# 03 · Curriculum

**Project:** Engineering University  
**Status:** Phase 1 governance (revised — Leadership faculty + lesson contract)  
**Related:** [02_PHILOSOPHY.md](02_PHILOSOPHY.md) · [04_STRUCTURE.md](04_STRUCTURE.md) · [05_PATHS.md](05_PATHS.md)

## Curriculum is not a directory tree

Students study a **program**.

They do not study `swift/`, `ios-sdk/`, or any Git folder as the unit of learning.

Existing folders may host materials for topics. Mapping from curriculum units to files is a storage concern — see [04_STRUCTURE.md](04_STRUCTURE.md).

## Faculties

| Faculty | Purpose |
|---------|---------|
| Faculty of Computer Science | Fundamentals, algorithms, mathematics, problem solving |
| Faculty of Software Engineering | Architecture patterns, quality systems, delivery mechanics |
| Faculty of Mobile Engineering | Apple platforms, Swift, UI, device and OS constraints |
| Faculty of AI Engineering | Reliable AI systems by maturity |
| Faculty of Product Engineering | Shipping judgment, product constraints, coherent delivery |
| Faculty of Engineering Leadership | Ownership, decisions, teams, incidents, mentoring, strategy |
| Faculty of Career Development | Interview craft and growth habits — not ownership of the `career` repository |

Faculties own **subjects**. Subjects appear in **semesters** and **paths**.

### Faculty role boundaries

| Faculty | Owns | Does not own |
|---------|------|--------------|
| Engineering Leadership | How an engineer leads systems, people, and decisions | Private career facts, salary, recruiter strategy |
| Product Engineering | Product/shipping trade-offs in the codebase and roadmap | org politics as a primary subject |
| Career Development | Answer depth, interview narration, pressure craft | The external `career` repository |
| Software / Mobile | Technical mechanisms and platform craft | Leadership as a substitute for deep technique |

## Faculty of Engineering Leadership

Primary long-term faculty for Student A (Senior → Senior+/Lead).  
Also durable for Student B years later — these skills are rarely taught systematically.

Canonical subject list (Charter):

| # | Subject | Core question |
|---|---------|---------------|
| 01 | Technical Ownership | Who is accountable when quality, delivery, or failure hits production? |
| 02 | Architecture | How do we structure systems for change without worshiping patterns? |
| 03 | Decision Making | How do we choose under constraints and defend the choice? |
| 04 | Engineering Standards | What do we require of every change — and why? |
| 05 | Code Review | How do reviews protect the system and the culture? |
| 06 | Mentoring | How do we raise the team bar without creating dependency? |
| 07 | Cross-functional Communication | How do we make trade-offs clear across roles? |
| 08 | Product Engineering | How do engineering choices serve product outcomes? |
| 09 | Career Story | How do we narrate real impact without inventing folklore? |
| 10 | Interview Engineering | How do we demonstrate Senior+/Lead thinking under pressure? |

Subject 08 overlaps Product Engineering faculty on purpose: Leadership treats product judgment as a leadership competency; Product Engineering faculty goes deeper into shipping mechanics.

Subjects 09–10 connect to Career Development craft without absorbing the external `career` repository. Private facts stay outside; university lessons stay teachable and honest.

Related depths that appear inside these subjects when needed: incident response (Ownership / Standards), technical strategy (Decision Making / Architecture).

## Senior+/Lead lesson contract

Used for Path Alpha lessons and Leadership subjects.

**Goal:** systematically close the gap between a strong Senior and a Senior+/Lead.  
**Not the goal:** teach isolated technologies or interview trivia.

Optimize for engineering reasoning, decision-making, and real-world ownership.

### Honesty rule

- Do not assume experience the student never claimed.
- Never invent or exaggerate project stories.
- Connect to career evidence only when it exists; otherwise say so explicitly.
- Private facts stay in the external `career` repository — university lessons stay generalized and teachable.

### Three mandatory questions (every topic)

1. What problem does it solve?
2. Why would an engineering organization choose it?
3. What trade-offs does it introduce?

Technology is never studied in isolation. Everything connects to engineering decisions.

### Lesson shape (one competency per lesson)

| Section | Intent |
|---------|--------|
| 1. Mental model | First principles — why it exists (not APIs/syntax) |
| 2. Decision framework | How experienced engineers choose (why / why not) |
| 3. Alternatives | Pros, cons, scale, maintenance, team, onboarding, testing, business impact |
| 4. Interview perspective | Typical questions; Junior → Middle → Senior → Lead distinctions |
| 5. Real-world ownership | How the decision changes for Senior / Tech Lead / Staff / Architect |
| 6. Connect to experience | Only confirmed experience; gaps stated honestly |
| 7. Interview answer | Concise natural answer + why it is strong |
| 8. Deep dive | Follow-up challenges until mastery — do not advance early |

Mastery gate: the coach (human or agent) must be convinced the competency is understood before the next lesson.

### Anti-patterns for lessons

- "Because it is best"
- Memorized cheat sheets
- API tours without a decision
- Optimizing to "pass interviews" instead of becoming the engineer who naturally passes them

Prefer **why** over bare **how**.

## Competency roadmap (cross-faculty)

Eventually cover (mapped later to subjects and paths):

**Leadership / judgment**

- Technical Ownership
- Technical Decision Making
- Technical Leadership
- Mentoring
- Cross-functional Communication
- Incident Handling
- Decision Making
- System Thinking
- Product Engineering
- Career Growth (leadership sense)

**Systems / craft**

- Architecture
- Modularization
- SDK Design
- API Design
- Dependency Injection
- MVVM
- Clean Architecture
- TCA
- Coordinators
- SwiftUI Architecture
- UIKit Architecture
- Concurrency
- Testing Strategy
- CI/CD
- Code Review
- Engineering Standards
- Security
- Performance

Technologies appear as **decision cases** inside competencies — not as a folder checklist.

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

## Subject template (storage / completeness)

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

For Senior+/Lead lessons, use the **lesson contract** sections above in addition to this template.

A subject may be incomplete. It must not pretend to be complete.

## Semester model (initial sketch)

Exact semester contents will be revised as lessons start. Direction only.

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

### Semester 4 — Ownership and hard quality

- Technical ownership and decision making (Leadership 01–03)
- Concurrency, reliability, performance as design forces
- Interview Readiness intensifies for Student A

### Semester 5 — AI as engineering

Follow the AI maturity spine (below), not a vendor checklist.

### Semester 6+ — Leadership depth + integration

- Mentoring, incidents, review culture, strategy (Leadership 05–10)
- Cross-faculty problems
- Project work toward Living Application criteria
- Teaching loops between students

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

Interview Readiness is a required closing stage of each subject and of each Senior+/Lead lesson (sections 4, 7, 8).

```text
Subject / Lesson
  → Lab (when applicable)
  → Reflection
  → Interview Readiness
  → Deep dive until mastery
```

Faculty of Career Development curates cross-cutting interview craft without absorbing the external career repository.

## Source materials (current repository)

Today’s topic folders and playgrounds are **candidate materials** for faculties and labs. They are not the curriculum map.

Promotion rules (later phases):

- Strong explain + demo material → Topic candidate
- One clear question + experiment → Lab candidate
- Overlapping offline/sync/deeplink writeups → Merge candidates at curriculum level first
- Explain-only AI pages → Incomplete until labs/projects close Completeness gates
- Existing architecture / concurrency / testing topics → feed Path Alpha decision cases

## What Phase 1 does not do

This document does not migrate folders into Semester directories.  
It defines how the university thinks about learning so later migration has a north star.
