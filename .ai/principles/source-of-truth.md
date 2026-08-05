# Principle: Source of Truth

Engineering Builder (this repository) is the canonical Source of Truth for public curriculum knowledge.

## Rules

1. Never duplicate information.
2. If a topic already exists, improve it.
3. Every topic should exist exactly once.
4. Everything else should reference that topic.

## Projections must reference, not rewrite

These are views over the graph, not second encyclopedias:

- Interview Handbook / interview packs
- Decision Book / decision registry
- Production Playbook
- Labs
- Flashcards
- Learning Paths / Handbooks

Each may add view-specific structure (question form, lab steps, checklist) but must point at the canonical topic for explanations.

**Architect hard cut:** do not create top-level Handbook / Decision Book / Production Playbook directory trees until Design revision. Until then, land decision / production / interview material as sections on the canonical topic, Path notes, or faculty hooks.

## Campus vs Library

- **Campus** — academic OS: Paths, faculties, Skills, Evidence.
- **Library** — warehouse of topic material.
- Campus-first navigation; no mass-move of warehouse without Design revision.

## Boundaries

- Private career material ([vil4max/career](https://github.com/vil4max/career)) is outside this SoT. Do not absorb salary, CRM, employer folklore, or private scripts here.
- Do not invent experience to fill “production example” gaps. Mark TODO / Open questions instead.

## Conflict resolution

If two explanations disagree:

1. Prefer the canonical topic path designated by Architect / Owner.
2. Merge facts into one page; delete or stub the duplicate with a redirect link.
3. Update all projections to reference the survivor.

Delivery planes and prep write-back sinks: [knowledge-access.md](knowledge-access.md).

## Related

- [knowledge-graph.md](knowledge-graph.md)
- [knowledge-access.md](knowledge-access.md)
- [../constitution.md](../constitution.md)
- [../roles/architect.md](../roles/architect.md)
