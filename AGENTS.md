# univer — notes for AI agents

**Public** Engineering University **v2** · org [vil4engineering](https://github.com/vil4engineering) · site [vil4engineering.github.io/univer](https://vil4engineering.github.io/univer/) · repo `vil4engineering/univer`

## Read first (order)

1. [`.ai/README.md`](.ai/README.md) — constitution · collaboration · roles  
2. **Platform SoTs (before new chapters):**  
   - [teaching-model](.ai/principles/teaching-model.md) — why we teach  
   - [review-criteria](.ai/principles/review-criteria.md) — how we score  
   - [content-lifecycle](.ai/principles/content-lifecycle.md) — idea → Evidence · chapter = product  
3. **New / flagship chapter playbook:** [`.ai/workflows/chapter-fill.md`](.ai/workflows/chapter-fill.md)  
4. Human coach: [`campus/ASSISTANT_MANUAL.md`](campus/ASSISTANT_MANUAL.md)  
5. Study spine: [`campus/ROADMAP_SENIOR.md`](campus/ROADMAP_SENIOR.md) · Mode A [`campus/OPERATING_MODES.md`](campus/OPERATING_MODES.md) · Path [`campus/paths/alpha.md`](campus/paths/alpha.md)

Pick **one** role per task. Dual-pass Reviewer before Accept. Chapters are **products**, not dump docs.

**Private career:** [vil4max/career](https://github.com/vil4max/career) — never absorb private facts here.

## Learning vs authoring

| Mode | Entry |
|------|--------|
| Student A prep (now) | Path Alpha · M03 `swift/concurrency` · Evidence write-back |
| Student B foundations | Path Beta · Part I · ch.0 [why programming exists](fundamentals/what-is-programming/) · [0001b](reviews/0001b-what-is-programming.md) |
| Author a chapter | [Author hub](campus/author/) · Platform trio · `chapter-fill` |
| Tiny fix on existing page | [`.ai/workflows/improve-topic.md`](.ai/workflows/improve-topic.md) |

## Conventions

- SE center; Mobile Systems = depth faculty; AI = assisted + technology  
- Campus-first; Library = warehouse; no mass-move without Design  
- RU-primary + EN terms ([`campus/LANGUAGE.md`](campus/LANGUAGE.md) · [`.ai/principles/language.md`](.ai/principles/language.md))  
- Ideas over tech catalogs ([content-philosophy](.ai/principles/content-philosophy.md))  
- **Platform trio:** [teaching-model](.ai/principles/teaching-model.md) · [review-criteria](.ai/principles/review-criteria.md) · [content-lifecycle](.ai/principles/content-lifecycle.md)  
- Chapter shape → Topic template chrome  
- Evidence on Path logs; no invented experience; commit/push only when asked  
- Org slug rules: `vil4engineering` · curriculum repo `univer`

## Catalog tooling

```bash
python3 scripts/check_library_sync.py
python3 scripts/write_library_map.py
```
