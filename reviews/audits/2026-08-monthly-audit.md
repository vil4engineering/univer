# Monthly audit — 2026-08

- **Date:** 2026-08-03  
- **Trigger:** Owner (monthly)  
- **Role:** Reviewer only · no rewrites in-pass  
- **Playbook:** [`.ai/workflows/monthly-audit.md`](../../.ai/workflows/monthly-audit.md)  
- **Window (stale stubs):** 60 days  
- **Baseline:** [2026-07](2026-07-monthly-audit.md)

## Counts

| Severity | Count |
|----------|------:|
| blocker | 9 |
| thread | 20 |
| Stale `Status: stub` (faculties + AI dictionary) | 0 |

## Top blockers (routing)

| Cluster | Route |
|---------|--------|
| Execution Spine truncated at «программа → компьютер» vs full mermaid/конспект in `fundamentals/what-is-programming` | Draft → Review (Owner-gated) — **July open** |
| Living prose `вы` drift (`Представьте` / `ищите` / `остановитесь`) on гл. 0 | Draft → Review — **July open** |
| DESIGN accept checklist unsynced vs Publish / 0001b (`Author fixes`, `Dual-pass Accept`, Assets) | Owner sync DESIGN · then Reviewer note — **July open** |
| `swift/method-dispatch` README live while Formal Design Review unchecked | Owner Accept or gate README · Reviewer |
| Unsourced: Image-Caching WWDC26 · async-defer `await` in `defer` · гл. 0 missing Evidence | Direct improve-topic (warehouse) · Draft→Review for гл. 0 Evidence |

## Clean / empty checks

- Core Data ≠ DB, Actor reentrancy, NSManagedObjectID permanence — no hard conflict in sample  
- `campus/faculties/`: no literal `Status: stub` files  
- `ai-engineering/dictionary/terms/`: 97 stubs, all touched within 60d (not stale)  
- `fundamentals/literal-executor/`: DESIGN only (no README) — not a publish-gate README violation

## Follow-up

Owner decides order; auditor does not patch in the audit pass.

## Remediation (2026-08-03)

Author pass after Owner OK — theory heal, atomic commits T1–T6:

| T | Topic | Commit intent |
|---|--------|---------------|
| T1 | `fundamentals/what-is-programming` | spine · `ты` · Evidence stub · DESIGN↔0001b |
| T2 | `swift/what-is-swift` | Human step on spine recall |
| T3 | `swift/method-dispatch` | DESIGN Accept · heuristic cost/WMO |
| T4 | `swift/syntax` Q42/Q43 | ABI as heuristic |
| T5 | `swift/async-defer` | await-in-defer toolchain caveat |
| T6 | Image-Caching + Q35 | unsourced WWDC26 removed |

**Residual / parking:** broader Q-card anti-encyclopedia · `check_library_sync` drift · literal-executor README · Evidence write-back when studied · see [`.author/SWIFT_SHELF_HANDOFF.md`](../../.author/SWIFT_SHELF_HANDOFF.md).

**WIP:** Phase A content heal closed for listed blockers. Phase B first unit shipped: [`swift/concurrency/why-concurrency-exists/`](../../swift/concurrency/why-concurrency-exists/). Next unit — Owner pick from parking lot + earliest remaining concurrency gap.
