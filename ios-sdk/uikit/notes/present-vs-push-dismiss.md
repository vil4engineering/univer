# Present vs push — who does `dismiss` close?

Notes for **UIKit**. Source: Telegram Saved `507916` (interview-style post). Related: [UIKit README](../README.md), SwiftUI Q9 multilevel dismiss in [swiftui/](../../swiftui/README.md), [architecture/navigation](../../../architecture/navigation/README.md).

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |

---

## In 30 seconds

`dismiss(animated:)` closes a **modal** presentation chain. It does **not** pop a `UINavigationController` stack — that needs `popViewController` / `popToRootViewController`.

---

## Modal (`present`)

| Call | Effect |
|------|--------|
| `vc2.dismiss` (top modal) | Closes only `vc2`; returns to `vc1` |
| `vc1.dismiss` (lower modal that presented `vc2`) | Tears down `vc1` **and** everything presented on top of it |

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

`dismiss` on a pushed VC is the wrong tool (may dismiss an outer modal that contains the nav, or do nothing useful for “go back one screen”).

```swift
navigationController?.pushViewController(vc1, animated: true)
navigationController?.pushViewController(vc2, animated: true)

navigationController?.popViewController(animated: true)       // last
navigationController?.popToRootViewController(animated: true) // whole stack
```

---

## Interview one-liner

Know **which stack** you are on: presentation stack vs navigation stack — same “go back” intent, different API.
