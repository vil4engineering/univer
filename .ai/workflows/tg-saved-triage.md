# Workflow: Telegram Saved triage → intake

## When

Human says: empty Saved Messages / triage Saved / inbox zero for TG.

## Read first

1. [`intake/RULES.md`](../../intake/RULES.md) — living decision rules  
2. [`intake/README.md`](../../intake/README.md) — workspace map  
3. [`../principles/content-lifecycle.md`](../principles/content-lifecycle.md) — Idea only

## Do

1. Ensure local `.env` has Telethon credentials (never commit).  
2. `python3 scripts/tg_saved_list.py --limit N` (optional `--json-out intake/.tg-saved.json`).  
3. Present items like mail; follow RULES decision tree.  
4. University-bound → write `intake/captures/YYYY-MM-DD-HHMM-<slug>.md` from template.  
5. YouTube / LinkedIn → open on service; human decides.  
6. Delete from Saved only after human confirms.  
7. New repeatable pattern → append bullet to `intake/RULES.md`.

## Do not

- Put intake in student sidebar / Home  
- Write Design or full chapters from a dump  
- Absorb private career facts into this repo  
- Commit `.env` or session files
