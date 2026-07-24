# Workflow: Chapter fill (единый паттерн)

**Это единственная точка входа**, когда нужна новая или эталонная глава университета.

Не ищи стиль по Charter / TOPIC_TEMPLATE / philosophy по отдельности в начале работы - открой **этот файл**, затем один prompt.

```text
.ai/workflows/chapter-fill.md     ← ты здесь (playbook)
.ai/principles/teaching-model.md  ← why we teach (platform SoT)
.ai/principles/review-criteria.md ← how we score chapters
.ai/principles/content-lifecycle.md ← SDLC: idea → Evidence
.ai/prompts/design-chapter.md     ← Phase A: только ДИЗАЙН страницы
.ai/prompts/write-chapter.md      ← Phase B: текст по утверждённому DESIGN
.ai/checklists/chapter-design.md  ← приёмка дизайна до написания
.ai/checklists/topic.md           ← SoT / template приёмка
.ai/checklists/chapter-review.md  ← paste shape → review-criteria
reviews/                          ← журнал ревью (глава = продукт)
```

Принципы (SoT, не копировать вручную в каждую главу):

| Документ | Зачем |
|----------|--------|
| [teaching-model.md](../principles/teaching-model.md) | **platform SoT** — why chapters exist this way |
| [review-criteria.md](../principles/review-criteria.md) | **official score bar** |
| [content-lifecycle.md](../principles/content-lifecycle.md) | **content SDLC** · chapter = product |
| [content-philosophy.md](../principles/content-philosophy.md) | идеи > технологии; история; рефлексия |
| [chapter-shape.md](../principles/chapter-shape.md) | секции |
| [language.md](../principles/language.md) | RU explain · EN terms |
| [campus/TOPIC_TEMPLATE.md](../../campus/TOPIC_TEMPLATE.md) | Markdown chrome |
| [constitution.md](../constitution.md) | 10 правил |

Если prompt и principle расходятся - **побеждает principle**; потом поправь prompt.

---

## Паттерн (запомни форму)

Полный SDLC: [content-lifecycle.md](../principles/content-lifecycle.md). Кратко:

```text
1. Idea — тема + fundamental why (+ Part slot)
2. Architect (если новый path / дубль) → approve create
3. Design — DESIGN only (prompts/design-chapter.md)
4. Design Review — checklists/chapter-design.md
5. Owner Approve («пиши главу»)
6. Draft — write-chapter.md → README (+ Interview-Pack)
7. Engineering Review — dual-pass · review-criteria · reviews/NNNN
8. Revision → новый Reviewer pass
9. Publish (merge / Pages)
10. Evidence — Path log при учёбе
11. Stop — не плодить handbook-деревья · не стартовать следующую главу без lifecycle
```

**Запрет:** Draft без Design Review / Owner Approve.  
**Запрет:** Accept без Four gates + scored review ([review-criteria](../principles/review-criteria.md)) или Owner override в `reviews/`.  
**Глава = продукт:** DESIGN · README · Interview-Pack · reviews · version · Next.

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
- [dual-pass-review.md](dual-pass-review.md)
- [../checklists/chapter-review.md](../checklists/chapter-review.md)
- [../../reviews/](../../reviews/) - журнал ревью глав
- [interview-prep-session.md](interview-prep-session.md) - учёба, не написание главы
- [../README.md](../README.md)
- `campus/ASSISTANT_MANUAL.md`
