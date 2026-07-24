# Design capture — Living University (chat → repo)

**Status:** Binding capture of decisions already ratified in Charter / Campus / `.ai/`; remaining items are **pending Design** only where marked.  
**Date:** 2026-07-24  
**Source:** Owner + assistant design thread (Interview Bootcamp → Engineering Builder → Living World → projections).  
**Related:** [01_CHARTER.md](../01_CHARTER.md) · [02_PHILOSOPHY.md](../02_PHILOSOPHY.md) · [METAMODEL.md](METAMODEL.md) · [REFERENCE_WORLDS.md](REFERENCE_WORLDS.md) · [CODE_CONTRACT.md](CODE_CONTRACT.md) · [LIVING_PRODUCT.md](LIVING_PRODUCT.md) · [../.ai/constitution.md](../.ai/constitution.md)

This file is **not** a second constitution. It maps the long conversation to existing SoT and lists what is still open so we do not rediscover the same design.

---

## Verdict after audit (2026-07-24)

| Area | In repo already? | Where |
|------|------------------|--------|
| Two students (A senior path, B foundations) | Yes | Charter |
| Living university, not knowledge dump | Yes | Charter · Philosophy |
| SE center; Mobile = depth faculty; AI ×2 | Yes | Charter · Faculties |
| Completeness pyramid + Evidence | Yes | Philosophy · PROGRESS |
| Levels 1–3 (+ onion inside L3) | Yes | Charter · TOPIC_TEMPLATE |
| Topic passport (problem → evolution → next) | Yes | METAMODEL · TOPIC_TEMPLATE |
| Knowledge graph node/edge types | Yes | METAMODEL · `.ai` |
| RU-primary + EN terms + Interview English | Yes | LANGUAGE |
| Mode A bootcamp / Mode B maintenance | Yes | OPERATING_MODES |
| Source order (Apple → WWDC → Evolution → … → Boosty as ideas) | Yes | OPERATING_MODES |
| Reference Worlds (Football, Automotive/PitStop…) | Yes | REFERENCE_WORLDS |
| Sandbox L1 / Lab L2 / Core L3 + PR types | Yes | CODE_CONTRACT |
| Staged projects + migrate delete/archive/integrate | Yes | projects-map · CODE_CONTRACT |
| Projections over SoT (no Handbook trees yet) | Yes | `.ai` Architect cut · PROJECT_STATUS |
| Career OS hybrid (private outside) | Yes | CAREER_INTEGRATION |
| PitStop / career / org apps independent | Yes | PROJECT_STATUS |
| AI Governance Layer | Yes | `.ai/` |

**Conclusion:** do **not** rewrite the university. Capture gaps below; keep studying under Mode A.

**Fill model (owner, 2026-07-24):** completeness of the warehouse is **not** the goal. Prep starts a topic → questions → notes land on the canonical page → add playground/code/`projects/` link when it exists. Incremental fill is binding in [OPERATING_MODES.md](OPERATING_MODES.md).

---

## North-star gate (binding reminder)

Before adding history, biography, film, photo, or long lore:

> Does this help the student better understand the engineering world?

If no — cut, even if interesting. History exists **only** to explain technology (≈5–10% of a topic, not 70%).

Same gate for product ideas: entertainment serves learning ([REFERENCE_WORLDS.md](REFERENCE_WORLDS.md)).

---

## Audience (reconfirmed)

| Student | Role |
|---------|------|
| **A** | Owner — structure gaps, Senior depth, interview as side effect of competence |
| **B** | Next generation — same map, Level 1–2, curiosity over vibe-coding |

Public repo OK. Mass audience / Coursera clone — **not** a goal.

---

## Daily rhythm (already Mode A/B)

Keep shapes in [OPERATING_MODES.md](OPERATING_MODES.md).

Extra confirmation from chat:

- Full-time now: deep day, mock interview, write-back.
- After hire: short morning pulse + **40–60 min evening** (no heavy late sessions).
- Open questions stay **unanswered on the page**; answers forged in chat/mocks, then Evidence write-back.

