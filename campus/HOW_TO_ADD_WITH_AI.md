# Как дополнять Engineering Builder через AI

Для отца и Тимура. Сайдбар этим не засорён — ссылка с [Home](../README.md) и [About](about.md).

## Что можно добавить

| Что | Куда |
|-----|------|
| Короткий «зачем термин» | [Glossary](../glossary/) — строка A–Z + якорь, колонка **Domain** |
| Глава-урок | Факультет / `fundamentals/` / `swift/` … по why-вопросу |
| Практика | [Labs](labs/) |

## Правила (коротко)

1. Глава отвечает на **один why**, не словарь терминов.  
2. Термин в тексте → ссылка в **Glossary** (класс `eu-term`), не свалка внизу главы.  
3. Новое на этаже Mobile/AI **ссылается на фундамент** (Computer Science / Glossary), не висит отдельно.  
4. Внизу главы — только **Дальше: следующая тема**.

## Промпт-заготовка для AI

Скопируй в чат агента в этом репо:

```text
Добавь в Engineering Builder.

Тип: [термин Glossary | глава]
Term / H1 why: …
Domain (для термина): например Backend · Networking или Mobile · Memory/ARC
Короткий текст (для термина) или outline главы:
…

Соблюдай: glossary A–Z + Domain; chapter-shape; голос «ты» для Тимура;
термины → glossary/; ссылка на фундамент CS если это не сам фундамент.
```

Для полноценной главы агент идёт по playbook: [chapter-fill](../.ai/workflows/chapter-fill.md) (Creator Portal / `.author/` — для авторов, не в студенческом меню).

## Пример

Вопрос «Зачем нужен unowned в Swift?» → карточка [unowned](../glossary/#glossary-unowned) · Domain: Mobile · Memory/ARC.  
Глубокий урок позже — на этаже Mobile (`swift/memory-arc/`).
