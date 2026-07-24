# IA 1.0 — Information Architecture

**Status:** Binding epic · updated 2026-07-24 (Creator Portal / Learn split)  
**Goal:** 10-second Visitor test + **physical separation of Learn vs Engine**.  
**Priority:** Above new chapters.

Related: [DISPLAY_0.1.md](DISPLAY_0.1.md) · [`.author/`](../.author/) · [LAYOUT_0.1.md](LAYOUT_0.1.md)

---

## Three layers (official)

| Layer | Name | Audience | Lives where | On public Learn chrome? |
|-------|------|----------|-------------|-------------------------|
| **1** | **Learning** | Visitor, student | Home · Paths · Chapters · Labs · Faculties · Campus (study) | **Yes** |
| **2** | **Authoring** | Authors, teachers | [`.author/`](../.author/) · reviews · TOPIC_TEMPLATE | **No** |
| **3** | **Engineering** | Owner, AI agents | [`.ai/`](../.ai/) · AGENTS · status · metamodel | **No** |

Analogy: MIT students do not see accreditation checklists on the lobby wall. Those exist backstage.

**Product names:**

- **Engineering University** = Layer 1 (public product)  
- **Campus OS** = study OS inside Layer 1 (paths, progress, labs)  
- **Creator Portal / University Engine** = Layer 2 + 3 ([`.author/`](../.author/) + [`.ai/`](../.ai/))

---

## Why review-criteria must not be “on the web” for students

`review-criteria`, `teaching-model`, `content-lifecycle`, chapter-fill, prompts — are **Authoring**, not lessons.

If they appear in the student sidebar or Home, the visitor asks: *Do I need to read this?*  
Answer: **no** → they must not compete with chapters.

Files may still exist in the git repo / deep URLs (GitHub Pages hosts the tree).  
**Publication rule:** not linked from Learn chrome (Home, student sidebar, Campus study map).

---

## Roles

| Role | Surface |
|------|---------|
| **Visitor** | [Home](../README.md) |
| **Student** | Paths · Part I · chapters · Campus |
| **Author** | [`.author/`](../.author/) (repo) |
| **AI** | [AGENTS.md](../AGENTS.md) · [`.ai/`](../.ai/) |

---

## Visibility matrix

| Surface | Visitor | Student | Author | AI |
|---------|---------|---------|--------|-----|
| Public Home | Primary | Entry | **No** | No |
| Docsify sidebar | Learn only | Learn only | **No** | No |
| Campus (study) | Optional | Primary | No kitchen links | No |
| `.author/` Creator Portal | No | No | **Primary** | Linked |
| `.ai/` · AGENTS | No | No | Via portal | **Primary** |
| teaching-model · review-criteria · lifecycle | No | No | Yes | Yes |

---

## Public Home contract

Only Layer 1. Soft promise · mental model · manifesto · Start Learning.  
No Author / AI / review-criteria / teaching-model.

---

## Default sidebar (Learn only)

```text
Home
Начать обучение
Learning Paths
Part I
Faculties
Labs
About
```

**No** Author hub. **No** Creator Portal. **No** `.ai` docs.

---

## Creator Portal entry

Repo path: [`.author/README.md`](../.author/README.md)

Canonical SoTs remain under `.ai/principles/` (agents). Portal **indexes** them for humans — no duplicate essays.

Future (optional): physical move of author-facing copies into `.author/` when links are batch-updated — not required to fix Learn pollution.

---

## Acceptance

- [x] Author / review-criteria **removed** from student sidebar  
- [x] Home has **no** Author/AI CTA  
- [x] `.author/` Creator Portal exists  
- [ ] Owner 10s smoke on Pages (Learn only)  
- [ ] Owner Agree below  

---

### Owner decision

- [ ] Agree Learn ↔ Engine split (Creator Portal)  
- [ ] Override (why):
