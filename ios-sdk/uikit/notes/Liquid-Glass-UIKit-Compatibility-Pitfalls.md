# Liquid Glass: UIKit compatibility pitfalls

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `507901` |
| Related | [UIKit README](../README.md) |

---

## In 30 seconds

Practical UIKit + Liquid Glass (iOS 26/27) issues: navigation buttons, tab bar, `WKWebView`. Custom `UIBarButtonItem` views can distort size/colors — isolate with explicit constraints or replace with SwiftUI/`UIImage` patterns.

## Digest from Saved

Liquid Glass: A Field Guide to UIKit Compatibility Pitfalls


🖥 Если все еще не мигрировали на Liquid Glass на UIKit - статья для вас: практические проблемы адаптации UIKit на iOS 26, замеченные автором в реальном проект. 

❓ Главные кейсы - кнопки навигации, таббар и взаимодействие с WKWebView. Для UIBarButtonItem с customView на iOS 26 наблюдались искажение размеров и исчезновение цветов: решение - полностью «изолировать» вью с явными constrain (ширина, высота и центр) или заменить UIKit вью на SwiftUI через UIHostingController; это в большинстве случаев восстанавливало и размеры, и цвет. 

🔍 Немного про баги с новым API бейджей (иногда не обновляется - простой трюк: временно убрать и вернуть customView) и переносом порядка rightBarButtonItems (иногда помогает DispatchQueue.main.async или лучше - trailingItemGroups).

⚙️ Про UITabBarController и WKWebView: если вы динамически перестраиваете таббар во время закрытия модального контроллера, это может ломать интерфейс - ждущая окончания анимации dismiss решает проблему. При встраивании WKWebView стоит обязательно использовать viewport-fit=cover и env(safe-area-inset-*) в CSS, иначе контент может оказаться под таббаром (особенно при 

## Open

Locate canonical article URL if present in channel; deepen with WWDC Liquid Glass sessions.

