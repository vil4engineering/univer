# Strategy · flagship project decision

**Date:** 2026-06 · **Status:** active direction

Why FlipEnglish is the primary project for AI learning, career portfolio, and daily English practice — and why PitStop is no longer the AI flagship.

## Decision

| Before | After |
|--------|-------|
| PitStop AI Assistant — portfolio flagship | **FlipEnglish** — portfolio + AI learning lab |
| FlipEnglish — deferred until after AI practice | FlipEnglish **is** the practice surface |
| PitStop — maintenance tracker + RAG over manuals | PitStop — **frozen** personal **car diary** (no AI investment) |

## Why PitStop failed as an AI learning project

| Criterion | PitStop | FlipEnglish |
|-----------|---------|-------------|
| Daily use | Rare (log service once a month) | Daily (active B1→B2 study) |
| Data for RAG | Owner manuals — licensing, PDFs, model-specific | Open vocab, grammar, **your** cards and mistakes |
| Eval quality | «Was maintenance advice correct?» needs a mechanic | Quiz accuracy, recall %, golden grammar Q&A |
| KPI overlap | AI + portfolio only | **English + AI + portfolio** in one loop |
| Wrong-advice risk | High (safety, liability) | Low (explainable, fixable) |

**Root cause:** PitStop was chosen by inertia («serious app», RAG-over-manuals sounds technical), not by product-engineering criteria. A flagship must be **dogfooded daily** with **data you control** and **measurable AI quality**.

## Professional flagship criteria

1. **Dogfooding** — you open it every day
2. **Data under control** — no secret databases; corpus grows as you learn
3. **Measurable eval** — clear right/wrong before shipping AI changes
4. **Multi-KPI** — one project, several career goals
5. **Shippable scope** — vertical slice in 6–9 months, not a platform on day one

FlipEnglish passes all five. PitStop passes none for AI work.

## Product wedge (not Duolingo)

Duolingo and similar apps: gamified breadth, heavy subscriptions, unclear learning ROI.

**FlipEnglish wedge:**

> SRS-first flashcards (phrases, not isolated words) + on-device AI that explains **your** mistakes — minimal UI, privacy-first, no engagement tricks.

Not «another language course». A tool for someone who is **already learning** — starting with the author (B1→B2, tech English, interview phrases).

## Scope · now vs later

### Now (2026)

- **Audience:** personal use only — author learning English daily
- **Content:** author's decks (tech English, interviews, everyday phrases per [product.md](product.md))
- **AI:** learn stack bottom-up in this app — Prompt → tools → RAG → coordinator → agent ([foundation-models-ios27.md](foundation-models-ios27.md))
- **MVP bar for Q4:** SRS works + **one** shipped AI feature (e.g. explain mistake / generate phrase card) + eval golden set (20–30 items)

### Later (business model TBD — do not scope now)

- **Elementary / kids:** children in the family also learning — possible deck profiles or simpler UX; validate with real use first
- **Additional languages:** only after English loop is stable
- **Audio, conversation agent, App Store:** roadmap items, not v1; weigh monetization when there is daily use data

**Rule:** ship for yourself first. Store, pricing, and kid mode are **year 2+ decisions**, not blockers for learning AI.

## AI learning map (M01–M09 in FlipEnglish)

| Month | Skill | FlipEnglish application |
|-------|-------|-------------------------|
| M01 | Prompting & API | streaming client patterns (reuse NetSession ideas) |
| M02 | FM availability | `LanguageModelSession` gate before generation |
| M03 | `@Generable` + Tool | typed `Card`; tools `lookupPhrase`, `scheduleReview` |
| M04 | Sessions + eval | review session history; draft golden Q&A set |
| M05 | RAG | grammar notes + user's wrong-answer history |
| M06 | Coordinator | definitions on-device, explanations via cloud |
| M07 | MCP | optional server for shared decks / import pipeline |
| M08 | Agent | capped conversation practice (B2 speaking goal) |
| M09 | Security | prompt injection on import text; tool allowlist |

## Eval · the cheap lever

Whoever measures AI feature quality leads the technical conversation.

For FlipEnglish:

- Golden set: 20–50 grammar / phrase questions with reference explanations
- Regression before prompt or schema changes
- Metrics: recall rate, quiz success, «was explanation helpful?» (self-report ok for v1)

## PitStop · car diary (frozen)

`pitstop-ios` remains a **personal car diary**: odometer, service visits, reminders, insurance — for remembering maintenance on **your** car. Not an AI product. Not portfolio flagship.

- AI features (manuals RAG, advisor, MCP) — **stopped**
- Minor UX fixes allowed if they help daily logging
- No new AI architecture investment

## What success looks like (2026)

1. Author uses FlipEnglish daily for English study
2. TestFlight build with at least one AI feature + eval harness
3. EN pitch: «I built a privacy-first AI tutor I use every day» — stronger than a rarely opened maintenance app
4. PitStop stays useful as a car log without competing for learning time

## References

- Career plan (private): `~/Developer/GitHub/Profile/career/`
- AI stack layers and B/I/A/E levels: career `DEVELOPMENT_PLAN.md`, `mentorship/ios-bento-ai-path.md`
- Product spec: [product.md](product.md)
- Engineering: [engineering.md](engineering.md)
