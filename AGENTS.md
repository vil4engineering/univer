# univer — notes for AI agents

**Public** Engineering University **v2** · org [vil4engineering](https://github.com/vil4engineering) · site [vil4engineering.github.io/univer](https://vil4engineering.github.io/univer/) · repo `vil4engineering/univer`

## Read first (order)

1. [`.ai/README.md`](.ai/README.md) — constitution · collaboration · roles  
2. **New / flagship chapter:** [`.ai/workflows/chapter-fill.md`](.ai/workflows/chapter-fill.md)  
   - design: [`.ai/prompts/design-chapter.md`](.ai/prompts/design-chapter.md) — change **only** `# Тема`  
   - write: [`.ai/prompts/write-chapter.md`](.ai/prompts/write-chapter.md) after DESIGN approve  
3. Human coach: [`campus/ASSISTANT_MANUAL.md`](campus/ASSISTANT_MANUAL.md)  
4. Study spine: [`campus/ROADMAP_SENIOR.md`](campus/ROADMAP_SENIOR.md) · Mode A [`campus/OPERATING_MODES.md`](campus/OPERATING_MODES.md) · Path [`campus/paths/alpha.md`](campus/paths/alpha.md)

Pick **one** role per task. Do not skip the constitution. Dual-pass Reviewer before Accept.

**Private career:** [vil4max/career](https://github.com/vil4max/career) — never absorb private facts here.

## Learning vs authoring

| Mode | Entry |
|------|--------|
| Student A prep (now) | Path Alpha · M03 `swift/concurrency` · Evidence write-back |
| Student B foundations | Path Beta · `fundamentals/what-is-programming` (DESIGN ready) |
| Author a chapter | `chapter-fill` only — not ad-hoc essays |
| Tiny fix on existing page | [`.ai/workflows/improve-topic.md`](.ai/workflows/improve-topic.md) |

## Conventions

- SE center; Mobile Systems = depth faculty; AI = assisted + technology  
- Campus-first; Library = warehouse; no mass-move without Design  
- RU-primary + EN terms ([`campus/LANGUAGE.md`](campus/LANGUAGE.md) · [`.ai/principles/language.md`](.ai/principles/language.md))  
- Ideas over tech catalogs ([`.ai/principles/content-philosophy.md`](.ai/principles/content-philosophy.md))  
- Chapter shape ([`.ai/principles/chapter-shape.md`](.ai/principles/chapter-shape.md) · [`TOPIC_TEMPLATE.md`](campus/TOPIC_TEMPLATE.md))  
- Evidence on Path logs; no invented experience; commit/push only when asked  
- Org slug rules: `vil4engineering` · curriculum repo `univer`

## Catalog tooling

```bash
python3 scripts/check_library_sync.py
python3 scripts/write_library_map.py
```
