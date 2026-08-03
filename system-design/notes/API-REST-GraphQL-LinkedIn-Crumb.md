# API type choice — REST vs GraphQL crash story (LinkedIn)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | partial |
| Source | Telegram Saved `505054` |
| Related | system-design |
| URL | https://www.linkedin.com/posts/aryan-gupta-81887028a_api-softwareengineering-rest-share-7475982968360943617-_mUO/ |

---

## Дайджест

Автор: API выдержал 10 000 запросов в тестах — и упал в production за два часа. Причина — неверный **тип API**, а не «REST для всего».

Краткая карта типов из поста:

| Тип | Когда |
|-----|-------|
| **Open API** | Публичный доступ: погода, login, каталоги (Stripe, Google Maps) |
| **REST API** | HTTP, простой, универсальный — большинство web/mobile |
| **SOAP API** | XML, формальный — банки, страховые, госсектор |
| **GraphQL API** | Запрос ровно нужных полей — сложные связи (feed) |
| **Backend-to-Backend** | Внутренние microservices |
| **Frontend-to-Backend** | UI → server (login, search, profile) |
| **Service-to-Database** | Backend → БД |
| **Partner API** | Доверенные партнёры (affiliate, reseller) |
| **Data Sharing API** | Чувствительный обмен (медицина, финансы) |

Framework выбора автора: public access → Open/REST; сложные запросы → GraphQL; enterprise/legacy → SOAP; internal → B2B; partners → Partner API; sensitive → Data Sharing.

Пост: https://www.linkedin.com/posts/aryan-gupta-81887028a_api-softwareengineering-rest-share-7475982968360943617-_mUO/

## Рамка

SE-crumb про выбор API style под нагрузку — не глубина Backend faculty. Полезен как cautionary interview anecdote.
