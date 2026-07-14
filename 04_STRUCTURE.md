# 04 · Structure

**Project:** Engineering University  
**Status:** Phase 1 governance  
**Related:** [03_CURRICULUM.md](03_CURRICULUM.md) · [PROJECT_STATUS.md](PROJECT_STATUS.md)

## Two maps

Engineering University keeps two maps deliberately separate.

| Map | Question it answers | Student-facing? |
|-----|---------------------|-----------------|
| **Academic map** | What do I study, in what order, under which faculty? | Yes |
| **Storage map** | Where do files live in Git? | No (implementation detail) |

Confusing these maps recreates a folder-shaped "encyclopedia" and undoes the university.

## Academic map (canonical)

```text
Engineering University
├── Governance (root 01–05, PROJECT_STATUS)
├── campus/                 ← student-facing academic map (indexes)
│   ├── paths/
│   ├── faculties/
│   ├── labs/               ← registry (points at playgrounds + projects)
│   ├── library/            ← map to legacy topic folders
│   ├── TOPIC_TEMPLATE.md
│   ├── LINKING.md
│   └── SESSION_PROTOCOL.md
├── Faculties (conceptual)
├── Library (storage)       ← fundamentals/, swift/, … (existing)
├── projects/               ← staged Xcode/SPM intakes
├── Living Application      ← undecided
├── Knowledge Graph         ← via LINKING + future registry
├── Assessment / Portfolio  ← future
└── Docsify site            ← sidebar: Campus first, Library second
```

Students navigate **campus → paths/faculties/labs**.  
Library folders remain for search and depth.

## Conceptual areas (roles)

| Area | Role |
|------|------|
| Governance | Mission, rules, phase control — Charter is the constitution |
| Curriculum | Program of study (faculties, semesters, subjects) |
| Paths | Student-specific routes through the same university |
| Laboratories | One-question experiments (inside the university) |
| Projects | Larger constructions; future Living Application home |
| Knowledge Graph | Links between problems, decisions, labs, and reuse (future) |
| Assessment | Mastery / progress against Completeness and lesson gates (future) |
| Engineering Portfolio | Evidence of demonstrated, tested, reused work (future) |
| Reference | Glossary, stable facts, curated external links |
| Archive | Historically useful, no longer active |

## Storage map (current reality)

Phase **Order** keeps warehouse paths in place. Materials still live in the historical layout:

- `fundamentals/`, `swift/`, `ios-sdk/`, `architecture/`, …
- `ai-engineering/`
- co-located playgrounds
- Docsify `index.html`, thin `_sidebar.md` (Campus-first)
- catalog SoT under `scripts/topic_tree.py`

Physical migration waits for **Design → Ship 0.1**.

### Future physical layout (proposal only — not executed)

When migration begins (after governance revision), prefer role-based roots such as:

```text
/
├── PROJECT_STATUS.md
├── 01_CHARTER.md
├── 02_PHILOSOPHY.md
├── 03_CURRICULUM.md
├── 04_STRUCTURE.md
├── 05_PATHS.md
├── curriculum/          # subject materials indexed by faculty/subject ids
├── labs/                # lab packages
├── projects/            # project work; living app when chosen
├── paths/               # path indexes (not duplicate content)
├── reference/
├── archive/
└── site/                # presentation shell (Docsify or successor)
```

Exact names can change. The invariant is: **academic identity ≠ path string**.

## Mapping rule

Every durable learning artifact should eventually declare:

- Faculty
- Subject (curriculum id)
- Stage in the learning pipeline
- Completeness gates status
- Storage location (path)
- Related lab / project ids (if any)

Until that registry exists, do not mass-move files.

## Laboratories in structure

Labs may live:

- inside this repository under a future `labs/` area, or
- in independent lab repositories linked from the university

Independence is allowed when it improves focus. Absorption is optional and later.

## Living Application in structure

Placeholder only:

```text
projects/living-application/   # does not exist yet; must not be filled by defaulting to an existing app
```

Selection remains intentionally undecided.

## Presentation layer

Docsify (or a future site) should eventually present:

- Paths
- Semesters
- Faculties / subjects
- Lab registry
- Completeness status

It should stop presenting the Git tree as the primary table of contents when curriculum indexes exist.

## Migration policy

1. Governance first — Done  
2. System specs (progress, modes, metamodel) — Done  
3. **Order** — Done · [REVISION_CHECKLIST](campus/REVISION_CHECKLIST.md)  
4. **Design 0.1** — Done · [LAYOUT_0.1](campus/LAYOUT_0.1.md) · [DISPLAY_0.1](campus/DISPLAY_0.1.md)  
5. **Ship 0.1** — Done · [SHIP_0.1_CHECKLIST](campus/SHIP_0.1_CHECKLIST.md) · **no mass-move**  
6. Later moves only via new Design revision + small batches  
7. No deletes of learning content without archive decision  

### Future physical layout (still proposal — not 0.1)

The tree below is **not** executed. 0.1 keeps warehouse roots at repo top level.

## What not to optimize for

Do not optimize the repository for:

- beautiful folder symmetry
- one folder per buzzword
- mirroring every Apple framework name

Optimize for:

- progressive problem difficulty
- findability through learning paths
- clear faculty ownership
- honest completeness
