# Мануал: репо-помощник (Campus Assistant)

Как пользоваться **Cursor agent** внутри репозитория `vil4labs/univer` (org [vil4labs](https://github.com/vil4labs)) в нашей вселенной Engineering Builder **v2**.

Это не общий ChatGPT-howto. Помощник — **campus coach / Skill runner** в контексте Charter, Paths и Evidence.

Связано: [SESSION_PROTOCOL.md](SESSION_PROTOCOL.md) · [skills/](skills/) · [CAREER_INTEGRATION.md](CAREER_INTEGRATION.md) · [PROGRESS.md](PROGRESS.md) · [LANGUAGE.md](LANGUAGE.md) · AI Governance (роли Author/Reviewer/Architect и др.): [../.ai/README.md](../.ai/README.md)

---

## Кто это

| Роль | Делает | Не делает |
|------|--------|-----------|
| Campus coach | Урок по Path: Levels, trade-offs, mocks, quiz | Заменять твой Evidence «я понял в голове» |
| Skill runner | Крутит Skill из [catalog](skills/catalog.md) → learning module | Витринные summary без Practice |
| Librarian | Находит/связывает Library + faculty indexes | Mass-move папок без Design |
| Scribe | Write-back в Path log / topic passport по твоей команде | Commit/push без явной просьбы |
| Boundary guard | Держит private career вне public repo | Публиковать salary / CRM / folklore |

Помощник читает Charter и campus OS. Ты остаёшься accountable за mastery.

---

## Когда какой режим чата

| Режим | Когда | Пример запроса |
|-------|--------|----------------|
| **Path lesson** | Идёшь по stage Alpha/Beta | «Path Alpha Stage N, Level 2: …» |
| **Chapter fill** | Новая / эталонная глава | Сначала [`.ai/workflows/chapter-fill.md`](../.ai/workflows/chapter-fill.md) — дизайн, потом текст |
| **Deepdive Skill** | Книга / WWDC / paper / repo | «Запусти Skill `wwdc-deepdive` на …» |
| **Review Skill** | PR / architecture / docs | «`architecture-review` для …; ADR stub» |
| **Governance** | Конституция, faculties, Status | «Обнови V2_CHECKLIST / Status после моего апрува» |
| **Repo hygiene** | Inventory, sync | «Прогони `check_library_sync` / найди orphan topic» |

Не смешивай в одном сообщении «перепиши Charter» и «проведи урок concurrency» — разные режимы.

---

## Ритуал урока (optional — Maxim Mode A / Path)

Не гейт для библиотеки и не обязательный ритуал Тимура. Если идёшь Path Alpha:

```text
pulse → topic dive → questions → write-back topic (+ code/playground/lab link) → mock → Evidence
```

1. Назови **Path + Stage + Level** (1 / 2 / 3) и канонический topic.  
2. Сформулируй **fundamental why** темы (не только «что такое X») — [chapter-shape](../.ai/principles/chapter-shape.md) · [content-philosophy](../.ai/principles/content-philosophy.md).  
3. Сначала: что уже есть в University (improve, не дублировать).  
4. Deep dive как **история проблемы → идея → реализации → trade-offs**, не справочник API.  
5. Вопросы / open gaps (на странице темы ответы можно оставить пустыми до chat/mock).  
6. **Write-back в topic:** конспект по секциям главы + код/playground/lab link + блок **Рефлексия** (что сдвинулось в ментальной модели).  
7. Mock + строка в Progress log Path ([alpha.md](paths/alpha.md)) — Status, Confidence, Evidence summary.

Warehouse не обязан быть «заполнен». Заполняем **недостающее под текущую подготовку**. Incremental fill: [OPERATING_MODES.md](OPERATING_MODES.md).

Без write-back Path-урок (Mode A) не считается завершённым. Протокол: [SESSION_PROTOCOL.md](SESSION_PROTOCOL.md).  
Чтение Living-главы из библиотеки **не** требует Path write-back.

---

## Что просить

- Levels 1–3 явно («дай Level 1 для сына, потом Level 2»)  
- Decision framework / alternatives / ownership angles  
- Lab или Skill id из каталога  
- Quiz / self-check с ответами отдельно (сначала попытка)  
- Связь с faculty / Library hooks  
- RU prose + EN terms ([LANGUAGE.md](LANGUAGE.md))  

---

## Чего не просить

- Private salary, recruiter scripts, names of employers для public pages  
- «Придумай опыт / кейс с прошлой работы»  
- Commit / push / force-push без явного «закоммить / запушь»  
- Mass `git mv` warehouse «чтобы красиво»  
- «Просто объясни» без практики, *если* ты сам просил Path/Evidence-урок (Mode A)  
- Для Тимура: «просто объясни главу по ссылке» — **нормальный** запрос библиотеки  
- Стать «AI Engineer identity» вместо SE understanding  

---

## Границы репозиториев

| Repo | Роль |
|------|------|
| `vil4labs/univer` | Public living curriculum — Skills, Evidence craft |
| `career` | Private Career OS / facts / CRM |
| `vil4labs/pitstop-ios` · `regional-check` · `room-scanner-ios` · `visionkit-lab-ios` / `ios-hunter` | Independent products — cite, don't absorb |

Помощник в этом workspace по умолчанию пишет только в university (и local gitignored agent files).

---

## Skills

1. Выбери id из [skills/catalog.md](skills/catalog.md).  
2. Дай inputs (URL, path, topic id, Level).  
3. Требуй outputs по контракту Skill (article → exercises → quiz…).  
4. Реши write-back: куда кладём модуль; что в Path log.

Deepdive ≠ summary. Цель — **learning module**.

---

## Student B

- Проси **Level 1**: аналогии, картинки словом, крошечная практика.  
- Parent (Student A) проверяет Explain/Teach.  
- Без Interview Heat и private career.  
- Тот же помощник; другой Level и тон.

---

## Anti-patterns

| Anti-pattern | Лучше |
|--------------|--------|
| «Объясни MVVM» | «Problem → why MVVM → trade-offs → mini lab → mock» |
| Копипаст ответа агента в README без понимания | Explain своим словами + Evidence |
| Десять тем за вечер | Один stage, Completeness gates |
| Chat вместо Path log | Всегда write-back |
| Skills как развлечение | Skills → module → practice |

---

## Study status (сейчас)

[PROJECT_STATUS](../PROJECT_STATUS.md): library shelves open under v2.

Для **Тимура** (ученик): вход [`FOR_TIMUR.md`](FOR_TIMUR.md) — библиотека + как спрашивать. Path/Evidence **не** обязательный ритуал.

Для **Максима** (Owner / Mode A): Path / ROADMAP / Evidence — по желанию интенсив; mock: [`.ai/workflows/interview-prep-session.md`](../.ai/workflows/interview-prep-session.md). Concurrency library: `swift/concurrency/` (Reading route 0→12).

---

## Шпаргалка промпта

```text
Режим: Path lesson | Interviewer
Path: Alpha · Stage: 4 (Concurrency) · Level: 2
Тема: swift/concurrency
Нужно: mental model, decision framework, 3 alternatives, mock Q×5, exercise
Потом: предложи write-back строку для Progress log (я подтвержу)
Не: private career, commit, mass-move, handbook tree
```
