# On-Demand Resources deprecated → Background Assets (iOS 27)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | partial |
| Source | Telegram Saved `507908` |
| Related | [App Store README](../README.md) |

---

## За 30 секунд

**On-Demand Resources (ODR)** и `NSBundleResourceRequest` уходят в deprecated к **iOS 27**. Новую работу Apple ведёт на **Background Assets**: контент хостится отдельно от основного бандла (размер установки, скорость, опциональные фичи).

## Что делать

- Новые скачивания / hosted packs → API **Background Assets**.
- Старый ODR → план миграции; новые ODR-теги не заводить.
- На интервью: зачем ODR был (тонкий install) и чем заменяют request API.

## Открыто

Подтвердить ссылки WWDC26 / docs, когда углубим заметку.
