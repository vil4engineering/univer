# iOS Performance Agent Skills (+ launch-time skill)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `504997, 504996` |
| Related | [Performance](../README.md) |

---

## Репозитории / посты

- https://github.com/Livsy90/iOS-Performance-Agent-Skills/tree/main
- LinkedIn Artem Mirzabekian (launch time skill): https://www.linkedin.com/posts/artem-mirzabekian_im-continuing-my-series-about-ai-agent-skills-share-7482296495090806784-fBG7/

## За 30 секунд

Agent skills для review и диагностики iOS performance; отдельно выделен launch-time skill — чувствительный участок startup.

## Попробуй применить

Подключи выбранные skills в локальный agent harness для Instruments-driven reviews.

## Дайджест LinkedIn (launch-time skill)

Artem Mirzabekian продолжает серию про AI Agent Skills для iOS. Новый skill — **launch time**: один из самых чувствительных участков performance.

Skill учит агента разбирать startup как **pipeline**, а не выдавать generic «вынеси с main» / «уменьши число frameworks». Агент ищет дорогую фазу, critical path и отделяет work до первого кадра от work, которое можно отложить до первого interaction или позже.

References покрывают UIKit/SwiftUI lifecycle, pre-main, launch orchestration, SDK startup, linking strategy, XCTest metrics, Instruments, MetricKit и production monitoring. Цель — классифицировать проблему, привязать рекомендации к evidence и объяснить, как валидировать каждое изменение.

Статья: https://lnkd.in/d-WdDCTD

⭐ GitHub: https://lnkd.in/dMB9CmvT
