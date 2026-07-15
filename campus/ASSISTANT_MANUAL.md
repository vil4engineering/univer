# Мануал: репо-помощник (Campus Assistant)

Как пользоваться **Cursor agent** внутри репозитория `ios-university` в нашей вселенной Engineering University **v2**.

Это не общий ChatGPT-howto. Помощник — **campus coach / Skill runner** в контексте Charter, Paths и Evidence.

Связано: [SESSION_PROTOCOL.md](SESSION_PROTOCOL.md) · [skills/](skills/) · [CAREER_INTEGRATION.md](CAREER_INTEGRATION.md) · [PROGRESS.md](PROGRESS.md) · [LANGUAGE.md](LANGUAGE.md)

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
| **Path lesson** | Идёшь по stage Alpha/Beta | «Path Alpha Stage N, Level 2: mental model + decision framework + 3 trade-offs + mock» |
| **Deepdive Skill** | Книга / WWDC / paper / repo | «Запусти Skill `wwdc-deepdive` на …; выходы: article outline, quiz, lab idea» |
| **Review Skill** | PR / architecture / docs | «`architecture-review` для …; ADR stub» |
| **Governance** | Конституция, faculties, Status | «Обнови V2_CHECKLIST / Status после моего апрува» |
| **Repo hygiene** | Inventory, sync | «Прогони `check_library_sync` / найди orphan topic» |

Не смешивай в одном сообщении «перепиши Charter» и «проведи урок concurrency» — разные режимы.

---

## Ритуал урока (Student A)

```text
pulse → onion / Levels → practice → review / mock → write-back Evidence
```

1. Назови **Path + Stage + Level** (1 / 2 / 3).  
2. Потребуй decision-first (problem → why → trade-offs), не API dump.  
3. Practice: lab / playground id / mini-exercise.  
4. Mock: interview questions + honest gaps.  
5. **Write-back:** строка в Progress log Path ([alpha.md](paths/alpha.md)) — Status, Confidence, Evidence summary.

Без write-back урок не считается завершённым. Протокол: [SESSION_PROTOCOL.md](SESSION_PROTOCOL.md).

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
- «Просто объясни» без practice / Evidence  
- Стать «AI Engineer identity» вместо SE understanding  

---

## Границы репозиториев

| Repo | Роль |
|------|------|
| `ios-university` | Public living university — curriculum, Skills, Evidence craft |
| `career` | Private Career OS / facts / CRM |
| `pitstop-ios` / `ios-hunter` | Independent products — cite, don't absorb |

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

## Study pause (сейчас)

Пока [PROJECT_STATUS](../PROJECT_STATUS.md) говорит **Study paused**, помощник:

- помогает с governance / skeleton / Skills design;  
- **не** ведёт Path Alpha как будто lessons unlocked;  
- после твоего апрува [V2_CHECKLIST](V2_CHECKLIST.md) — можно стартовать Stage 1.

---

## Шпаргалка промпта

```text
Режим: Path lesson
Path: Alpha · Stage: … · Level: 2
Тема: …
Нужно: mental model, decision framework, 3 alternatives, mock Q×5, exercise
Потом: предложи write-back строку для Progress log (я подтвержу)
Не: private career, commit, mass-move
```
