# Three iOS 27 musts before autumn (scenes, Liquid Glass, launch screen)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `502944, 503186` |
| Related | [App Store README](../README.md) · [UIKit notes](../../../ios-sdk/uikit/notes/) |

---

## In 30 seconds

Three rejection / runtime risks called out for the iOS 27 train:

1. **Scene-based lifecycle** mandatory — migrate off legacy app-delegate-only UI if still there.
2. **Liquid Glass ignore flag** stops working — adopt glass / UIKit compatibility fixes; breakage likely without work.
3. **Launch screen Info.plist config** required (ITMS-90870 style) on iOS 27 / iPadOS 27 — declare launch screen configuration in Info.plist.

## Shelf note

Pair with UIKit Liquid Glass pitfalls note and App Store submission checklist.

