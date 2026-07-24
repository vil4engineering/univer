# Principle: Knowledge Graph

The repository is organized around **concepts**, not around documents.

A concept may appear in many views. Explanations are not copied between views.

## Example

Concept: Actor

May be referenced from:

- Swift
- Concurrency
- Interview
- Production story
- Lab
- Debugging guide
- System design

Only one canonical topic owns the full explanation. Others link to it.

## Graph hygiene

- Always search for related topics before writing.
- Add cross-links: prerequisites, siblings, follow-ups, opposites, failure modes.
- Prefer merge when two pages teach the same concept under different names.
- Prefer split only when one page mixes two distinct concepts that need separate SoT nodes.
- Never leave important knowledge isolated.

## Example cross-links (Actor)

Sendable · Structured Concurrency · Isolation · Task · MainActor · Race Condition

## Architect owns the graph

Author writes prose inside a node. Architect decides whether the node should exist, merge, or only be referenced.

See [../roles/architect.md](../roles/architect.md).

## Growth rule

Prefer improving existing material. Avoid duplication. Maintain a coherent graph:

**One concept. One source of truth. Many representations.**

## Related

- [source-of-truth.md](source-of-truth.md)
- [university.md](university.md)
- [../checklists/architecture.md](../checklists/architecture.md)
