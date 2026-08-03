# Liquid Glass: UIKit compatibility pitfalls

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `507901` |
| Related | [UIKit README](../README.md) |

---

## За 30 секунд

Практические проблемы UIKit + Liquid Glass (iOS 26/27): navigation buttons, tab bar, `WKWebView`. Custom `UIBarButtonItem` views могут искажать size/colors — изолируй explicit constraints или замени на SwiftUI / `UIImage` patterns.

## Выжимка from Saved

Liquid Glass: A Field Guide to UIKit Compatibility Pitfalls

🖥 Если ещё не мигрировал UIKit на Liquid Glass — статья про практические проблемы адаптации на iOS 26 из реального проекта.

❓ **Главные кейсы** — кнопки навигации, tab bar, `WKWebView`. Для `UIBarButtonItem` с `customView` на iOS 26: искажение размеров и пропадание цветов. Решение — полностью «изолировать» view с explicit constraints (ширина, высота, center) или заменить UIKit view на SwiftUI через `UIHostingController`; в большинстве случаев восстанавливает и размеры, и цвет.

🔍 **Баги нового badge API** — иногда не обновляется; трюк: временно убрать и вернуть `customView`. **Порядок `rightBarButtonItems`** — иногда помогает `DispatchQueue.main.async`, лучше — `trailingItemGroups`.

⚙️ **`UITabBarController` и `WKWebView`:** динамическая перестройка tab bar во время dismiss модального controller может ломать UI — жди окончания dismiss-анимации. Для `WKWebView` обязательно `viewport-fit=cover` и `env(safe-area-inset-*)` в CSS, иначе контент может оказаться под tab bar (особенно при Liquid Glass tab bar и scroll).

## Открыто

Найди canonical URL статьи в канале; углуби WWDC Liquid Glass sessions.
