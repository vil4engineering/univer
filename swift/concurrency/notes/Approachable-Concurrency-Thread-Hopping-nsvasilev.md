# Approachable Concurrency — thread hopping (nsvasilev)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `507900, 507072, 507073` |
| Related | [Concurrency](../README.md) |

---

## За 30 секунд

Swift 6.2 **Approachable Concurrency** (`APPROACHABLE_CONCURRENCY` / `NonisolatedNonsendingByDefault`): обычные `nonisolated` async-методы **наследуют executor вызывающей стороны**, а не прыгают в cooperative pool. Хочешь явный hop в pool — пометь `@concurrent`.

## Почему это важно

Раньше: `nonisolated async` на `@MainActor`-типе часто уносил выполнение с main «без видимой причины». Теперь: остаётся в контексте caller, пока не поставишь `@concurrent` или не сделаешь `await` на другом actor.

## Ментальная модель

- **nonsending** — не привязан к домену actor, держит контекст caller.
- **`@concurrent`** — явный hop в global pool (подразумевает nonisolated).
- Вложенный `await` на другом actor всё равно прыгает; при resume возвращаешься в контекст caller — под Approachable Concurrency.

## Источник

- Статья: https://www.nsvasilev.com/posts/approachable_concurrency/
- TG album captions + images (Saved 507072/073) — та же тезис, что в дайджесте канала.

## Пробел vs существующая заметка

Дополняет [Approachable-Swift-Concurrency-Site.md](Approachable-Swift-Concurrency-Site.md) конкретными таблицами thread-hop и примерами `@concurrent`.

## Картинки из альбома

- [`images/approachable-2026-07-30/507072.jpg`](images/approachable-2026-07-30/507072.jpg)
- [`images/approachable-2026-07-30/507073.jpg`](images/approachable-2026-07-30/507073.jpg)
