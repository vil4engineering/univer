# DISPLAY 0.1 — how people see the university

**Status:** Binding · IA refresh 2026-07-24 (Visitor / Student / Author)  
**Related:** [LAYOUT_0.1.md](LAYOUT_0.1.md) · [LANGUAGE.md](LANGUAGE.md) · [OPERATING_MODES.md](OPERATING_MODES.md) · [author/](author/)

---

## Three audiences (do not mix on Home)

| Role | Question in 30s | Sees |
|------|-----------------|------|
| **Visitor** | What is this? What do I click? | [Home](../README.md) — value prop + **Начать обучение** |
| **Student** | Where is my path / progress / lab? | Thin sidebar · [Campus](./) · Paths · Part I · chapters |
| **Author** | How do I ship a chapter? | [Author hub](author/) — fill, reviews, SoTs, governance |
| **AI** | How may I change the graph? | [`AGENTS.md`](../AGENTS.md) · [`.ai/`](../.ai/) — **not** in student sidebar |

Home must **not** be the Operating System dump (metamodel, chapter-fill, Living Product, session protocol…).

---

## Product UI

| Surface | Role |
|---------|------|
| GitHub Pages + Docsify | First product UI through **0.1** |
| Repo markdown | Source of truth |
| Leave Docsify | **v0.2 trigger** only: interactive graph / OS chrome markdown cannot carry |

No second shell in 0.1.

## Information architecture

```text
Home (Visitor)
 ├─ Начать обучение → Path Beta / Alpha
 └─ Campus (Student)
      ├─ Paths · Part I · chapters
      ├─ Progress · Labs · Library · Faculties
      └─ Author hub (kitchen — one nav link)
           └─ .ai / reviews / governance (linked, not on Home)
```

- Auto-TOC в сайдбаре (`subMaxLevel`) — **выкл** (`subMaxLevel: 0`)

## Sidebar contract (student-first)

Must stay thin:

1. Home · Начать обучение  
2. Учёба (Campus, Part I, Paths, Progress, Labs, Library)  
3. Факультеты (short list)  
4. **Author** → single hub link  

Governance, AI workflows, metamodel, design capture — **inside Author hub**, not root Campus mega-list.

Search: Docsify built-in. Catalog: [library/](library/).

## Student journeys

### Path B (foundations)

1. Home → Path Beta  
2. [Part I](../fundamentals/PART_I.md) · chapter 0…  
3. Evidence on path Progress log ([PROGRESS.md](PROGRESS.md))

### Path A (Senior prep)

1. [paths/alpha.md](paths/alpha.md)  
2. ROADMAP / deep track  
3. Evidence + mock gate  

## Topic page: Student Mode vs Author Mode

| Mode | Sees | Default |
|------|------|---------|
| **Student Mode** | Reader Header + body; Learning `<details>` | Pages default |
| **Author Mode** | Engineering `<details>`, DESIGN, reviews | Collapsed / Author hub |

## Language on screen

- Home / Campus / Paths: **RU-primary** + EN terms ([LANGUAGE.md](LANGUAGE.md))  
- `.ai/` governance: English (agents)  
- Legacy Library may stay EN-heavy until Path rewrite  

## Explicit non-goals for display 0.1

- Interactive knowledge graph  
- Custom React campus  
- Mega-sidebar of every OS doc on Home  
- Forcing every warehouse page to RU on day one  