---

## Topic page DoD (Pages-first)

GitHub markdown = SoT; GitHub Pages = first product UI ([DISPLAY_0.1.md](DISPLAY_0.1.md)).

When a topic is touched toward completeness, aim for:

| Element | Why |
|---------|-----|
| Diagram / scheme | Graph and process visible in browser |
| Life analogy (esp. Level 1) | Student B entry |
| Runnable / citeable code | Practice over prose |
| Evolution strip (then → now) | Legacy teaches modernity without digging into dead APIs |
| Practice / mission | No topic without practice |
| Open questions | Drive chat; not a closed FAQ dump |
| Official links | Apple Docs, WWDC, Evolution |
| Next | Never dead-end after reading |

Details: [TOPIC_TEMPLATE.md](TOPIC_TEMPLATE.md) · [DISPLAY_0.1.md](DISPLAY_0.1.md).

---

## Living product vs Sandbox (binding intent)

| Space | Intent |
|-------|--------|
| **Core World** (when chosen) | Real product students want to open daily; technologies appear because they improve the product |
| **Learning modules** | Extend Core without turning it into a zoo |
| **Sandbox / Evolution** | Files may be **outside runtime target**; evolution samples (Button then/now) OK |

Product rule (pending Core World pick, already design intent):

> A technology enters Core because it improves the product — not to demo an API.

Full principles: [LIVING_PRODUCT.md](LIVING_PRODUCT.md). PitStop stays an independent product and idea source.

---

## Projections (Handbook layer) — Architect cut remains

Desired long-term **views** (not second encyclopedias):

- Senior Handbook (thin pointers)
- Interview Question Bank
- Decision Registry (ADR-shaped, reusable)
- Production / Debugging Playbook (symptom-first)
- Interview Simulator (question trees)
- Flashcards / learning plan generators

Until Design revision: material lands **on canonical topics** / Path notes. No top-level `handbook/` trees (`.ai` Architect).

Interview pack shape (when Author packs a view): [`.ai/prompts/create-interview.md`](../.ai/prompts/create-interview.md).

---

## Extra graph ideas (pending / light)

| Idea | Status |
|------|--------|
| **Engineering Pattern** nodes (Cache, Queue, Ownership across domains) | Node type added in METAMODEL; content later |
| **Symptom → systems** index (Failure First) | Intent in `.ai/principles/university.md`; campus index page **later** |
| Interactive knowledge graph UI | Explicitly out of 0.1 / DISPLAY non-goal |
| CS “map of IT” page for Student B (Telegram send → full stack) | Faculty CS exists; dedicated Level-1 map page **later** on Path Beta |

---

## Migration of old labs

Already staged under `projects/`. Rule unchanged: delete / archive / integrate by **educational role** ([CODE_CONTRACT.md](CODE_CONTRACT.md) · [projects-map.md](projects-map.md)).

Example: `netsession-lab` → Networking faculty hooks + future Core networking feature — not a forever standalone “demo repo identity”.

---

## External materials

Apple Sample Code, Point-Free, Hacking with Swift, WWDC, Boosty, courses: **study → adapt → cite → implement in our world**. Never wholesale copy. Never compete for “best tutorial brand.”

---

## Explicit non-goals (from critical pass)

- Wikipedia / pure history encyclopedia  
- Mandatory football-only examples (worlds are optional packs)  
- Layer 0–5 forced on every topic (L1–L2 mandatory when teaching; L3 earned)  
- 300 thin stubs over 30 excellent topics  
- Absorbing private `career`  
- Handbook trees before Design  
- Choosing Core World product under panic during Mode A study  

---

## Next actions (do not block Mode A)

1. Continue Path Alpha Evidence + M03 Concurrency deep track.  
2. When touching a topic: apply updated TOPIC_TEMPLATE (Evolution, Open questions, visual DoD).  
3. Core World product pick = separate Design session (see LIVING_PRODUCT).  
4. Symptom index + Pattern pages = after enough canonical topics exist.  
5. Handbook aggregators = only after Architect Design revision.
