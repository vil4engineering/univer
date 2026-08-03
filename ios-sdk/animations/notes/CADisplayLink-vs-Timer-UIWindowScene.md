# CADisplayLink vs Timer (UIWindowScene / iOS 27)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `504822` |
| Related | [Animations README](../README.md) |

---

## In 30 seconds

**Timer** = wall-clock intervals. **CADisplayLink** = vsync / frame boundaries. Prefer DisplayLink for visual smoothness tied to refresh rate; Timer for coarse periodic work (countdown, polling).

## Pitfalls (from Saved digest)

- Invalidating link on dismiss / scene disconnect.
- Prefer scene-aware APIs when targeting multi-window (`UIWindowScene`).
- Do not drive UI animation clocks with Timer if you care about ProMotion cadence.

## Related

Graphics / animations chapters; Instruments frame hitch debugging.

