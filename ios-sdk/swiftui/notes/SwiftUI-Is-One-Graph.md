# SwiftUI is one graph (aleahim)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `503668` |
| Related | [SwiftUI README](../README.md) |
| URL | https://aleahim.com/blog/swiftui-is-one-graph/ |

---

## За 30 секунд

SwiftUI — **demand-driven attribute graph** (не наивный full-tree diff). View structs — disposable values; persistent state привязан к **identity**. Зависимости обнаруживаются, когда body выполняется. Dirty cones пересчитываются лениво; равные recomputed values останавливают propagation. Слои coalesce (не 1:1 UIView→CALayer). Анимации прыгают model к target и интерполируют presentation. Patent US 11,042,388 совпадает с наблюдаемым поведением.

## Interview hooks

- Identity vs position; зачем `.id` сбрасывает state
- Cone of invalidation vs rebuild-the-world
- Model vs presentation в `withAnimation`

## Useful?

yes-leaning — глубокий mental model для Living SwiftUI chapter позже.
