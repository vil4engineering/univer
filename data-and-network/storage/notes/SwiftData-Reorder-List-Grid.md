# SwiftData — reorder List/Grid and persist order

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | partial |
| Source | Telegram Saved `504491` |
| Related | [Storage README](../README.md) |

---

Изменение порядка для List и Grid с сохранением в SwiftData

Стюарт Линч выпустил урок по работе со SwiftData. В нём он рассказывает, как реализовать перетаскивание в LazyVGrid с помощью onDrag, onDrop и специального DropDelegate.

📺 А ещё в этом видео можно узнать, как:

• Перейти от локального состояния к @Query в SwiftData
• Сохранять изменения пользовательского порядка сортировки при перезапуске приложухи
• Добавлять элементы управления для редактирования (и добавления элементов)
• Обрабатывать удаление строк с сохранением порядка сортировки
• Создавать плавные анимации в сетке с помощью перетаскивания

😃 iOS Dev

## Паттерн

Локальный `@Query` + drag/drop (`onDrag`/`onDrop`/`DropDelegate`) → persist sort key в SwiftData.
