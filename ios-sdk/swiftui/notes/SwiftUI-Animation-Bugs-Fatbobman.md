# Two SwiftUI animation bugs (Fatbobman debugging notes)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `504227` |
| Related | [SwiftUI README](../README.md) · [animations](../../animations/README.md) |

---

## Source

https://fatbobman.com/en/posts/debugging-notes-on-two-swiftui-animation-bugs/

## Bug 1 — explicit `withAnimation` interrupted by parent rebuild

Rare on iOS 26 (~1–2%), much worse on iOS 27: parent rebuild commits child end-state outside the animation transaction → in-flight animation snaps. Fix direction: move animation closer to the view (`.animation(_:value:)`) + `Animatable` completion observer; prefer `DispatchQueue.main.async` over `Task { @MainActor }` inside `animatableData` setter to avoid “Publishing changes from within view updates”.

## Bug 2 — ternary `Image` vs `if/else` inside `List`

`Image(systemName: cond ? a : b)` reuses one identity and swaps symbol — can break cell animation on iOS 26 `List`. `if/else` branches → different identities → problem gone. Counterintuitive: sometimes you *want* identity change.

## Interview takeaway

Animation bugs often = identity + transaction boundaries, not “wrong Animation curve”.
