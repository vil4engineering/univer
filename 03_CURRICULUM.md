# 03 · Curriculum

**Project:** Engineering University  
**Status:** governance (Leadership faculty + lesson contract)  
**Related:** [02_PHILOSOPHY.md](02_PHILOSOPHY.md) · [04_STRUCTURE.md](04_STRUCTURE.md) · [05_PATHS.md](05_PATHS.md)

## Curriculum — это не дерево папок

Студент учит **программу**.

Он не учит `swift/`, `ios-sdk/` или любую Git-папку как единицу обучения.

Существующие папки могут хранить материалы тем. Связка «curriculum unit → файл» — вопрос storage; см. [04_STRUCTURE.md](04_STRUCTURE.md).

## Faculties

| Faculty | Назначение |
|---------|------------|
| Faculty of Computer Science | Fundamentals, algorithms, математика, problem solving |
| Faculty of Software Engineering | Architecture patterns, quality systems, delivery |
| Faculty of Mobile Engineering | Apple platforms, Swift, UI, device/OS constraints |
| Faculty of AI Engineering | Надёжные AI-системы по maturity |
| Faculty of Product Engineering | Shipping judgment, product constraints, согласованная delivery |
| Faculty of Engineering Leadership | Ownership, decisions, teams, incidents, mentoring, strategy |
| Faculty of Career Development | Interview craft и привычки роста — не владение репозиторием `career` |

Faculties владеют **subjects**. Subjects появляются в **semesters** и **paths**.

### Границы ролей faculties

| Faculty | Owns | Не owns |
|---------|------|---------|
| Engineering Leadership | Как инженер ведёт systems, people и decisions | Private career facts, salary, recruiter strategy |
| Product Engineering | Product/shipping trade-offs в codebase и roadmap | org politics как основной subject |
| Career Development | Answer depth, interview narration, pressure craft | Внешний репозиторий `career` |
| Software / Mobile | Technical mechanisms и platform craft | Leadership как замена глубокой технике |

## Faculty of Engineering Leadership

Основной long-term faculty для Student A (Senior → Senior+/Lead).  
Позже полезен и Student B — эти skills редко преподают системно.

Канонический список subjects (Charter):

| # | Subject | Core question |
|---|---------|---------------|
| 01 | Technical Ownership | Кто accountable, когда quality, delivery или failure бьют production? |
| 02 | Architecture | Как структурировать systems for change без культа patterns? |
| 03 | Decision Making | Как выбирать под constraints и защищать выбор? |
| 04 | Engineering Standards | Что требуем от каждого change — и почему? |
| 05 | Code Review | Как reviews защищают system и culture? |
| 06 | Mentoring | Как поднимать планку команды без зависимости от ментора? |
| 07 | Cross-functional Communication | Как ясно объяснять trade-offs между ролями? |
| 08 | Product Engineering | Как engineering choices служат product outcomes? |
| 09 | Career Story | Как рассказывать real impact без фольклора? |
| 10 | Interview Engineering | Как показать Senior+/Lead thinking under pressure? |

Subject 08 специально пересекается с Product Engineering: Leadership считает product judgment leadership-компетенцией; Product Engineering faculty глубже в shipping mechanics.

Subjects 09–10 связываются с Career Development craft, не поглощая внешний `career`. Private facts снаружи; university lessons — обобщённые и teachable.

Смежные глубины внутри subjects по необходимости: incident response (Ownership / Standards), technical strategy (Decision Making / Architecture).

## Lesson contract · Senior+/Lead

Для Path Alpha и Leadership subjects.

**Goal:** системно закрыть разрыв strong Senior → Senior+/Lead.  
**Не goal:** учить изолированные technologies или interview trivia.

Оптимизируем engineering reasoning, decision-making и real-world ownership.

### Правило честности

- Не предполагать опыт, который студент не заявлял.
- Не выдумывать и не раздувать project stories.
- Связывать с career evidence только когда оно есть; иначе говорить явно.
- Private facts — во внешнем `career`; university lessons остаются generalized и teachable.

### Три обязательных вопроса (каждый topic)

1. Какую проблему это решает?
2. Почему engineering organization выбрала бы это?
3. Какие trade-offs это вводит?

Technology никогда не изучается в изоляции. Всё связано с engineering decisions.

### Форма урока (одна competency = один lesson)

| Section | Intent |
|---------|--------|
| 1. Mental model | First principles — почему существует (не APIs/syntax) |
| 2. Decision framework | Как опытные engineers выбирают (why / why not) |
| 3. Alternatives | Pros/cons, scale, maintenance, team, onboarding, testing, business impact |
| 4. Interview perspective | Типичные вопросы; Junior → Middle → Senior → Lead |
| 5. Real-world ownership | Как решение меняется для Senior / Tech Lead / Staff / Architect |
| 6. Connect to experience | Только подтверждённый опыт; gaps — честно |
| 7. Interview answer | Короткий natural answer + почему он сильный |
| 8. Deep dive | Follow-up до mastery — не продвигаться раньше времени |

