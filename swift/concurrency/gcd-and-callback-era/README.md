<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Что дали очереди и callback — и почему этого мало?

<p class="chapter-deck">
Очереди спасли от ручного зоопарка threads. Callbacks связали «потом». Но lifetime, ошибки и вложенность остались болью — поэтому позже появился structured concurrency.
</p>

<p class="chapter-meta">
≈ 16 мин · Interview ★★★★ · после shared state
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [Shared state / races](../shared-state-and-races/) · [Process/thread](../processes-and-threads/) |
| **Next** | structured concurrency (следующий unit) · [hub](../) · [GCD.playground](../GCD.playground) |
| **Interview** | ★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 16 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Представь гардероб с номерками вместо «беги сам между комнатами».

Ты не создаёшь сотрудника на каждое пальто. Ты кладёшь работу в **очередь**: «сделайте это, когда будет слот». Кто именно исполнит — решает система очередей.

**Callback** — записка: «когда закончите, позовите меня сюда». Удобно для одного шага. Для пяти шагов записки начинают плодить записки.

---

## Проблема

Мы уже знаем: сырые threads + shared mutable state = гонки.

Нужен слой:

- не плодить `Thread` вручную на каждый чих;
- сериализовать куски работы (одна очередь = один мир за раз — идея);
- увести тяжёлое с main, вернуть результат на UI.

GCD (и родственные очереди) дали этот слой. Callbacks стали клеем «потом».

Но клей хрупкий: вложенность, ошибки на каждом этаже, «кто отменит?», «экран уже закрыт».

---

## История (коротко)

```text
Raw Thread
  → GCD queues / OperationQueue  (организация работы)
  → callbacks / delegates / completions
  → Combine как поток событий над той же эпохой
  → Swift Concurrency (structured tasks, isolation) — следующий ответ
```

GCD не «умер». Он остаётся в системе и в легаси. Глава про то, **что он закрыл** и **чего не закрыл**.

Warehouse: [Concurrency evolution note](../notes/Concurrency-Evolution-From-Threads-to-Modern-Swift.md) · [GCD.playground](../GCD.playground).

---

## Как это работает

### Очередь (идея)

| Идея | Зачем |
|------|--------|
| Serial queue | Работы одной очереди не пересекаются во времени → проще защитить состояние |
| Concurrent queue | Несколько работ рядом; shared state всё ещё твоя ответственность |
| Main queue | Мир UI на Apple; возвращайся сюда для UIKit |

Ты больше не обязан сам крутить `Thread`. Ты говоришь: *какую работу* и *в какой очереди*.

### Callback (идея)

```text
startWork { result in
  // «потом» на каком-то исполнении
}
```

Один уровень — ок. Цепочка загрузок/парсинга/сохранения → пирамида, дублирование `DispatchQueue.main.async`, потерянный error path.

---

## Внутри

Level 3 — дверь.

Очередь не отменяет data race сама по себе, если ты шаришь mutable state между concurrent очередями без правил. Serial queue — инструмент сериализации, не магия.

Отмена и lifetime в callback-эре часто ручные: флаг, `weak self`, «экран жив?». Structured concurrency позже делает lifetime частью модели — здесь только намёк.

---

## Пример

Псевдокод боли callback-эры:

```text
loadUser { user in
  loadOrders(user) { orders in
    loadImage(orders.first) { image in
      DispatchQueue.main.async {
        // UI update — если экран ещё существует
      }
    }
  }
}
```

Идея следующего шага эволюции: одна структура задач с понятным scope и отменой — не «ещё один completion».

---

## Production

Привычка:

> Перед новым completion-handler спроси: **кто владеет lifetime этой работы, и что будет при dismiss?**

Если ответ «ну… флаг», ты в зоне, ради которой придумали structured concurrency.

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Зачем GCD, если есть threads? | Организация, пулы, main/background |
| Serial vs concurrent queue? | Сериализация vs fan-out |
| Почему callbacks болят? | Nesting, errors, cancellation, lifetime |
| GCD устарел? | Нет; рядом с Swift Concurrency |

**Ошибки:** «GCD = parallelism всегда»; «main.async лечит гонки».

---

## Лабораторная

Теория покрыта. Практика: [GCD.playground](../GCD.playground) — serial vs concurrent; отметь в Evidence.

---

## Конспект

1. Очереди убрали ручной зоопарк threads.  
2. Serial queue — идея «один мир за раз».  
3. Callbacks клеят «потом», но плохо масштабируются.  
4. Lifetime/отмена в callback-эре часто ручные.  
5. Дальше — structured concurrency как ответ на эту боль.

---

## Рефлексия

> **до:** «GCD решил concurrency»  
> **после:** GCD решил организацию работы; боль composition/lifetime осталась

**Дальше:** structured concurrency (следующий unit на roadmap) · пока [hub](../).

---

## Evidence

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise  

## Open questions

Где в твоём коде самая глубокая пирамида completion — и кто её отменяет при dismiss?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/gcd-and-callback-era` |
| **Version** | v1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [shared-state-and-races](../shared-state-and-races/) |
| **Handoff** | [§8b](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
