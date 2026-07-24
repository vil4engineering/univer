# Workflow: Chapter fill (единый паттерн)

**Это единственная точка входа**, когда нужна новая или эталонная глава университета.

Не ищи стиль по Charter / TOPIC_TEMPLATE / philosophy по отдельности в начале работы - открой **этот файл**, затем один prompt.

```text
.ai/workflows/chapter-fill.md     ← ты здесь (процесс)
.ai/prompts/design-chapter.md     ← Phase A: только ДИЗАЙН страницы
.ai/prompts/write-chapter.md      ← Phase B: текст по утверждённому DESIGN
.ai/checklists/chapter-design.md  ← приёмка дизайна до написания
.ai/checklists/topic.md           ← приёмка готовой главы
```

Принципы (SoT, не копировать вручную в каждую главу):

| Документ | Зачем |
|----------|--------|
| [content-philosophy.md](../principles/content-philosophy.md) | идеи > технологии; история; рефлексия |
| [chapter-shape.md](../principles/chapter-shape.md) | секции + fundamental why |
| [language.md](../principles/language.md) | RU explain · EN terms |
| [campus/TOPIC_TEMPLATE.md](../../campus/TOPIC_TEMPLATE.md) | header / passport / Levels |
| [constitution.md](../constitution.md) | 10 правил |

Если prompt и principle расходятся - **побеждает principle**; потом поправь prompt.

---

## Паттерн (запомни форму)

```text
1. Выбрать тему + fundamental why
2. Architect (если новый path / дубль) → approve create
3. Phase A — DESIGN only
      скопировать prompts/design-chapter.md
      заменить ТОЛЬКО блок «# Тема»
      роль: методист (не Author полного текста)
4. Owner / Reviewer — апрув DESIGN (checklists/chapter-design.md)
5. Phase B — WRITE
      скопировать prompts/write-chapter.md
      на вход: путь к DESIGN.md
6. Dual-pass Reviewer → topic.md checklist
7. Evidence / Path log при учёбе
8. Stop — не плодить handbook-деревья
```

**Incremental fill:** можно остановиться после DESIGN; можно писать секции главы по одной. Не фейкать полноту.

**Improve existing:** если страница уже есть и нужна правка одной дыры - [improve-topic.md](improve-topic.md), не полный chapter-fill.

---

## Что меняется / что нет

| Меняется каждый раз | Не меняется |
|---------------------|-------------|
| Блок `# Тема` в design-chapter (название, why, аудитория-нюансы, особые акценты) | Режим методиста |
| Путь `…/DESIGN.md` и `README.md` | Язык RU + EN terms |
| Lab ids / Reference World / Next-граф | Цепочка Problem→…→Interview |
| | Процесс Design → Review → Write |
| | Запрет справочника; история; рефлексия |

---

## Где лежит DESIGN

```text
<warehouse-section>/<topic-slug>/
  DESIGN.md     ← контракт страницы (Phase A)
  README.md     ← глава (Phase B; до апрува - stub + link на DESIGN)
  notes/        ← interview pack, digests (optional)
  *.playground  ← labs (optional)
```

Пример эталона процесса: [`fundamentals/what-is-programming/`](../../fundamentals/what-is-programming/).

После create: `topic_tree.py` + `check_library_sync.py` / `write_library_map.py`.

---

## Быстрый старт (человек)

1. Открой [design-chapter.md](../prompts/design-chapter.md).  
2. Вставь свою `# Тема`.  
3. Запусти в Cursor / ChatGPT.  
4. Сохрани вывод как `…/DESIGN.md`.  
5. Апрув.  
6. [write-chapter.md](../prompts/write-chapter.md).

---

## Related

- [improve-topic.md](improve-topic.md) - точечные правки
- [interview-prep-session.md](interview-prep-session.md) - учёба, не написание главы
- [../README.md](../README.md)
- `campus/ASSISTANT_MANUAL.md`
