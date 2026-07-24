# Intake triage rules (living)

Rules for emptying Telegram Saved Messages into this repo.  
Grow this file as we learn. Prefer short hard rules over essays.

## Goal

Inbox zero for Saved Messages: triage with a human, leave Saved empty, park university-bound raw material here for a later shelf pass.

## Workspace

| Path | Role |
|------|------|
| [`captures/`](captures/) | Raw `.md` dumps (one capture = one file) |
| [`_TEMPLATE.md`](_TEMPLATE.md) | Frontmatter + body skeleton |
| [`../scripts/tg_saved_list.py`](../scripts/tg_saved_list.py) | List / dump Saved Messages |
| [`../scripts/tg_login.py`](../scripts/tg_login.py) | Local Telethon login → `.env` |
| `.env` (repo root, gitignored) | `TELEGRAM_API_ID` / `HASH` / `SESSION` |

Never commit `.env`, `*.session`, `.tg-login-pending.json`, or `intake/.tg-saved.json`.

## Decision tree

For each Saved item:

1. **Private career / salary / employer folklore** → not here; Career OS only. Delete or ignore in Saved after human call.
2. **YouTube / LinkedIn (or similar)** → open on the service; human decides there. Dump MD here only if something must enter univer later.
3. **University craft** (SE, Mobile, AI tracks, architecture, concurrency, teaching ideas) → write `captures/*.md` from template, then delete from Saved when human confirms.
4. **Noise / meme / unrelated** → discard (delete from Saved); no capture file.
5. **Unclear** → ask human; do not invent shelf placement.

## Capture contract

- One Telegram message (or tight thread) → one markdown file under `captures/`.
- Filename: `YYYY-MM-DD-HHMM-<slug>.md`
- Keep body raw: paste / short summary + optional “why univer” + open decision.
- No Design, no chapter shape, no sidebar links from intake.
- After univer agent shelves or discards → **delete** the capture file (inbox tends to empty).

## Session flow

```text
human: «давай переберём Saved»
  → tg_saved_list (newest or oldest batch)
  → present item like mail
  → human: A intake / B career / C discard / D open link / E skip
  → execute; delete from Saved only when human confirms clean-up
  → append lessons to this RULES.md when a new pattern appears
```

## Growing rules

When triage invents a repeatable pattern, add a bullet here in the same session. Examples to watch for:

- Voice notes about interviews → Career vs univer Interview Engineering?
- Screenshots without OCR → store link/id only vs skip?
- Duplicate topics already in Library → improve-topic instead of new capture?
- **Media albums (`grouped_id`):** caption message holds the text; sibling photos with empty text are the same post — after processing, delete the whole group from Saved.
- **Informative PNGs / infographics in album:** download media into the target doc (often `ai-engineering/materials/<date-slug>/images/`), embed in README, set `Added` date + `Useful? = pending`. Do not leave images only in Telegram.

## Boundaries

- Public curriculum SoT = this repo. Private life stays out.
- Intake is **Idea** staging only ([content-lifecycle](../.ai/principles/content-lifecycle.md)).
- Commit / push only when the human asks.
