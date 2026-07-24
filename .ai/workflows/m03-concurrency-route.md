# Route stub — M03 Swift Concurrency

Curriculum Designer output (thin). Not a Handbook. Canonical SoT: `swift/concurrency/`.

## Goal

Interview-ready L2 on Swift Concurrency (Phase 4 / ROADMAP M03). L3 earned later.

## Target learner

Engineer / Senior interview candidate (Student A).

## Prerequisites (ordered)

1. M02 Swift: value vs reference, ARC mental model
2. Basic async/await syntax comfort

## Core topics (canonical)

- `swift/concurrency/` (passport + Level 1–2)
- Notes: Structured-Concurrency-What-Structured-Means.md
- Related: `swift/async-defer/`

## Labs / playgrounds

- SwiftConcurrencyPrimer
- StructuredConcurrencyLab
- ActorsQueuesLocksInterview
- ImageLoadingConcurrencyLab

## Official sources

- Swift Book — Concurrency
- WWDC sessions on structured concurrency / actors (pick current year when studying)
- Thread Sanitizer docs

## Effort

- ROADMAP estimate: 20–28 h (honest range; confidence medium)

## Interview outcome

Defend: races vs isolation, structured lifetime, MainActor boundaries, cancellation, actor vs queue — using [notes/Interview-Pack.md](../../swift/concurrency/notes/Interview-Pack.md).

## Path mapping

- Path Alpha Stage 4
- Mode A daily: pulse → learn → lab → mock (Interviewer) → Evidence

## Gaps / TODOs

- Async testing topic link when ready
- Legacy warehouse cleanup in concurrency README
- Personal Evidence: race → fix run

Related workflows: [improve-topic.md](improve-topic.md) · [interview-prep-session.md](interview-prep-session.md)
