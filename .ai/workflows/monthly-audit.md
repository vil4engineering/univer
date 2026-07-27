# Workflow: Monthly audit

Closes the hole: **a self-learning system without checks is a self-degrading system**. An error that lands in a published chapter spreads through cross-links faster than anyone will notice by hand.

## When to run

- Once a month (reminder only — not automation; **Owner triggers manually**)
- Off-cycle — after a mass Draft pass across several chapters in a row

## Role

**Reviewer only** ([../roles/reviewer.md](../roles/reviewer.md)), in a **separate** message/session from Author work — same discipline as [dual-pass-review.md](dual-pass-review.md). The auditor does **not** rewrite chapters; find and report only.

**Who:** Maxim only. If Timur — refuse and point to Maxim.

## Trigger (Human commands)

Any close variant:

- `/audit` · `monthly audit` · «месячный аудит»
- «прогони monthly audit» · «аудит базы»

Canonical pointer: [`AGENTS.md` → Human commands](../../AGENTS.md).

## What to check

1. **Contradictions across chapters** — the same fact/term explained differently in two or more places  
2. **Unsourced claims** — assertions not covered by `raw` / source material and not honestly marked stub/TODO  
3. **Publish-gate violations** — topics with `README.md` whose sibling `DESIGN.md` does not have every Owner Approve checklist item checked (`[x]`) — see [chapter-fill.md](chapter-fill.md)  
4. **Forgotten shelves** — under `campus/faculties/` and `ai-engineering/dictionary/terms/`, files with `Status: stub` and **no commits in the last N months** (`git log --since`). Default **N = 2 months** (≈60 days) unless Owner sets another window  
5. **Voice drift** — published chapters (past stub, sibling `DESIGN.md`) that violate Living chapter prose ([../principles/writing.md](../principles/writing.md) § Living chapter prose) after its ratification  

## Reviewer-only prompt (paste)

```text
Role: Reviewer only (Engineering Builder). Do not rewrite anything. Report only.

Scope: full repo audit, monthly cadence.

Check for:
1. Contradictions — same term/fact explained differently in two or more chapters.
   Report: file A : section, file B : section, the conflicting claims.
2. Unsourced claims — assertions not traceable to any raw material and not
   honestly marked as stub/TODO.
   Report: file : section, the claim, why it looks unsourced.
3. Publish-gate violations — any README.md whose sibling DESIGN.md does not
   have every Owner Approve checklist item checked ([x]).
   Report: topic path, which checklist items are unchecked.
4. Stale/forgotten shelves — files under campus/faculties/ and
   ai-engineering/dictionary/terms/ marked "Status: stub" with no commits
   touching them in the last 60 days (use git log --since).
   Report: file, days since last commit.
5. Voice drift — published chapters (past stub, sibling to a DESIGN.md) that
   violate Living chapter prose (.ai/principles/writing.md § Living chapter
   prose): reference-manual tone, unexplained jargon dump, long paragraphs.
   Report: file : section, which Do/Don't rule it breaks.

Output format — one table per check, columns: File | Location | Finding | Severity (blocker/thread).
No fixes, no rewrites, no edits to any file in this pass.

End with:
- Total findings by severity
- Which findings need a full Draft→Review cycle (published/Owner-gated topics)
  vs. can be fixed directly (stub/non-gated content)
```

## After the audit

1. **Report is not applied automatically.** Nothing is patched in the same pass — findings list only, with verdict per item (**blocker** / **thread**).  
2. **Published / Owner-gated chapters:** findings → new **Draft** on that chapter → normal [chapter-fill.md](chapter-fill.md) cycle — not a direct patch.  
3. **Stub / ungated warehouse content:** may be fixed immediately (improve-topic), without a full Review re-pass.  
4. **Log the run** under [`reviews/audits/`](../../reviews/audits/) — one file per month: `YYYY-MM-monthly-audit.md` (counts, top blockers, link to chat if useful). Update [PROJECT_STATUS.md](../../PROJECT_STATUS.md) “last monthly audit” one-liner when Owner ships the journal entry.

## Do not

- Rewrite curriculum while holding Reviewer role  
- Auto-commit / auto-push the report unless Owner asks  
- Start Author fixes in the same message as the audit report  
- Treat warehouse interview cards as Living chapters for voice (only DESIGN+published README past stub)

## Related

- [../roles/reviewer.md](../roles/reviewer.md)  
- [../principles/review-criteria.md](../principles/review-criteria.md)  
- [../principles/writing.md](../principles/writing.md) § Living chapter prose  
- [../checklists/topic.md](../checklists/topic.md)  
- [dual-pass-review.md](dual-pass-review.md) · [chapter-fill.md](chapter-fill.md) · [improve-topic.md](improve-topic.md)  
- [`reviews/audits/`](../../reviews/audits/) — monthly audit journal  
