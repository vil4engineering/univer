# Workflow: Dual-pass review

Closes the self-review hole. Author must not Accept their own draft in the same pass.

## Rules

1. After Author work, start a **new message** (or new model) with role **Reviewer only**.
2. Prefer a different model when available (e.g. Cursor Author → ChatGPT Reviewer, or reverse).
3. Reviewer uses [../roles/reviewer.md](../roles/reviewer.md), [../principles/review-criteria.md](../principles/review-criteria.md), [../principles/review-checklist.md](../principles/review-checklist.md), and [../checklists/topic.md](../checklists/topic.md).
4. For flagship chapters: write durable review under [`reviews/`](../../reviews/) (copy [_TEMPLATE.md](../../reviews/_TEMPLATE.md)).
5. Verdict **Accept** only from Reviewer. Author may only Request-changes → fix → new Reviewer pass.
6. Structure/placement issues → escalate Architect; do not “fix” by rewriting into a new tree.
7. Prefer linking **GitHub blob/raw** in the review header so external reviewers are not blocked by Docsify `#/` SPA.

## Same-chat template (Reviewer-only)

```text
Role: Reviewer only. Do not rewrite.
Target: <path>
Run review checklist. Verdict: Accept | Request changes | Reject.
Escalate Architect/Mentor?: ...
```

## Interviewer note

Interviewer must not debrief/explain in the same breath as Author rewrite unless Owner asks for debrief mode. Separate: Interviewer session → later Author fixes → dual-pass Reviewer.

Related: [../collaboration.md](../collaboration.md) · [improve-topic.md](improve-topic.md) · [monthly-audit.md](monthly-audit.md)
