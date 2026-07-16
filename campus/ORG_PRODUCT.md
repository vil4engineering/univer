# Org product — Engineering University (10–20 years)

Как развивать **Engineering University** как продукт, а не как набор репозиториев.

Связано: [ROADMAP_SENIOR.md](ROADMAP_SENIOR.md) · [faculties/](faculties/) · org [.github](https://github.com/vil4engineering/.github) · [Discussions](https://github.com/vil4engineering/engineering-university/discussions) · [Project](https://github.com/orgs/vil4engineering/projects/1)

## North star

Curriculum first-class. Каждый repo / lab / статья имеет место в учебной структуре.

```text
Engineering University
├── Foundation — Mathematics · Computer Science · Engineering Thinking
├── Software Engineering — Swift · iOS · AI · Architecture
├── Laboratories
├── Career (public craft only)
└── Teaching
```

Кампус (`campus/`) + Library = реализация этой карты. Private `career` остаётся вне org.

## Уже есть

| Слой | Состояние |
|------|-----------|
| Org profile · logo · mission README | Done |
| Portal Pages | [vil4engineering.github.io/engineering-university](https://vil4engineering.github.io/engineering-university/) |
| Curriculum spine | `campus/` + [ROADMAP_SENIOR.md](ROADMAP_SENIOR.md) |
| Default community files | org `.github` (CONTRIBUTING · CoC · SECURITY · templates) |
| Living labs | `pitstop-ios` · `regional-check` |
| Org Project | [Engineering University #1](https://github.com/orgs/vil4engineering/projects/1) |
| Discussions (hub) | Enabled on site repo |
| Labels · milestones (hub) | Seeded |

## Делать постепенно

1. **Профиль** — поддерживать mission, ссылки на сайт / docs / Discussions.  
2. **Стандарты** — всё новое наследует org `.github` defaults.  
3. **Project** — колонки Ideas → Research → Learning → Building → Review → Done (или University / Labs / AI / Teaching).  
4. **Discussions** — категории: Questions · Ideas · Labs · Book Club · WWDC · AI · Career · Teaching (настроить в UI, если API не дал).  
5. **Docs in-repo** — `README` / `docs/` / `campus/`. **Wiki не использовать** как SoT.  
6. **Pages** — портал: Curriculum · Labs · Courses · Roadmap · Blog · Portfolio (наращивать на текущем Docsify).  
7. **Actions** — позже: markdown · links · mermaid · Swift · format · spell (по мере нужды).  
8. **Labels** — единый набор на всех active repos.  
9. **Milestones** — EU v1 · Swift · AI · CS · Career.  
10. **Roadmap** — жить в campus (`ROADMAP_SENIOR` + этот файл), **не** плодить `*-roadmap` repo без необходимости.

## Сейчас не делать

- Десятки пустых репозиториев «на вырост».  
- Отдельные `ios-knowledge-base` / `career` / `labs` / `ai-labs` / `roadmap` пока нет устойчивого потока работы.  
- Перенос private Career OS в public org.  
- GitHub Wiki как основная база знаний.

## Активный набор (цель 3–5)

| Repo | Роль |
|------|------|
| `engineering-university` | Campus · curriculum · portal |
| `.github` | Org standards · profile |
| `pitstop-ios` | Living lab |
| `regional-check` | Living lab |
| (+1 позже) | Только когда направление реально живёт |

## Definition of progress

Организация выглядит как университет, когда:

1. Curriculum навигируем и связан с labs.  
2. Evidence пишется в Path / Discussions / PR.  
3. Новые артефакты попадают в faculties / Areas, а не в «ещё один orphan repo».
