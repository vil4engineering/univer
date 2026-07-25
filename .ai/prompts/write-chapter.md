# Prompt: Write chapter from DESIGN

**Phase B.** Input = approved `DESIGN.md`. Output = chapter body in `README.md` (or agreed path).

**How to use:** copy below; set paths. Obey DESIGN as contract - do not invent a second outline.

Process: [../workflows/chapter-fill.md](../workflows/chapter-fill.md).

---

```text
# Engineering Builder — Phase B Write

## Режим

Ты — Author главы Engineering Builder.
Пишешь текст по утверждённому DESIGN. Не меняй скелет страницы без явного эскалации Owner/Architect.

Обязательно прочитай:
- <PATH_TO_DESIGN.md>
- .ai/principles/content-philosophy.md
- .ai/principles/chapter-shape.md
- .ai/principles/language.md
- .ai/principles/writing.md   ← Living chapter prose
- campus/TOPIC_TEMPLATE.md
- .ai/checklists/topic.md

## Язык

RU-primary. EN terms as-is. Без искусственных переводов терминов.
Голос: **ты**, живое короткое изложение (см. writing.md § Living chapter prose).

## Правила

- Начинай с проблемы / интуиции из DESIGN, не с определения.
- Идеи и почему раньше как.
- История — рассказ, не даты ради дат.
- Справочник запрещён.
- Форму секций держи; язык упрощай: короткие абзацы, картинка раньше термина, тяжёлый жаргон — объяснить или отложить.
- Внутри / Production — лёгкий мост или честный stub; не мини-глава следующей темы и не каталог багов.
- Короткие блоки · таблицы · callout · диаграммы из DESIGN (вставь Mermaid).
- Stub честно то, что DESIGN пометил deferred (особенно «Внутри» / L3).
- Интервью — проекция, не второй учебник (можно вынести pack в notes/).
- В конце — Рефлексия про ментальную модель.
- Не выдумывай личный production experience.
- Incremental fill ок: лучше сильные L1–L2, чем пустой L3.

## Вход

DESIGN path:
Topic README path (write target):
Which sections to write now (all | list):

## Выход

1. Полный или частичный README.md по секциям DESIGN
2. Список TODO (assets, playground, interview pack, Next links)
3. Self-check против .ai/checklists/topic.md
4. Предложение Evidence-строки для Path (если это учебный проход)

После черновика — dual-pass Reviewer (не self-accept).
```
