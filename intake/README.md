# Intake — Saved Messages workspace

Working directory for Telegram Saved → university Idea staging.

**Not** Library. **Not** Campus navigation. **Not** a published chapter.  
**Not** in `_sidebar.md`.

| File / folder | What |
|---------------|------|
| [`RULES.md`](RULES.md) | Living triage rules (grow while exporting) |
| Command | Maxim: `/saved` · `inbox` · «переберём инбокс в тг» → [workflow](../.ai/workflows/tg-saved-triage.md) |
| [`captures/`](captures/) | Raw `.md` dumps waiting to be shelved |
| [`_TEMPLATE.md`](_TEMPLATE.md) | Capture skeleton |
| [`../scripts/tg_saved_list.py`](../scripts/tg_saved_list.py) | Fetch Saved list |
| [`../scripts/tg_login.py`](../scripts/tg_login.py) | Telethon login into local `.env` |

Lifecycle slot: **Idea** — [content-lifecycle](../.ai/principles/content-lifecycle.md).  
Later univer agent: read `captures/` → shelf into topics / glossary / discard → delete file.

## Quick start

```bash
# once: API id/hash in .env, then
python3 scripts/tg_login.py --phone '+...'
python3 scripts/tg_login.py --code '...'
# if 2FA:
python3 scripts/tg_login.py --password '...'

python3 scripts/tg_saved_list.py --limit 30
```

Secrets stay in gitignored `.env` at repo root.
