# Skill Factory

Reusable engineering **Skills** — workflows, executable AI agents (Cursor / coding agents).

Knowledge недостаточно. Skill превращает source или задачу в learning module / review artifact / Evidence.

## Contract (каждый Skill)

| Field | Meaning |
|-------|---------|
| **id** | Stable slug (`book-deepdive`, `architecture-review`) |
| **inputs** | What human must provide (URL, path, topic id, Level) |
| **procedure** | Steps the agent follows |
| **outputs** | Article draft, diagram notes, exercises, quiz, ADR, Evidence bullets |
| **write-back** | Where results land (Library topic, Path log, `campus/` note) |
| **non-goals** | What Skill must not invent (private career facts, fake experience) |

## How to run (v2)

1. Open chat in Engineering Builder workspace (`vil4labs/univer`).  
2. Name the Skill id from [catalog.md](catalog.md).  
3. Give inputs.  
4. Require Completeness-friendly outputs (Explain / Demonstrate / Practice / Quiz).  
5. Write Evidence into Path log — [SESSION_PROTOCOL.md](../SESSION_PROTOCOL.md).  

Human facing: [ASSISTANT_MANUAL.md](../ASSISTANT_MANUAL.md).

## Status

Registry + contract first. Wire to `~/.cursor/skills` / Agent Skills files — later pilots.
