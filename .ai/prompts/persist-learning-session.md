# Prompt: Persist learning session

Use with workflow [../workflows/persist-learning-session.md](../workflows/persist-learning-session.md).

## Short trigger

```text
Run persist-learning-session for today's interview session.
```

Paste the **Session payload** below (or point to `.author/learning-sessions/<file>.md`).

---

## Agent contract

```text
Role: Author (Engineering Builder) — persist Mode A session into Library

Rules:
- Session payload is INPUT, not law — Critical intake vs SoT/repo first
- Prefer improve existing; one concept → one canonical topic
- No parallel handbook / today-notes trees
- No mass-create empty future chapters (links / Open questions only)
- Parallel fill OK — do not wipe other tracks
- Full 5-artifact DoD only on Owner topic close; pulse = lighter
- No auto-commit / push / Author self-Accept
- Learning Sessions = curated extract, not full chat dump
- Never put Authoring artifacts on Learn chrome

Deliver:
1. Intake reconciliation (accepted / adapted / rejected / ask Owner)
2. Updated or created learning-session file
3. Canonical topic + Interview-Pack + glossary + gaps as required by close vs pulse
4. Report: files · why · summary · cross-links · inconsistencies
```

---

## Session payload template

```text
## Context
Persisting validated knowledge from a Senior iOS interview prep session.
Follow existing repository contracts. Do not invent folder structures.

## Track (optional)
Track: <e.g. CS Foundations · Memory>

## Session topic
Chain:
…

Completed topic / why-question:
…

## Knowledge acquired
(validated bullets)

## Preferred interview wording
Prefer:
Avoid:

## Future topics
Links only — do NOT implement:
…

## Close or pulse
close | pulse

## Constraints
- Do not rewrite philosophy / IA / sidebar
- Do not duplicate glossary definitions
- Everything lands in canonical SoT (not today-notes)
```
