# DISPLAY 0.1 — how the student sees the university

**Status:** Binding for University **0.1**  
**Related:** [LAYOUT_0.1.md](LAYOUT_0.1.md) · [LANGUAGE.md](LANGUAGE.md) · [OPERATING_MODES.md](OPERATING_MODES.md)

Спека отвечает: *что видит студент в браузере* и *как ходит по универу*.

## Product UI

| Surface | Role |
|---------|------|
| GitHub Pages + Docsify | First product UI through **0.1** |
| Repo markdown | Source of truth |
| Leave Docsify | **v0.2 trigger** only: need interactive graph, heatmap board, or OS that markdown cannot carry |

No second shell in 0.1.

## Information architecture

```text
Home
 └─ Campus
     ├─ Path Alpha / Beta / Gamma     ← primary learning routes
     ├─ Faculties                    ← competency owners
     ├─ Labs · Projects map
     ├─ Library catalog              ← full topic list (Goal 1 search aid)
     ├─ Progress · Language · OS specs
     └─ Governance (Charter …)
```

- Auto-TOC в сайдбаре (`subMaxLevel`) — **выкл** в 0.1 (`subMaxLevel: 0`); заголовки страницы не дублируются в nav

## Sidebar contract (0.1)

Must stay thin:

1. Campus (home + key OS links)  
2. Paths  
3. Faculties  
4. Governance  
5. Warehouse & projects (catalog + projects only)

Search: Docsify built-in search across pages. Catalog page = browsable map when search is not enough.

## Student journeys

### Path A (Senior+/Lead bootcamp)

1. Open [paths/alpha.md](paths/alpha.md)  
2. Take current Stage (start **1** after 0.1 unlock)  
3. Follow Library hooks → onion / labs  
4. Write Evidence into Progress log on the same path page  
5. Advance only with Evidence + mock gate ([PROGRESS.md](PROGRESS.md))

### Path B (foundations)

1. [paths/beta.md](paths/beta.md)  
2. Layer 0–2; same Evidence discipline when a stage is active  

### Goal 1 — find a topic fast

1. Docsify Search **or** [library/](library/) catalog  
2. Deep link still works: `/swift/concurrency/` etc. (warehouse URLs stable)

## Language on screen

- Campus / path / faculty **new or touched** pages: RU-primary + EN terms ([LANGUAGE.md](LANGUAGE.md))  
- Legacy Library pages may remain EN-heavy until Path rewrite  
- No bilingual dual chrome; no EN-only product voice

## Progress without a custom app

| Need | 0.1 mechanism |
|------|----------------|
| Status / confidence | Tables on path pages + PROGRESS vocabulary |
| Evidence | Session write-back → path Progress log ([SESSION_PROTOCOL.md](SESSION_PROTOCOL.md)) |
| Interview Heat | Marked on topics / stages in prose or table columns |
| Completeness | Onion + lab graduation notes — markdown checklists |

## Labs & projects display

- Registry: [labs/](labs/) with stable `lab-*` / `lab-pg-*` ids  
- Path stage rows cite lab ids and Library paths  
- [projects-map.md](projects-map.md) for Xcode/SPM entry — not a demo zoo homepage

## Explicit non-goals for display 0.1

- Interactive knowledge graph  
- SPA / custom React campus  
- Restoring mega-sidebar Library lists  
- Living Application dashboard  
- Forcing every warehouse page to RU on day one
