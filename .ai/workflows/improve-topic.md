# Workflow: Improve topic

End-to-end playbook for changing an existing canonical topic (or creating one only after Architect approve).

```text
1. Search repo for the concept (and near-duplicates)
2. If new file / merge / move doubt → Architect first
   - Run checklists/graph-health.md + architecture.md
3. Author: prompts/improve-topic.md (or create-topic.md if Architect approved create)
4. Dual-pass Reviewer: workflows/dual-pass-review.md
5. Mentor skim if learner-facing / Level 1 clarity matters
6. checklists/topic.md must pass
7. Stop — do not expand into Handbook trees or unrelated topics
```

Escalate to Architect when: placement unclear, duplicate found, mass rename, or someone asks for `handbook/` / Decision Book root.

Escalate to Curriculum Designer when: the issue is route/order/hours, not page prose.

Related: [../roles/author.md](../roles/author.md) · [../roles/architect.md](../roles/architect.md) · [../roles/reviewer.md](../roles/reviewer.md)
