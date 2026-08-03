# SwiftUI is one graph (aleahim)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `503668` |
| Related | [SwiftUI README](../README.md) |
| URL | https://aleahim.com/blog/swiftui-is-one-graph/ |

---

## In 30 seconds

SwiftUI is a **demand-driven attribute graph** (not a naive full-tree diff). View structs are disposable values; persistent state is keyed by **identity**. Dependencies are discovered when a body runs. Dirty cones recompute lazily; equal recomputed values stop propagation. Layers coalesce (not 1:1 UIView→CALayer). Animations jump model to target and interpolate presentation. Patent US 11,042,388 aligns with observed behavior.

## Interview hooks

- Identity vs position; why `.id` resets state
- Cone of invalidation vs rebuild-the-world
- Model vs presentation in `withAnimation`

## Useful?

yes-leaning — deep mental model for Living SwiftUI chapter later.
