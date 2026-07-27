# Monthly audit — 2026-07

- **Date:** 2026-07-26  
- **Trigger:** Owner (off-cycle / first formalized run)  
- **Role:** Reviewer only · no rewrites in-pass  
- **Playbook:** [`.ai/workflows/monthly-audit.md`](../../.ai/workflows/monthly-audit.md)  
- **Window (stale stubs):** 60 days  

## Counts

| Severity | Count |
|----------|------:|
| blocker | 13 |
| thread | 22 |
| Stale `Status: stub` (faculties + AI dictionary) | 0 |

## Top blockers (routing)

| Cluster | Route |
|---------|--------|
| Execution Spine truncated vs full chain in `fundamentals/what-is-programming` | Draft → Review (Owner-gated) |
| Living prose `вы` drift on гл. 0 | Draft → Review |
| DESIGN accept checklist unsynced vs Publish / 0001b | Owner sync DESIGN · then Reviewer note |
| Unsourced claims in Image-Caching note, async-defer refs, syntax ABI Q42 | Direct improve-topic (warehouse) |

## Clean / empty checks

- NSManagedObjectID permanence, Actor reentrancy, Core Data ≠ DB — no hard conflict in sample  
- `campus/faculties/`: no literal `Status: stub` files  
- `ai-engineering/dictionary/terms/`: 97 stubs, all touched within 60d (not stale)

## Follow-up

Owner decides order; auditor does not patch in the audit pass.
