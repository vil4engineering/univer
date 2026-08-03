# Proxy — доступ по уровню пользователя (poll)

| Field | Value |
|-------|-------|
| Kind | accompanying material (interview poll) |
| Source | Telegram Saved `507917` |
| Added | 2026-08-03 |
| Useful? | pending |
| Related | [Design Patterns](../) · structural: Proxy |

## Question

Какой паттерн проектирования в Swift удобен для управления правами доступа к функциональности в зависимости от уровня пользователя?

- Proxy
- Decorator
- Strategy
- Adapter

## Working answer

**Proxy** — объект-заместитель стоит перед реальной реализацией и решает, пускать ли вызов (роль / подписка / feature flag). Клиент говорит с тем же интерфейсом; проверка прав живёт в proxy, а не размазана по UI.

Кратко, почему не остальные:

| Option | Why weaker here |
|--------|-----------------|
| Decorator | Добавляет поведение / обёртки без смены интерфейса; типичный фокус — расширение, не authorization gate |
| Strategy | Подменяет алгоритм; не обязан быть gatekeeper прав |
| Adapter | Сводит чужой интерфейс к своему; не про уровни доступа |

## Open decision

Встроить как knowledge card (Q…) в [README](../README.md) или оставить здесь как сырьё.
