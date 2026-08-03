# How to break Swift Concurrency (cooperative pool)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `504489` |
| Related | [Concurrency](../README.md) |

---

## In 30 seconds

Tasks run on a **cooperative thread pool** sized roughly to CPU cores. Blocking calls or tight sync loops steal pool threads → hangs/deadlocks (worse on 1–2 core CI / weak devices).

## Anti-patterns

- Sync blocking inside `Task` / async functions.
- Deadlocks across queues / same-queue re-entry.
- Assuming “more Tasks” = more parallelism when pool is saturated.

## Interview

Separate **data race** (memory unsafety) from **logical race / starvation** (pool exhaustion).

