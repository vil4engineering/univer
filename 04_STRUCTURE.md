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
├── Governance
│   ├── PROJECT_STATUS
│   ├── Charter
│   ├── Philosophy
│   ├── Curriculum
│   ├── Structure
│   └── Paths
├── Faculties
│   ├── Computer Science
│   ├── Software Engineering
│   ├── Mobile Engineering
│   ├── AI Engineering
│   ├── Product Engineering
│   └── Career Development
├── Curriculum program
│   ├── Semesters
│   ├── Subjects / Topics
│   ├── Laboratories
│   └── Projects
├── Living Application   ← undecided
└── Archive              ← inactive historical material
```

Students navigate **semesters, subjects, labs, projects**.  
They do not navigate storage folders as the primary UX of learning.

## Conceptual areas (roles)

| Area | Role |
|------|------|
| Governance | Mission, rules, phase control |
| Curriculum | Program of study (faculties, semesters, subjects) |
| Laboratories | One-question experiments |
| Projects | Larger constructions; future Living Application home |
| Paths | Student-specific routes through the same university |
| Reference | Glossary, stable facts, curated external links |
| Archive | Historically useful, no longer active |

## Storage map (current reality)

Phase 1 does **not** reorganize the repository.

Today, materials still live in the historical layout (examples only):

- `fundamentals/`, `swift/`, `ios-sdk/`, `architecture/`, …
- `ai-engineering/`
- co-located playgrounds
- Docsify `index.html`, `_sidebar.md`
- tooling under `scripts/`

These paths remain valid storage until a later migration plan is approved.

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

1. Governance first (this phase)
2. Revision gate
3. Curriculum index without moving files
4. Lab registry without moving files
5. Planned moves in small batches
6. No deletes without archive decision

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
