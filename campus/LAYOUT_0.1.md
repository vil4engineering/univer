# LAYOUT 0.1 — filesystem & storage map

**Status:** Binding for University **0.1**  
**Related:** [DISPLAY_0.1.md](DISPLAY_0.1.md) · [04_STRUCTURE.md](../04_STRUCTURE.md) · [LANGUAGE.md](LANGUAGE.md)

Спека отвечает: *куда на диске что лежит* и *что переезжает в 0.1*. Academic map ≠ path string.

## Design answers (fixed checklist)

| # | Question | Decision 0.1 |
|---|----------|--------------|
| 1 | Primary student entry? | **Path** (Alpha / Beta / Gamma), не «все faculties сразу» и не Library dump |
| 2 | Where does the catalog live? | `scripts/topic_tree.py` → [library/](library/) page; sync via `check_library_sync.py` |
| 3 | What is in sidebar? | See [DISPLAY_0.1.md](DISPLAY_0.1.md) |
| 4 | Mass-move warehouse? | **No** for 0.1. Pain not proven; URLs and playgrounds stay |
| 5 | Docsify? | Stay through 0.1; leave = v0.2 trigger (interactive graph / progress board) |
| 6 | Progress UI without app? | Markdown: path Progress log + [PROGRESS.md](PROGRESS.md) statuses |
| 7 | Labs / projects on Path? | Lab registry ids + hooks on stage rows; `projects/` staged, not Core World |
| 8 | Out of 0.1? | Core World product pick; interactive knowledge graph; daily Interview Mode ritual UI; bulk RU rewrite of ~65 READMEs |

## Physical layout (0.1 — as shipped)

```text
/
├── PROJECT_STATUS.md          # phase gate
├── 01_CHARTER.md … 05_PATHS.md
├── README.md                  # entry → campus / Path
├── index.html · _sidebar.md   # Docsify shell (thin)
├── campus/                    # academic OS (indexes + specs)
│   ├── paths/                 # Alpha, Beta, Gamma + Evidence logs
│   ├── faculties/             # competency owners → Library links
│   ├── labs/                  # lab id registry
│   ├── library/               # full warehouse catalog
│   ├── LAYOUT_0.1.md · DISPLAY_0.1.md
│   └── LANGUAGE.md · PROGRESS.md · …
├── fundamentals/ · swift/ · ios-sdk/ · …
│                              # Library warehouse (unchanged paths)
├── projects/                  # staged labs / candidates (not Living App)
├── reference/ · glossary/
├── assets/ · scripts/
└── .nojekyll
```

## Roles

| Area | Role in 0.1 |
|------|-------------|
| `campus/` | Only place students *should* start; OS + navigation |
| Warehouse roots | Storage + Docsify deep links + playgrounds |
| `projects/` | Lab / cite; **not** auto Living Application |
| `scripts/topic_tree.py` | Inventory SoT (not sidebar generator) |

## Move policy

- **0.1:** zero mass `git mv` of topic trees.
- **Later:** only if a Design revision names concrete pain (tooling, onboarding, broken mental model) and a batch plan with link updates.
- Learning content is never deleted without an archive decision.

## Batch plan (explicitly empty for 0.1)

| Batch | Action | When |
|-------|--------|------|
| — | none | — |

Optional later batches (not authorized now): `library/<section>/…` rename, `site/` shell extract, `curriculum/` subject ids.

## Invariants

1. Academic identity (faculty / subject / path stage) ≠ folder name.  
2. Completeness / Evidence live on Path + topic, not in directory beauty.  
3. New durable pages declare campus links (path / faculty / lab ids) over time — progressive, not all-at-once.
