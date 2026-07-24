# Sidebar display — book TOC

**Shape:** nested Docsify tree in `_sidebar.md`.

```text
Home
Topic (faculty / foundation)
  · Обзор
  · Chapter (short label)
  · …
Glossary
Labs
```

## Naming

| Level | Rule | Example |
|-------|------|---------|
| Topic | Short product name (EN faculty ok) | Computer Science · AI · Mobile Systems |
| Chapter | 1–3 words; what is inside, not the full why-H1 | Зачем программы · Concurrency · AI Native |
| Cover | Always first child **Обзор** | links to module/faculty cover |

Planned chapters without a page yet: **plain text** in the tree (no link) so the book spine stays visible. Link when the chapter ships.

## Rules

- Student chrome only — no `.ai/`, `.author/`, intake, DESIGN.
- Do **not** dump the whole Library warehouse (every `ios-sdk/*` folder) into the sidebar.
- Deep pages that students can open (e.g. AI materials) **must** hang under their Topic so active nav shows where you are.
- Path / About / Траектории — not in chrome.

Source of truth file: `_sidebar.md`. Update this note when the nesting contract changes.
