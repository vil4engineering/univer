# How to break Swift Concurrency (cooperative pool)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `504489` |
| Related | [Concurrency](../README.md) |

---

## За 30 секунд

`Task` крутятся в **cooperative thread pool**, размером примерно по числу CPU-ядер. Блокирующие вызовы или tight sync-циклы забирают потоки pool → зависания и deadlock (особенно больно на 1–2 ядрах в CI или слабых девайсах).

## Антипаттерны

- Синхронная блокировка внутри `Task` / async-функций.
- Deadlock между очередями / re-entry в ту же очередь.
- Думать, что «больше Task» = больше параллелизма, когда pool уже перегружен.

## На интервью

Разделяй **data race** (небезопасность памяти) и **logical race / starvation** (исчерпание pool).
