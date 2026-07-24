# Prompt: Create debugging case

Use with role **Author**. One case → one failure class tied to a canonical concept.

---

## Prompt

```text
Role: Author (Engineering Builder) — Debugging case

Canonical topic / failure class:
Environment (e.g. iOS app, backend, concurrency):

Structure:
- Symptom (what the engineer sees)
- Possible causes (ranked)
- How to investigate (tools, probes, what to measure)
- How to confirm root cause
- Fix
- How to avoid / guardrails
- Related concepts to link

Rules:
- Teach diagnosis, not only the fix
- No fake stack traces attributed to private work
- Reference SoT; do not paste a full second explanation of the concept

Deliver case + links + optional mini-lab hook.
Self-check ideas: .ai/checklists/lab.md (if turned into a lab)
```
