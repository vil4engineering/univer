# rememberDecoratedNavEntries (Compose Navigation — cross-platform idea)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | partial |
| Source | Telegram Saved `506551` |
| Related | [AI materials](README.md) · navigation |

---

## Выжимка

Статья про **Navigation 3** и multi-backstack с табами: `rememberSaveable` теряется при смене таба. Решение — `rememberDecoratedNavEntries` с `rememberSaveableStateHolderNavEntryDecorator()`: каждый NavEntry получает свой scope сохранения без переписывания экранов.

## Выжимка

🔄 rememberDecoratedNavEntries — стейт экранов между несколькими backstack  
https://freedium-mirror.cfd/https://proandroiddev.com/rememberdecoratednaventries-makes-remembersaveable-work-across-multiple-navbackstacks-bb7a984ef266

Разработчик разбирает частую проблему Navigation 3: приложение с табами, у каждого свой NavBackStack, а внутри экранов локальный стейт через `rememberSaveable`. При переключении таба он теряется, потому что `rememberSaveable` живёт в композиции, а не привязан к навигационной записи.

💡 Решение — низкоуровневый `rememberDecoratedNavEntries`:  
вместо передачи backstack прямо в NavDisplay ты явно создаёшь entries с декоратором `rememberSaveableStateHolderNavEntryDecorator()`, который даёт каждому NavEntry свой scope сохранения. Сам экран менять не нужно — он продолжает использовать обычный `rememberSaveable`, а управление приходит снаружи.

Подробнее с кодом — в статье.

——————  
💭 Полезный паттерн для табов с независимой навигацией на Nav3. Скинь тому, кто пилит multi-backstack на Compose.

Telegram | Селеба | YouTube

## Заметка

Android Compose Navigation 3, multi-backstack state — аналогия для iOS-дискуссий про state restoration в multi-tab.
