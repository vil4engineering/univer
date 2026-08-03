# Present vs push — who does `dismiss` close?

Заметка для **UIKit**. Источник: Telegram Saved `507916` (пост в стиле интервью). Связано: [UIKit README](../README.md), SwiftUI Q9 multilevel dismiss in [swiftui/](../../swiftui/README.md), [architecture/navigation](../../../architecture/navigation/README.md).

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |

---

## За 30 секунд

`dismiss(animated:)` закрывает **modal** presentation chain. Он **не** делает pop в `UINavigationController` — для этого нужны `popViewController` / `popToRootViewController`.

---

## Modal (`present`)

| Вызов | Эффект |
|------|--------|
| `vc2.dismiss` (top modal) | Закрывает только `vc2`; возврат к `vc1` |
| `vc1.dismiss` (нижний modal, который present'ил `vc2`) | Сносит `vc1` **и** всё, что present'ено поверх |

```swift
let vc1 = UIViewController()
let vc2 = UIViewController()
present(vc1, animated: true)
vc1.present(vc2, animated: true)

vc2.dismiss(animated: true) // only vc2
vc1.dismiss(animated: true) // vc1 + vc2
```

---

## Navigation stack (`push`)

`dismiss` на pushed VC — не тот инструмент (может закрыть внешний modal с nav внутри или не дать «назад на один экран»).

```swift
navigationController?.pushViewController(vc1, animated: true)
navigationController?.pushViewController(vc2, animated: true)

navigationController?.popViewController(animated: true)       // last
navigationController?.popToRootViewController(animated: true) // whole stack
```

---

## Одной фразой на интервью

Пойми, **на каком stack** ты: presentation stack vs navigation stack — один intent «назад», разные API.
