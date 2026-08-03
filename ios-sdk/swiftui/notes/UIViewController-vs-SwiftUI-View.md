# UIViewController (class) vs SwiftUI View (struct)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `504764` |
| Related | [SwiftUI README](../README.md) · [UIKit](../../uikit/README.md) |
| URL | https://www.linkedin.com/posts/sachin-rasane-a69ab3b8_ios-iosdevelopment-swift-share-7480908621803839488-ZzEC/ |

---

## Выжимка

Частая **iOS interview trap**: «Swift любит struct. Почему `UIViewController` — class, а SwiftUI `View` — struct?» Проверяют понимание Swift, не синтаксис.

**Почему `UIViewController` — class**

Управляет **identity и lifecycle**. View controller:

- держит mutable state;
- реагирует на lifecycle (`viewDidLoad`, `viewWillAppear`, …);
- shared между частями UIKit;
- наследует `NSObject`, работает с Objective-C runtime (delegation, KVO, target-action).

Один long-lived объект → reference semantics (`class`).

**Почему SwiftUI `View` — struct**

`View` — **описание UI**, не сам UI. При смене state SwiftUI создаёт новое value, сравнивает с предыдущим, обновляет только изменившееся. Struct даёт value semantics, performance, thread safety, простой diff. Реальные UI objects — внутри SwiftUI.

**Одной фразой на интервью**

«UIKit uses classes because UI components have identity and lifecycle. SwiftUI uses structs because views are immutable value descriptions that SwiftUI recreates and diffs efficiently.»

Суть для интервьюера: **identity vs value semantics**.

## Одной фразой

UIKit classes = identity + lifecycle; SwiftUI structs = disposable value descriptions, которые framework diffs.
