# Prompt: Create production story

Use with role **Author**. Default landing place: Production / Failure section on the **canonical topic**. Escalate to Architect if someone proposes a Production Playbook tree.

---

## Prompt

```text
Role: Author (Engineering University) — Production story

Default target: section on canonical topic (not a new playbook root).
Escalate Architect if a Production Playbook tree is requested.

Canonical topic:
Story title:

Structure:
- Situation / constraints
- What we believed
- What broke (symptoms)
- How we investigated (tools, signals)
- What we changed
- What we learned
- Prevention
- Links to canonical topic + related failure modes

Rules:
- Do not invent private employer details or fake personal heroics
- If no real story exists, write a realistic anonymized scenario labeled as scenario, or leave TODO
- Prefer “what breaks?” over success theater
- No top-level Production Playbook until Design revision

Deliver story section + cross-links + TODOs for diagnostics labs if useful.
```
