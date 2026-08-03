<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Зачем иерархия задач и отмена сверху вниз?

<p class="chapter-deck">
Structured concurrency отвечает на боль callback-эры: кто владеет работой, кто ждёт детей, куда уходит отмена — когда экран уже закрыт.
</p>

<p class="chapter-meta">
≈ 16 мин · Interview ★★★★★ · после GCD/callback
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [GCD / callback era](../gcd-and-callback-era/) · [Shared state](../shared-state-and-races/) |
| **Next** | async/await & suspension (следующий unit) · [hub](../) · [StructuredConcurrencyLab](../StructuredConcurrencyLab.playground) |
| **Interview** | ★★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 16 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Представь семейную поездку. Родитель говорит: «Соберитесь у машины». Дети — отдельные дела (купить воду, закрыть квартиру), но поездка **одна**. Если поездку отменили — дети тоже должны остановиться. Если родитель уезжает, не бросая детей в городе.

**Structured concurrency** — та же идея для задач: есть **scope** (родитель), есть **дети**, есть правило «пока scope жив — дети под контролем».

> Структура — про **lifetime и ответственность**, не про «больше async».

---

## Проблема

В callback-эре легко:

- запустить работу;
- потерять, кто её отменит;
- обновить UI после dismiss;
- получить ошибку на третьем этаже пирамиды без единого места «стоп».

Нужна модель, где concurrent work **вложена** в понятный родительский scope — как блок кода, который начинается и заканчивается.

---

## История (коротко)

```text
Raw threads
  → queues + callbacks (организация есть, lifetime часто ручной)
  → structured concurrency (иерархия задач + отмена вниз)
  → дальше: suspension, isolation, Sendable…
```

Warehouse: [What's “structured”](../notes/Structured-Concurrency-What-Structured-Means.md) · [StructuredConcurrencyLab.playground](../StructuredConcurrencyLab.playground).

---

## Как это работает

| Идея | Смысл |
|------|--------|
| <a class="eu-term" href="../../../glossary/#glossary-structured-concurrency">Structured concurrency</a> | Дочерние задачи привязаны к scope родителя; на выходе scope родитель ждёт / собирает исход |
| Отмена сверху вниз | Отмена родителя распространяется на детей (кооперативно — дети должны заметить) |
| Unstructured | `Task { }` с «улицы» может пережить scope, который его породил — lifetime на тебе |

Ментальная модель:

```text
scope {
  child A
  child B
}  // здесь: дождаться детей / обработать ошибку / отмена уже ушла вниз
```

Механизмы Swift (`async let`, `TaskGroup`, task в async-контексте) — способы записать эту модель. Их синтаксис — в следующих главах и lab; здесь важен **договор**.

---

## Внутри

Level 3 — дверь.

«Структурированность» = ориентированный граф зависимостей задач, а не «всё async». Отмена — практическое следствие графа: отрезали корень — должны остановиться ветки. Unstructured task — ребро наружу из графа; иногда нужно, часто — дырка lifetime (см. unit про unstructured work).

---

## Пример

Псевдокод идеи (не API-каталог):

```text
Плохо (callback mindset):
  startDownload()
  startParse()
  // dismiss экрана — кто остановит?

Лучше (structured mindset):
  scope экрана {
    download
    parse
  } // уход со scope = дождаться / отменить детей
```

---

## Production

Привычка:

> Перед новым `Task { }` спроси: **этот scope ещё отвечает за результат — или я запускаю сироту?**

Если сирота — либо осознанный unstructured с владельцем, либо верни работу в structured scope.

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Что значит structured? | Hierarchy / lifetime / await children |
| Зачем отмена сверху вниз? | Один stop для дерева работ |
| Чем плох «просто Task»? | Escapes scope; cancel/UI race |
| Связь с callback pain? | Composition + ownership |

**Ошибки:** structured = «только async let»; игнорировать cooperative cancellation.

---

## Лабораторная

Теория покрыта. Практика: [StructuredConcurrencyLab.playground](../StructuredConcurrencyLab.playground) — отмена вниз; Evidence async.

---

## Конспект

1. Structured = parent scope владеет детьми.  
2. Отмена идёт сверху вниз (кооперативно).  
3. Unstructured task может пережить создателя.  
4. Это ответ на боль callback lifetime.  
5. Дальше — чем suspension ≠ блокировка потока.

---

## Рефлексия

> **до:** «запустил Task — и ладно»  
> **после:** сначала кто scope; потом механизм

**Дальше:** async/await и suspension (следующий unit) · пока [hub](../).

---

## Evidence

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise  

## Open questions

Где у тебя последний «сирота» `Task { }` после dismiss экрана?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/structured-concurrency` |
| **Version** | v1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [gcd-and-callback-era](../gcd-and-callback-era/) |
| **Handoff** | [§8b](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
