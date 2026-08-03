# Creator Portal

**Not Learning.** Not for students on the public university site.

This is the **University Engine** / Author SDK: how content is designed, reviewed, and shipped.

```text
Layer 1 — Learning     → public site (Home · Paths · Chapters · Labs)
Layer 2 — Authoring    → this portal
Layer 3 — Engineering  → .ai/ · AGENTS · automation · metamodel
```

IA: [`campus/IA_1.0.md`](../campus/IA_1.0.md).

Students must **not** see this in the Docsify sidebar. Authors open it from the **repo** (GitHub / local), not as a Learn CTA.

---

## Authoring SoTs (Layer 2)

| Doc | Job |
|-----|-----|
| [teaching-model](../.ai/principles/teaching-model.md) | Why chapters are built this way |
| [review-criteria](../.ai/principles/review-criteria.md) | How chapters are scored |
| [content-lifecycle](../.ai/principles/content-lifecycle.md) | Idea → Publish → Evidence |
| [content-philosophy](../.ai/principles/content-philosophy.md) | Ideas over tech catalogs |
| [chapter-shape](../.ai/principles/chapter-shape.md) | Section spine |
| [TOPIC_TEMPLATE](../campus/TOPIC_TEMPLATE.md) | Markdown chrome |

Playbooks: [chapter-fill](../.ai/workflows/chapter-fill.md) · [monthly-audit](../.ai/workflows/monthly-audit.md) (Reviewer only) · [Swift shelf handoff](SWIFT_SHELF_HANDOFF.md) (repo SoT fences for Swift / concurrency units).

Path Alpha author map: [paths-alpha.md](paths-alpha.md).

---

## Ship a chapter

1. [chapter-fill](../.ai/workflows/chapter-fill.md)  
2. [design-chapter](../.ai/prompts/design-chapter.md) — only `# Тема`  
3. Owner Approve → [write-chapter](../.ai/prompts/write-chapter.md)  
4. Review journal → [`reviews/`](../reviews/)  

---

## Engineering (Layer 3)

| Need | Where |
|------|--------|
| AI agents | [AGENTS.md](../AGENTS.md) · [`.ai/README`](../.ai/README.md) |
| Project status | [PROJECT_STATUS](../PROJECT_STATUS.md) |
| IA / Display | [IA 1.0](../campus/IA_1.0.md) · [DISPLAY](../campus/DISPLAY_0.1.md) |
| Governance specs | [01](../01_CHARTER.md) · [02](../02_PHILOSOPHY.md) · [03](../03_CURRICULUM.md) |
| Metamodel · Layout · Language | [METAMODEL](../campus/METAMODEL.md) · [LAYOUT](../campus/LAYOUT_0.1.md) · [LANGUAGE](../campus/LANGUAGE.md) |
| Design capture · Living Product | [DESIGN_CAPTURE](../campus/DESIGN_CAPTURE_LIVING_UNIVERSITY.md) · [LIVING_PRODUCT](../campus/LIVING_PRODUCT.md) |
| Code contract · Session · Linking | [CODE_CONTRACT](../campus/CODE_CONTRACT.md) · [SESSION](../campus/SESSION_PROTOCOL.md) · [LINKING](../campus/LINKING.md) |

---

## Rule

If a document helps **build** the university, it lives here (or under `.ai/`).  
If it helps someone **learn**, it lives under Learn (Home · Paths · chapters · Labs).

Do not put review-criteria, teaching-model, or chapter-fill on the public Home or student sidebar.