Mastery gate: coach (человек или agent) убеждён, что competency понята, до следующего lesson.

### Anti-patterns уроков

- «Because it is best»
- Зазубренные cheat sheets
- API tours без decision
- Оптимизация «сдать interviews» вместо того, чтобы стать инженером, который проходит их naturally

Предпочитаем **why** голому **how**.

## Competency roadmap (cross-faculty)

Со временем покрыть (позже маппинг на subjects и paths):

**Leadership / judgment**

- Technical Ownership
- Technical Decision Making
- Technical Leadership
- Mentoring
- Cross-functional Communication
- Incident Handling
- Decision Making
- System Thinking
- Product Engineering
- Career Growth (в смысле leadership)

**Systems / craft**

- Architecture
- Modularization
- SDK Design
- API Design
- Dependency Injection
- MVVM
- Clean Architecture
- TCA
- Coordinators
- SwiftUI Architecture
- UIKit Architecture
- Concurrency
- Testing Strategy
- CI/CD
- Code Review
- Engineering Standards
- Security
- Performance

Technologies появляются как **decision cases** внутри competencies — не как checklist папок.

## Форма программы

```text
Curriculum
├── Faculty …
│   └── Subject …
├── Semester 1 … N
├── Topics (subject units)
├── Labs
└── Projects
```

Semesters — упорядоченные блоки обучения.  
Topics — единицы subjects внутри faculties.  
Labs — эксперименты на один вопрос.  
Projects — крупные конструкции (позже — Living Application).

## Шаблон subject (storage / completeness)

Каждый subject со временем объявляет:

| Field | Intent |
|-------|--------|
| Problem | Какая реальная трудность мотивирует subject? |
| Need | Какой capability не хватает без него? |
| Concept | Mental model и vocabulary |
| Implementation | Что строится |
| Laboratory | Один engineering вопрос |
| Reflection | Что выучено; что failed |
| Completeness gates | Explain · Demonstrate · Test · Reuse |
| Interview Readiness | Questions, trade-offs, pitfalls, depth tiers |
| Teaching note | Как Student A/B могут это преподать |

Для Senior+/Lead lessons поверх шаблона — **lesson contract** выше.

Subject может быть incomplete. Он не должен притворяться complete.

## Модель semesters (черновик)

Точное наполнение пересмотрим по мере уроков. Сейчас — направление.

### Semester 1 — Foundations of thinking

- Привычки problem solving
- Вход в computer science
- Базовый programming craft
- Маленькие verified programs
- Первые reflections и простые interview questions

Primary audience: Student B; Student A закрывает gaps.

### Semester 2 — Building correct software

- Types, structure, clarity
- Testing как привычка
- Debugging и feedback loops
- Первые software-engineering subjects

### Semester 3 — Systems on a device

- Mobile constraints
- UI и state
- Data и networking как потребности
- Architecture как ответ на scale проблемы — не fashion

### Semester 4 — Ownership and hard quality

- Technical ownership и decision making (Leadership 01–03)
- Concurrency, reliability, performance как design forces
- Interview Readiness усиливается для Student A

### Semester 5 — AI as engineering

По AI maturity spine (ниже), не по vendor checklist.

### Semester 6+ — Leadership depth + integration

- Mentoring, incidents, review culture, strategy (Leadership 05–10)
- Cross-faculty problems
- Project work к критериям Living Application
- Teaching loops между студентами

Semesters можно резать иначе. Правило неизменно: **со временем — более жёсткие реальные проблемы**.

## Faculty of AI Engineering — maturity spine

Не организовывать faculty в первую очередь как:

Tokens → Tools → Agents → …

Рост — как engineering maturity:

```text
AI Foundations
  → Model Integration
  → Structured Outputs
  → Tool Calling
  → Evaluations
  → Reliable AI Systems
  → Agent Systems
```

Имена technologies (embeddings, RAG, MCP, Foundation Models, …) появляются **внутри** стадий, когда проблема их требует.

## Interview Program (embedded)

Отдельного «только-interview университета» нет.

Interview Readiness — обязательный closing stage каждого subject и каждого Senior+/Lead lesson (sections 4, 7, 8).

```text
Subject / Lesson
  → Lab (когда применимо)
  → Reflection
  → Interview Readiness
  → Deep dive до mastery
```

Faculty of Career Development курирует cross-cutting interview craft, не поглощая внешний career repository.

## Исходные материалы (текущий репозиторий)

Сегодняшние topic folders и playgrounds — **кандидаты** материалов для faculties и labs. Это не карта curriculum.

Правила promotion (позже):

- Strong explain + demo → Topic candidate
- Один ясный вопрос + experiment → Lab candidate
- Пересекающиеся offline/sync/deeplink writeups → merge на уровне curriculum сначала
- Explain-only AI pages → incomplete, пока labs/projects не закроют Completeness gates
- Существующие architecture / concurrency / testing topics → decision cases для Path Alpha

## Что этот документ не делает

Не мигрирует папки в Semester directories.  
Задаёт, как университет думает об обучении, чтобы у поздней миграции был north star.
