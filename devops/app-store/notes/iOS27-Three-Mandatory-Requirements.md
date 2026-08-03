# Three iOS 27 musts before autumn (scenes, Liquid Glass, launch screen)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `502944, 503186` |
| Related | [App Store README](../README.md) · [UIKit notes](../../../ios-sdk/uikit/notes/) |

---

## За 30 секунд

Три риска rejection / runtime, которые выделили для поезда iOS 27:

1. **Scene-based lifecycle** обязателен — уходи с legacy app-delegate-only UI, если он ещё остался.
2. **Liquid Glass ignore flag** перестаёт работать — адаптируй glass / UIKit compatibility fixes; без работы, скорее всего, сломается.
3. **Launch screen Info.plist config** обязателен (ITMS-90870 style) на iOS 27 / iPadOS 27 — объяви launch screen configuration в Info.plist.

## К полке

Свяжи с заметкой про Liquid Glass pitfalls в UIKit и чеклистом App Store submission.
