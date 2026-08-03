# Two SwiftUI animation bugs (Fatbobman debugging notes)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `504227` |
| Related | [SwiftUI README](../README.md) · [animations](../../animations/README.md) |

---

## Источник

https://fatbobman.com/en/posts/debugging-notes-on-two-swiftui-animation-bugs/

## Баг 1 — explicit `withAnimation` прерывается parent rebuild

Редко на iOS 26 (~1–2%), сильно хуже на iOS 27: parent rebuild коммитит end-state дочернего view вне animation transaction → in-flight animation «щёлкает». Направление фикса: анимацию ближе к view (`.animation(_:value:)`) + completion observer через `Animatable`; внутри setter `animatableData` предпочитай `DispatchQueue.main.async` вместо `Task { @MainActor }`, чтобы не ловить «Publishing changes from within view updates».

## Баг 2 — ternary `Image` vs `if/else` внутри `List`

`Image(systemName: cond ? a : b)` переиспользует одну identity и меняет symbol — может ломать cell animation в iOS 26 `List`. Ветки `if/else` → разные identities → проблема исчезает. Контринтуитивно: иногда identity change как раз нужен.

## Вывод для интервью

Animation bugs часто = **identity + transaction boundaries**, а не «не тот Animation curve».
