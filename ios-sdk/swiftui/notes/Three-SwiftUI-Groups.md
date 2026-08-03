# compositingGroup vs geometryGroup vs drawingGroup

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `505528` |
| Related | [SwiftUI README](../README.md) |

---

📱 **Три SwiftUI group, которые легко перепутать**

В SwiftUI три модификатора с похожими названиями:

- `compositingGroup()`
- `geometryGroup()`
- `drawingGroup()`

Но работают на разных уровнях. Не тот group — в лучшем случае ничего не изменится, в худшем лишняя работа для рендера.

🟡 **`compositingGroup()`** — когда проблема в **графическом результате**.

Классика: несколько аватарок внахлёст, ты ставишь `opacity` на весь ряд. Без `compositingGroup()` прозрачность может примениться к каждой аватарке отдельно — они просвечивают друг через друга, хотя ты хотел полупрозрачный ряд целиком. Не про layout — про то, как группа выглядит после compositing.

🟡 **`geometryGroup()`** — когда проблема в **геометрии**.

Родитель двигает view, а внутри в тот же момент меняется текст, размер или фон. Без явной границы SwiftUI может анимировать части view отдельно — UI на мгновение «разваливается».

🟡 **`drawingGroup()`** — другая история. Рендерит содержимое в offscreen image, дальше SwiftUI работает с одной картинкой. Может помочь при сложной графике, множестве shape, blur, clipping. Добавляй после профилирования — модификатор затратный. Подходит для графического SwiftUI-контента (`Text`, `Image`, `Shape`); произвольные UIKit/AppKit view, web view или media player в картинку нормально не превратит.

Статья хорошо показывает pipeline SwiftUI изнутри. Иногда баг не в анимации, layout или цветах — а в том, **на каком этапе** ты группируешь view. Чем лучше понимаешь pipeline, тем меньше хочется лечить всё `.drawingGroup()`.

## Одной фразой

Выбирай по **level**: compositing (visual flatten/opacity), geometry (layout/animation geometry), drawing (offscreen rasterize / Metal-ish cost).
