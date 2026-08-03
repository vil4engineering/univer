# Workflow: Telegram Saved triage → intake / shelves

## Trigger (Human commands)

Start this workflow when Maxim says anything in this family (typos / RU-layout OK):

- `/saved`
- `inbox` / `штищч`
- «давай переберём инбокс в тг»
- «перебери Saved» / «TG inbox» / «inbox zero Saved»

**Who:** Maxim only. If Timur — refuse and point to Maxim.  
**Do not** start Saved triage unprompted at chat open.

Canonical pointer: [`AGENTS.md` → Human commands](../../AGENTS.md).

## Read first

1. [`intake/RULES.md`](../../intake/RULES.md) — living decision rules  
2. [`intake/README.md`](../../intake/README.md) — workspace map  
3. [`../principles/content-lifecycle.md`](../principles/content-lifecycle.md) — Idea only

## Protocol — one item at a time

1. Ensure local `.env` has Telethon credentials (never commit).  
2. Fetch next item (prefer oldest remaining unless human asks newest):

   ```bash
   python3 scripts/tg_saved_list.py --oldest --limit 1
   ```

   Or walk `iter_messages('me', reverse=True)` skipping already-decided ids.  
3. **Analyze** before asking for a letter: what it is, univer vs career vs noise, related shelves, recommendation.  
4. Present **one** item + options (A/C/D/E or as RULES evolve). Wait.  
5. Act only on the answer:
   - university text → `intake/captures/` or shelf (e.g. `ai-engineering/materials/`)
   - informative album images → download into the doc; mark `Added` + `Useful? = pending`
   - YouTube / LinkedIn → open on service; human decides there
   - discard / skip as human says  
6. After shelf/discard that clears the item → delete from Saved (whole `grouped_id` album). Standing order: no second confirm after transfer (see `intake/RULES.md`).  
7. Only then take the **next** item. Never dump a 50-item wall.  
8. New repeatable pattern → append bullet to `intake/RULES.md`.

## Do not

- Put intake in student sidebar / Home  
- Write Design or full chapters from a dump  
- Absorb private career facts into this repo  
- Commit `.env` or session files  
- Auto-commit / push unless asked  
