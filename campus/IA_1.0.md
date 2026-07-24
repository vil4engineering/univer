# IA 1.0 — Information Architecture

**Status:** Binding epic · 2026-07-24  
**Goal:** Make the public site answer in **10 seconds**: Where am I? Is this for me? What do I do next?  
**Not the goal:** Write five more chapters before this is true.

Related: [DISPLAY_0.1.md](DISPLAY_0.1.md) · [LAYOUT_0.1.md](LAYOUT_0.1.md) · [author/](author/)

---

## Diagnosis

We mixed **three products** on one Home:

| Product | Audience | Job |
|---------|----------|-----|
| **A. Public University** | Visitor, student, external engineer | Learn; trust; start |
| **B. Campus OS** | Enrolled student, future teachers | Progress, Evidence, modes, labs rhythm |
| **C. Author SDK** | Owner, authors, AI agents | teaching-model, lifecycle, chapter-fill, reviews |

Publishing B+C as Home is like opening Apple.com on Design System + Release Workflow.

**Main risk:** not “too many links” — **mixed levels of abstraction** on one screen (philosophy + path + AI SDK + project ops + catalog + lesson).

---

## Roles (official)

| Role | 10-second need | Primary surface |
|------|----------------|-----------------|
| **Visitor** | What is this? Start? | [Public Home](../README.md) |
| **Student** | My path, next chapter, practice | Paths · Part I · chapters · thin Campus |
| **Author** | Ship / review a chapter | [Author hub](author/) |
| **AI** | How to change the graph safely | [`AGENTS.md`](../AGENTS.md) · [`.ai/`](../.ai/) — **never** student nav |

---

## Visibility matrix

| Surface | Visitor | Student | Author | AI |
|---------|---------|---------|--------|-----|
| Public Home (`README`) | **Primary** | Entry | Link only (footer) | No |
| Sidebar (default) | ≤7 learning links | Same | One “Author” link | No |
| Campus (student) | Optional | **Primary OS** | Link to Author hub | No |
| Author hub | No | No | **Primary** | Linked |
| `.ai/`, AGENTS | No | No | Via hub | **Primary** |
| PROJECT_STATUS, metamodel, session protocol | No | No | Hub | Hub |
| Chapter Reader Header | — | **Primary** | Engineering `<details>` | — |

**Rule:** if a doc helps *build* the university, it is Author/AI — not Visitor Home.

---

## Public Home contract (product A)

Must answer only:

1. **Where am I?** — Engineering University (learning product)  
2. **Is this for me?** — CS / SE / systems from first principles → Senior  
3. **What next?** — one obvious **Начать обучение**

Allowed blocks:

- Value proposition (outcome for the learner — not author biography)  
- Start Learning (Beta / Alpha)  
- Why different (≤4 bullets)  
- Optional: About (short)  
- Footer: site / org · tiny Author link  

**Forbidden on Home:**

- Chapter-fill, teaching-model, review criteria, content lifecycle  
- Operating modes, Evidence vocabulary, Skill Factory, metamodel  
- DESIGN capture, Living Product, Code contract, Session protocol  
- “Long-term system for two students…” as hero (author intent ≠ visitor value)  
- File-index Campus with 20+ peer links  

**Copy test:** hero must answer *what I get*, not *how the author designed the repo*.

Good direction:

> Learn Computer Science and Software Engineering from first principles — from beginner intuition to Senior engineering.  
> (RU equivalent on the live Home.)

---

## Campus OS contract (product B)

Student after entry. Thin map:

- Paths · Part I · Faculties · Labs · Library · Progress  
- Coach manual / roadmap only as *study* aids  
- One door to Author hub — not a dump of OS internals  

Operating modes, session protocol, linking rules, code contract → **Author hub** (or linked from Progress when student needs them), not Home.

---

## Author SDK contract (product C)

[Author hub](author/) aggregates:

- Platform SoTs (teaching-model · review-criteria · content-lifecycle)  
- chapter-fill · prompts · reviews  
- PROJECT_STATUS · governance · display/layout  
- AGENTS / `.ai/` pointer  

AI does not get a human sidebar section.

---

## Default sidebar (IA 1.0 target)

≤7 learning items + Author:

```text
Home
Начать обучение
Learning Paths
Part I · Foundations
Faculties
Labs
About (short / Home anchor)
──
Author hub
```

No Progress / Library / Gamma / single chapter / AI docs in the default rail (reachable from Path / Campus).

---

## Journeys

### Visitor → Student (Beta)

1. Home → Начать обучение  
2. Path Beta → Part I / 0  
3. Read chapter (Student Mode header)  
4. Practice · optional Progress log  

### Visitor → Student (Alpha)

1. Home → Path Alpha  
2. ROADMAP / deep track  
3. Evidence on path  

### Author

1. Author hub → SoTs → chapter-fill → DESIGN → review → Publish  

### AI

1. AGENTS → `.ai/` constitution → one role → lifecycle  

---

## Acceptance (IA 1.0 Done)

- [ ] Stranger can state product + next click in 10s (Owner or external smoke)  
- [ ] Home has **no** Author SDK / Campus OS internals  
- [ ] Default sidebar ≤7 learning links + Author  
- [ ] Author hub is the only kitchen index  
- [ ] `.ai/` not advertised on Home  
- [ ] DISPLAY + this file agree; no third competing IA story  

---

## Non-goals (this epic)

- New curriculum chapters  
- Custom React shell  
- Hiding Author hub from the repo (only from Visitor primary chrome)  
- Deleting Campus OS docs — **relocate visibility**, don’t destroy  

---

## Delivery order

1. This epic doc (binding)  
2. Ruthless Home + sidebar (aligned to matrix)  
3. Campus student page stays thin; kitchen only in Author hub  
4. Smoke: hard-refresh Pages · 10-second test  
5. Only then — next Part I chapter  

---

## Owner decision

- [ ] Agree IA 1.0 as current product priority over new chapters  
- [ ] Override (why):
