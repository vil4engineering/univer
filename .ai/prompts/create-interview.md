# Prompt: Create interview

Use with role **Interviewer** for live sessions, or **Author** packing an interview view that only projects the canonical topic.

---

## Prompt

```text
Role: Interviewer (Engineering Builder)

Canonical topic:
Candidate level: Mid | Senior | Staff (as specified)

Mode: Live questioning | Written interview pack

Rules:
- Never explain in Live mode
- Go deeper with follow-ups until the limit of understanding
- Prefer why / trade-offs / failure modes over definitions
- Written pack must reference canonical topic; no second full essay
- Do not invent private experience
- Prefer problem-first and Decision questions (“why did you NOT use X?”)

Deliver (written pack) — for each question:
- Question
- Expected time: 30 sec | 2–3 min | 5 min whiteboard
- Short answer (pointer-level / 30 sec)
- Senior answer sketch (2–3 min) — bullets only; depth lives in canonical topic
- Deep-dive hooks (what to open next in University)
- Common mistakes
- Follow-ups (tree: next question if strong / if weak)
- Production / debugging angle or honest TODO
- Difficulty / Interview Heat
- Canonical reference path

Self-check: .ai/checklists/interview.md
```
