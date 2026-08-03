# OpenSpec in opencode (teletype experience)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `503196` |
| Related | [AI materials](README.md) |
| URL | https://teletype.in/@easy_dev991/TQsjWIzfHde |

---

## URL

https://teletype.in/@easy_dev991/TQsjWIzfHde

## Выжимка

Опыт на рабочем проекте: **openspec** внутри **opencode** — doc-first flow с артефактами в репо. Плюсы: стандартизированный процесс, легко продолжить сессию. Минусы: агент часто пишет EN-доки и мусор — артефакты всегда перечитывай; качество зависит от модели и `AGENTS.md`.

## Выжимка

Workflow на проекте с **openspec** в **opencode**:

- `openspec init` → выбор tools → commit skills/commands
- Малая фича: `/opsx-ff <slug>` → артефакты → review → `/opsx-apply`
- Стандартная фича: `/opsx-new` → `/opsx-continue` через proposal → design → specs → tasks → apply
- По готовности: `/opsx-verify`, затем `/opsx-archive`
- Плюсы: doc-first, артефакты в репо, удобное resume
- Минусы: EN в доках, иногда мусор — перепроверяй; качество = модель + `AGENTS.md`

## Попробовать применить

Кандидат в workflow для agent harness и Design gates глав — сравни с локальным Creator Portal и chapter-fill.
