# Approachable Concurrency — thread hopping (nsvasilev)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `507900, 507072, 507073` |
| Related | [Concurrency](../README.md) |

---

## In 30 seconds

Swift 6.2 **Approachable Concurrency** (`APPROACHABLE_CONCURRENCY` / `NonisolatedNonsendingByDefault`): ordinary `nonisolated` async methods **inherit the caller’s executor** instead of hopping to the cooperative pool. Opt into pool hops with `@concurrent`.

## Why it matters

Before: `nonisolated async` on a `@MainActor` type often jumped off main “for no obvious reason.” After: stays with caller until you `@concurrent` or `await` another actor.

## Mental model

- **nonsending** — not bound to an actor domain, keeps caller context.
- **`@concurrent`** — explicit global-pool hop (implies nonisolated).
- Nested `await` on another actor still hops; resume returns to caller context under Approachable Concurrency.

## Source

- Article: https://www.nsvasilev.com/posts/approachable_concurrency/
- TG album captions + images (Saved 507072/073) — same thesis as channel digest.

## Gap vs existing note

Complements [Approachable-Swift-Concurrency-Site.md](Approachable-Swift-Concurrency-Site.md) with concrete thread-hop tables and `@concurrent` examples.

## Album images

- [`images/approachable-2026-07-30/507072.jpg`](images/approachable-2026-07-30/507072.jpg)
- [`images/approachable-2026-07-30/507073.jpg`](images/approachable-2026-07-30/507073.jpg)
