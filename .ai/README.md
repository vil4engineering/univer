# AI Governance Layer

Entry point for every agent working on Engineering Builder: Cursor, ChatGPT, Claude, Codex, and future tools.

**Committed agent entrypoint:** root [`AGENTS.md`](../AGENTS.md) — **Identity gate (Maxim | Timur)** first, then this README before changing knowledge.

This directory is not curriculum content. It is the operating system for how AI may change the knowledge system.

Campus OS (Paths, Skills, Evidence) stays in `campus/`. Private career stays outside this repo. This layer governs knowledge authorship and graph integrity.

---

## Layering (no restatement drift)

| Layer | May contain |
|-------|-------------|
| [constitution.md](constitution.md) | The 10 hard rules only |
| [principles/](principles/) | Expansion + campus binding; link to constitution; do not re-number all 10 |
| [roles/](roles/) | Operational stance, Do/Don't, output shape; short pointer to constitution |
| [workflows/](workflows/) | End-to-end playbooks (when to escalate) |

---

## Read order (mandatory)

1. [constitution.md](constitution.md) — hard principles
2. [collaboration.md](collaboration.md) — who does what
3. [principles/](principles/) — how knowledge is shaped
4. One role from [roles/](roles/) — only the role needed for this task
5. Matching [workflows/](workflows/) playbook when improving a topic or running interview prep
6. Matching prompt from [prompts/](prompts/) if creating or improving an artifact
7. Matching checklist from [checklists/](checklists/) before claiming done
8. Dual-pass Reviewer ([workflows/dual-pass-review.md](workflows/dual-pass-review.md)) — Author must not self-accept  
9. Monthly / off-cycle base audit ([workflows/monthly-audit.md](workflows/monthly-audit.md)) — Reviewer only; Owner-triggered

Do not skip the constitution. Do not load every role at once. Pick one role per task.

**Platform SoTs (read before new chapters):**

1. [principles/teaching-model.md](principles/teaching-model.md) — why we teach this way  
2. [principles/review-criteria.md](principles/review-criteria.md) — how we score  
3. [principles/content-lifecycle.md](principles/content-lifecycle.md) — content SDLC · chapter = product  

Also: [principles/content-philosophy.md](principles/content-philosophy.md). Stack: teaching-model → chapter-shape → `campus/TOPIC_TEMPLATE.md`.

---

## Layout

```text
.ai/
├── README.md                 ← you are here
├── constitution.md
├── collaboration.md
├── principles/
├── roles/
├── workflows/
├── prompts/
└── checklists/               ← includes chapter-review.md (4 gates + 10 scores)

Repo root also: reviews/      ← durable chapter review journal
```

Legacy stub: [university-author.md](university-author.md) → use `roles/author.md` + principles.

---

## Repo binding (campus v2)

| Governance intent | Campus reality |
|-------------------|----------------|
| Layered learning (intuition → production → interview → practice) | Topic body: **Fundamental why** + chapter sections ([principles/chapter-shape.md](principles/chapter-shape.md)) · depth = Levels **1–3** (`campus/TOPIC_TEMPLATE.md`). Do not fork a second level taxonomy. |
| Author voice in `.ai/` is English | Published campus / path / faculty / topic prose is **RU-primary** + **EN terms** ([principles/language.md](principles/language.md) · `campus/LANGUAGE.md`). |
| One concept, many views | Campus-first; Library = warehouse; no mass-move without Design. |
| Interview as projection | No invented private experience; reference canonical topics. |
| Study status | Follow `PROJECT_STATUS.md` (unlocked under v2 after ratification). |

Human coach ritual (Path lesson, write-back): `campus/ASSISTANT_MANUAL.md`. Thin agent facts: root `AGENTS.md` (committed).

---

## Tool fit (not competition)

| Tool | Prefer for |
|------|------------|
| **Cursor** | File writes, refactors, repo search, structure, link fixes, bulk consistency, catalog scripts |
| **ChatGPT** (and similar chat models) | Hard concepts, weak-spot review, curriculum routes, deep interview questions, trade-offs, history, engineering decisions, system design depth |

Same constitution. Different strengths. No parallel knowledge trees.

---

## How to start a task

```text
0. Identity gate (root AGENTS.md): Maxim or Timur? — before any repo change
1. State AI role: Author | Reviewer | Architect | Mentor | Interviewer | Curriculum Designer
2. Name the target concept / path / file
3. Search for existing material before creating anything
4. Follow matching workflows/* when applicable
5. Apply the role prompt only
6. Run the matching checklist
7. Dual-pass Reviewer before Accept (Author must not self-accept)
8. Stop when the checklist passes — do not expand scope into other roles unless asked
```

**New / flagship chapter (design → write):** open [workflows/chapter-fill.md](workflows/chapter-fill.md) first. Only the `# Тема` block changes in [prompts/design-chapter.md](prompts/design-chapter.md).

---

## Non-goals

- Replacing `campus/` with AI prompts
- Generating Markdown for its own sake
- Duplicating explanations across Handbook / Interview / Labs / Flashcards
- Absorbing private career facts into this public repo
