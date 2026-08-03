<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Когда `Task { }` — инструмент, а когда дырка lifetime?

<p class="chapter-deck">
<a class="eu-term" href="../../../glossary/#glossary-task">Task</a> — единица работы. Unstructured <code>Task { }</code> удобен, но легко становится сиротой: экран умер, работа живёт.
</p>

<p class="chapter-meta">
≈ 14 мин · Interview ★★★★★ · гл.6 M03 · после suspension
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [async/await · suspension](../async-await-and-suspension/) · [structured](../structured-concurrency/) |
| **Next** | [Actors / isolation](../actors-and-isolation/) · [hub](../) |
| **Interview** | ★★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 14 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

[Structured concurrency](../structured-concurrency/) — семейная поездка. Родитель знает, кто в машине; отмена поездки тянет детей.

`Task { }` с sync-улицы — иногда вызвать такси **отдельно**: полезно, когда ты не внутри async-scope, но водитель может везти пассажира после того, как ты уже ушёл с остановки.

> Unstructured — не «зло». Это **мост** с явной ценой: lifetime на тебе.

---

## Проблема

Нужно стартовать работу из места **без** async-контекста:

- нажатие кнопки в sync-обработчике;
- `init` view / controller;
- delegate callback;
- legacy API с completion handler, куда ты вставляешь «запусти async».

`Task { }` — мост в мир async. Цена:

- **lifetime не привязан** к scope экрана автоматически;
- отмена не «магически» приходит от родителя — нужен владелец;
- результат может прийти после dismiss → UI race, утечка смысла, лишняя сеть.

Без этого различия structured звучит как догма, а не как default с осознанными исключениями.

---

## История (коротко)

```text
GCD: dispatch_async «куда-то» — lifetime руками
  → structured concurrency: задача в дереве scope
  → Task { } из sync: мост, когда дерева ещё нет
  → Task.detached: ещё слабее связь с родителем — реже как default
```

Warehouse: [TaskVersatility.playground](../TaskVersatility.playground) · [StructuredConcurrencyLab](../StructuredConcurrencyLab.playground).

---

## Как это работает

| | Structured (в async scope) | Unstructured `Task { }` |
|--|----------------------------|-------------------------|
| Lifetime | Привязан к parent scope | Может пережить создателя |
| Cancel | Вниз по дереву (кооперативно) | Сам храни handle / вызывай `cancel()` |
| Ошибки | Всплывают к родителю scope | Нужен явный `try await task.value` или обработка |
| Когда ок | Default внутри async scope | Явный мост + владелец + план отмены |

<a class="eu-term" href="../../../glossary/#glossary-structured-concurrency">Structured concurrency</a> — правило «работа живёт внутри scope». Unstructured task — ребро **наружу** из графа.

Ментальная модель:

```text
sync world (button tap)
  → Task { await doWork() }   // мост
  → если экран dismiss — кто cancel? кто ждёт результат?
```

Правило:

> Unstructured — только с ответом на два вопроса: **кто отменит** и **кто потребляет результат безопасно**.

`Task.detached` — ещё слабее связь с текущим контекстом (priority, cancellation). Не default «просто чтобы на background»; чаще — осознанный выбор с риском.

---

## Внутри

Level 3 — дверь.

Task — не поток. Это единица работы в Swift Concurrency; executor может переиспользовать <a class="eu-term" href="../../../glossary/#glossary-thread">threads</a>. Unstructured task всё равно **task**, но без гарантии, что parent scope дождётся или отменит.

Связь с [suspension](../async-await-and-suspension/): внутри `Task { }` те же `await` и suspension points; меняется **ownership**, не механика ожидания.

Хранение `Task` handle (свойство view model, `task?.cancel()` в `onDisappear`) — паттерн владения, не «костыль».

---

## Пример

Псевдокод идеи:

```text
Плохо (сирота):
  Button("Load") {
    Task {
      let x = await fetch()
      self.label = x        // экран уже dismiss — гонка / warning
    }
  }

Лучше (владелец):
  var loadTask: Task<Void, Never>?
  Button("Load") {
    loadTask?.cancel()
    loadTask = Task {
      let x = await fetch()
      guard !Task.isCancelled else { return }
      await MainActor.run { self.label = x }
    }
  }
  onDisappear { loadTask?.cancel() }

Ещё лучше (если можешь):
  structured scope экрана { await load() }  // parent владеет
```

Разница не в «красивом синтаксисе», а в **кто отвечает за конец жизни работы**.

---

## Production

Привычка:

> Перед `Task { }` из View / controller: **хранишь ли handle и отменяешь на disappear?**

Чеклист:

1. Есть ли structured scope, куда можно перенести работу?
2. Если unstructured — где `cancel()` и guard на `Task.isCancelled`?
3. UI update — через MainActor / `@MainActor`, не «с любого потока»?
4. `Task.detached` — можешь назвать причину, почему не structured + не обычный `Task`?

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Unstructured vs structured? | Lifetime / cancel / ownership |
| Зачем `Task { }` из sync? | Мост в async без async-контекста |
| Почему `Task.detached` опасен как default? | Слабая связь; cancel; priority |
| Что при dismiss без cancel? | UI race, лишняя работа, crash/warning |
| Task = thread? | Нет; task — единица concurrency |

**Типичные ошибки:** «везде Task { }»; не хранить handle; detached «чтобы быстрее»; путать Task с DispatchQueue.

---

## Лабораторная

Пока теория. Практика: [TaskVersatility.playground](../TaskVersatility.playground) · [StructuredConcurrencyLab](../StructuredConcurrencyLab.playground) — сирота vs scope. Практика — по желанию.

---

## Конспект

Коротко со стола.

1. <a class="eu-term" href="../../../glossary/#glossary-task">Task</a> = единица работы, не поток.  
2. Unstructured легко становится **сиротой** после dismiss.  
3. Default — structured; unstructured — с владельцем и cancel.  
4. `Task { }` — мост из sync; не замена scope.  
5. Дальше — кто владеет **состоянием**, не только задачей.

---

## Рефлексия

> **до:** «запустил Task — и ладно»  
> **после:** сначала scope и владелец; unstructured — с cancel и handle

**Дальше:** [Actors и isolation](../actors-and-isolation/)

---

## Evidence

Теория этой главы в библиотеке (v1.1). Практика (playground / код) — по желанию читателя; не гейт Publish.

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise

## Open questions

Где у тебя последний unstructured `Task { }` пережил экран и обновил UI?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/tasks-and-unstructured-work` |
| **Version** | v1.1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [async-await-and-suspension](../async-await-and-suspension/) |
| **Next** | [actors-and-isolation](../actors-and-isolation/) |
| **Hub** | [../README.md](../README.md) |
| **Handoff** | [`.author/SWIFT_SHELF_HANDOFF.md`](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
