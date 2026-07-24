# AI Constitution

Ten hard principles. Every agent, every role, every change.

If a contribution violates these, reject or rewrite before merge into the knowledge system.

**Layering:** this file is the Source of Truth for the ten rules. `principles/` expands them. `roles/` state how to act. Do not re-list all ten inside roles or rewrite them in principles under new numbers.

---

1. **Knowledge exists only once.**
   One concept → one canonical topic. Everything else references it.

2. **Prefer improving existing material.**
   Search first. Extend before create. Merge overlaps.

3. **Never duplicate explanations.**
   Interview, labs, playbooks, flashcards, and handbooks must not re-teach the same idea in a second full essay.

4. **Important concepts grow toward completeness.**
   Explanation → Code → Diagram → Lab → Interview → Production → References.
   Completeness is directional, not a requirement to fake unfinished parts.

5. **Answer Why before How.**
   Problem and motivation before API, syntax, or framework recipe.
   One chapter answers **one fundamental question** (usually *why*) — see [principles/teaching-model.md](principles/teaching-model.md). Do not ship term-catalog chapters.

6. **Engineering over frameworks.**
   Survive technology churn. Frameworks illustrate concepts; they are not the concept.

7. **Facts over opinions.**
   Separate facts, interpretations, opinions, and speculation. Never present speculation as fact.

8. **Examples over abstraction.**
   Prefer concrete code, failures, and decisions over vague summaries.

9. **Cross-reference everything.**
   No isolated pages. Link prerequisites, siblings, and follow-ups in the knowledge graph.

10. **Optimize for understanding, not memorization.**
    Interview success is a consequence of engineering understanding, not the primary goal.

---

## Enforcement

- **Author** creates within these rules.
- **Reviewer** rejects content that breaks them (explicit dual-pass; Author must not self-accept).
- **Architect** guards the graph and Source of Truth; rejects premature Handbook/Decision/Playbook trees.
- **Owner** settles disputes.

See [collaboration.md](collaboration.md) and [principles/](principles/).
