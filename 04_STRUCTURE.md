# 04 · Structure (v2)

**Project:** Engineering University  
**Status:** **v2**  
**Related:** [03_CURRICULUM.md](03_CURRICULUM.md) · [PROJECT_STATUS.md](PROJECT_STATUS.md) · [campus/LAYOUT_0.1.md](campus/LAYOUT_0.1.md)

## Two maps

| Map | Question | Student-facing? |
|-----|----------|-----------------|
| **Academic** | What do I study, in what order, under which faculty/skill? | Yes |
| **Storage** | Where do files live in Git? | No (implementation detail) |

## Academic map (v2)

```text
Engineering University
├── Governance (01–05, PROJECT_STATUS)
├── campus/                      ← student OS
│   ├── paths/
│   ├── faculties/               ← SE, Mobile, Backend, Infra, AI×2, …
│   ├── skills/                  ← Skill Factory registry
│   ├── labs/ · library/
│   ├── ASSISTANT_MANUAL.md
│   ├── CAREER_INTEGRATION.md
│   ├── TOPIC_TEMPLATE.md (Levels 1–3)
│   └── V2_CHECKLIST.md
├── Library warehouse            ← fundamentals/, swift/, … (unchanged paths)
├── projects/                    ← staged labs / candidates
├── Living Application           ← undecided
└── Docsify site                 ← Campus-first thin sidebar
```

## Skills layer

Executable workflows live as campus indexes (`campus/skills/`).  
Implementations may later wire to Cursor Agent Skills — registry first.

## Career OS boundary

Private Career OS stays outside. University holds pipeline contract + teachable craft.  
See [CAREER_INTEGRATION.md](campus/CAREER_INTEGRATION.md).

## Storage map (current)

v2 ship **does not** mass-move warehouse folders.  
SoT inventory: `scripts/topic_tree.py` · [campus/library/](campus/library/).

## Migration policy

1. v2 constitution + campus skeleton — **this ship**  
2. Progressive Library mapping under new faculties  
3. Skill runners / deepdive pilots  
4. Physical moves only with new Design revision + batches  
5. No delete of learning content without archive decision  

## Presentation

Docsify through current ship. Leave shell = later trigger (interactive graph / progress board).  
`subMaxLevel: 0` — no page-TOC spam in sidebar.

## What not to optimize for

Folder symmetry · one folder per buzzword · mirroring every Apple framework name.

Optimize for: progressive problem difficulty · path findability · faculty ownership · honest completeness · dual AI axes.
