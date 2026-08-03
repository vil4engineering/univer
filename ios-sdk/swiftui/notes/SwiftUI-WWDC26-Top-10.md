# Top 10 SwiftUI updates — WWDC26 highlights

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `504004` |
| Related | [SwiftUI README](../README.md) |

---

📱 **Топ 10 обновлений SwiftUI с WWDC26**

После WWDC про SwiftUI информации много — что реально изменилось? Хайлайты на основе сессий и статей:

1. **Новый внешний вид Liquid Glass** — стандартные компоненты обновляются почти бесплатно. Собери проект в Xcode 27 и посмотри, что изменилось в реальном UI.

2. **Больше контроля над кастомным Liquid Glass** — для своих glass-элементов можно явно указать интерактивность. Актуально для iPad и macOS, где UI живёт не только под пальцем, но и под курсором.

3. **`appearsActive` для окон** — нормальная реакция на active / inactive window. Мелочь, но для iPadOS и macOS это штрих, который делает приложение менее «айпадным» на большом экране.

4. **Toolbars стали взрослее** — приоритеты видимости, overflow-меню, закрепление важных actions, auto-minimize navigation bar при скролле. Меньше угадывания, что спрячется на маленьком экране и где окажется Share.

5. **Новый Document API** — SwiftUI прокачали для document-based apps: async read/write, большие файлы, progress операций, несколько сценариев создания документа. Для заметок, редакторов, графики — сильный апдейт.

6. **Drag & Drop без танцев** — reordering не только в `List`, но и в сетках, стеках, custom layout — одним подходом на разных контейнерах.

7. **Swipe Actions не только внутри List** — swipe actions в произвольных scrollable layout. Мелочь, пока не нужно знакомое iOS-взаимодействие в кастомной ленте или карточках.

8. **Confirmation dialogs и alerts ближе к sheets** — item-based подход: положил объект в binding — SwiftUI сам показывает нужный диалог. Меньше `isShowingDeleteDialog`, меньше шансов открыть не тот alert.

9. **`AsyncImage` начал уважать HTTP cache** — стандартное HTTP-кеширование по умолчанию, учёт cache headers сервера. Апдейт, который работает сам из коробки.

## Shelf

Digest only — promote bullets в Living chapter, когда Design одобрен.
