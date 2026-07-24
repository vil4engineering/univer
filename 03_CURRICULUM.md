# 03 · Curriculum (v2)

**Project:** Engineering University  
**Status:** **v2** — disciplines over technologies  
**Related:** [01_CHARTER.md](01_CHARTER.md) · [04_STRUCTURE.md](04_STRUCTURE.md) · [05_PATHS.md](05_PATHS.md)

## Curriculum — не дерево папок

Студент учит **программу disciplines**.  
Папки Library — storage. Mapping: [04_STRUCTURE.md](04_STRUCTURE.md).

## Faculties (v2 map)

| Faculty | Role | Campus index |
|---------|------|--------------|
| Software Engineering | Programming, design, architecture, distributed systems, testing, observability, performance, security, OS thinking… | [software-engineering](campus/faculties/software-engineering.md) |
| Mobile Systems | iOS, Swift, SwiftUI, UIKit, concurrency, Apple platforms, SDK/framework design, a11y… | [mobile-systems](campus/faculties/mobile-systems.md) |
| Backend | REST, GraphQL, FastAPI, DBs, caching, auth, workers, queues… | [backend](campus/faculties/backend.md) |
| Infrastructure | Docker, Actions, cloud, CI/CD, monitoring, deploy, containers… | [infrastructure](campus/faculties/infrastructure.md) |
| AI-assisted Software Engineering | Track 1 — tool: Cursor, agents, prompts, workflows, Skills, Career OS craft | [ai-assisted](campus/faculties/ai-assisted.md) |
| AI Technology | Track 2 — how AI works: Transformers, RAG, inference, eval… | [ai-technology](campus/faculties/ai-technology.md) |
| Engineering Leadership | Ownership, decisions, standards, mentoring, strategy | [engineering-leadership](campus/faculties/engineering-leadership.md) |
| Career Development | Interview craft / growth habits (не owns private `career`) | [career-development](campus/faculties/career-development.md) |
| Computer Science | Foundations / algorithms (Entry + SE support) | [computer-science](campus/faculties/computer-science.md) |
| Product Engineering | Shipping judgment / product-shaped design | [product-engineering](campus/faculties/product-engineering.md) |

Faculties own **subjects**. Subjects появляются в **paths** и (позже) semesters.

### Big picture (idea spine)

Не «старт со Swift». Естественный порядок идей:

```text
Computer Science → Programming → Software Engineering
  → OS → Networks → Architecture
  → Swift → Apple Platforms → iOS Development → AI Engineering
```

**Part I — Foundations** → student title **Execution Spine** (первый модуль Foundations):  
[`fundamentals/PART_I.md`](fundamentals/PART_I.md) · [teaching-model](.ai/principles/teaching-model.md)

```text
0 Why programming exists → 1 Computer → 2 Execution
  → Binary → Machine Code → Assembly → Compiler
  → Algorithms → Languages → Software Engineer
```

Mobile / Swift — сильная специализация, не нулевая точка университета.  
Глава 0: [fundamentals/what-is-programming](fundamentals/what-is-programming/) — **Почему существует программирование?**

### Границы

| Faculty | Owns | Не owns |
|---------|------|---------|
| Engineering Leadership | How engineer leads systems/people/decisions | Salary, recruiter strategy, private CRM |
| Career Development | Answer depth, narration craft, pressure | External `career` repository contents |
| AI-assisted | How to use AI in engineering work | Substituting understanding with copy-paste |
| AI Technology | How systems work | Vendor hype as curriculum spine |
| Mobile Systems | Platform craft as SE cases | Claiming the whole university is «iOS school» |

## Dual AI tracks (detail)

### Track 1 — AI-assisted Software Engineering

Cursor · Codex · Claude Code · Copilot · Coding Agents · Prompt Engineering · Engineering Workflows · Code/Architecture Review · ADR generation · Documentation · Automation · Agent Skills · Career OS tooling (public craft only).

### Track 2 — AI Technology

ML · Neural Networks · Transformers · Attention · Embeddings · Tokenization · Inference · Training · Fine-tuning · RLHF · RAG · Vector DBs · Agents · MCP · Evaluation · Safety · Reasoning · Model Context · Tool Calling · Memory · AI Architecture.

Goal: **understanding**. Not hype.

## Engineering Leadership subjects (retained)

| # | Subject | Core question |
|---|---------|---------------|
| 01 | Technical Ownership | Who is accountable when quality/delivery/failure hits production? |
| 02 | Architecture | How structure systems for change without pattern worship? |
| 03 | Decision Making | How choose under constraints and defend the choice? |
| 04 | Engineering Standards | What every change must meet — and why? |
| 05 | Code Review | How reviews protect system and culture? |
| 06 | Mentoring | How raise the bar without dependency? |
| 07 | Cross-functional Communication | How make trade-offs clear across roles? |
| 08 | Product Engineering | How engineering serves product outcomes? |
| 09 | Career Story | How narrate real impact without folklore? |
| 10 | Interview Engineering | How show SE thinking under pressure? |

## Senior+/Lead lesson contract (Path Alpha)

**Goal:** close gap strong Senior → Senior+/Lead SE (не только iOS title).  
**Not goal:** isolated tech tours or interview trivia.

### Honesty

- No invented experience.  
- Private facts → `career`.  
- Connect to evidence only when real.

### Три обязательных вопроса

1. Какую проблему это решает?  
2. Почему organization выбрала бы это?  
3. Какие trade-offs?

### Форма урока

Mental model → Decision framework → Alternatives → Interview perspective → Real-world ownership → Honest experience link → Interview answer → Deep dive until mastery.

Plus Levels 1–3 content where topic warrants.

### Anti-patterns

«Because it is best» · cheat sheets as goal · API tour without decision · pass-interview optimization without competence.

## Knowledge pipeline (curriculum view)

Source → Skill → Article → Diagram → Lab → Exercises → Quiz.

Deepdive Skills в [skills/catalog.md](campus/skills/catalog.md).

## Program shape

```text
Curriculum
├── Faculty (discipline)
│   └── Subject / Topic (Levels 1–3)
├── Paths (Alpha / Beta / Gamma)
├── Skills (executable workflows)
├── Labs
└── Projects (candidates for Living App)
```

## Competency roadmap (direction)

**SE / systems:** Architecture, Modularization, API/SDK Design, DI, Concurrency, Testing Strategy, Observability, Performance, Security, Distributed thinking, Networking, Refactoring, Patterns.

**Mobile depth:** Swift, SwiftUI, UIKit, Apple platforms, Framework design.

**Backend / Infra:** REST/GraphQL, data, auth, workers, Docker, CI/CD, deploy, monitoring.

**AI dual:** Assisted workflows + Technology spine.

**Leadership / Career craft:** Ownership → Interview Engineering (honest).

Technologies = **decision cases** inside competencies.

## Interview Program (embedded)

Нет отдельного «только interview» университета.  
Interview Readiness — closing stage subject/lesson. Career Development + Leadership 09–10.

## Source materials (warehouse)

Существующие `swift/`, `ai-engineering/`, … — **candidates**. Не карта curriculum.

## What this document does not do

Не мигрирует folders в semester directories.  
Задаёт discipline map для v2. Study paused until Status unlocks.
