<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Почему isolation, а не «поток на объект»?

<p class="chapter-deck">
<a class="eu-term" href="../../../glossary/#glossary-actor">Actor</a> — не «выдели поток». Это <a class="eu-term" href="../../../glossary/#glossary-isolation">isolation</a>: состояние трогает один мир за раз, а на <code>await</code> дверь может впустить другую работу.
</p>

<p class="chapter-meta">
≈ 15 мин · Interview ★★★★★ · гл.7 M03 · после Task
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [Shared state](../shared-state-and-races/) · [Tasks](../tasks-and-unstructured-work/) |
| **Next** | [MainActor / UI](../mainactor-and-ui/) · [hub](../) |
| **Interview** | ★★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 15 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Один кабинет с одной дверью: внутри правят документами кабинета. Снаружи — очередь посетителей; внутри в один момент времени правит **один** поток мысли над **этим** состоянием.

Это не «сотрудник навсегда приклеен к кабинету» (thread-per-object). Это **правило входа**: кто может трогать документы и в каком порядке.

На `await` дверь может временно впустить другую работу **в тот же actor** — reentrancy. После возврата инварианты могли измениться; это не баг модели, а цена async внутри isolation.

> Actor — про **владение состоянием**, не про «выделенный поток навсегда».

---

## Проблема

[Shared mutable state](../shared-state-and-races/) ломается без правил: два исполнения правят одни байты → <a class="eu-term" href="../../../glossary/#glossary-data-race">data race</a>.

Исторические ответы:

- lock / serial queue вручную — работает, но «забыл unlock» и «вызвал callback на wrong queue» ловятся поздно;
- «один поток на объект» — звучит просто, но потоки дороги, а границы всё равно размываются через callbacks.

Ошибка интервью: «actor = thread на объект». Реальность: actor **сериализует доступ** к своему состоянию; executor может переиспользовать потоки.

Без isolation дальше MainActor и Sendable — просто слова из чеклиста.

---

## История (коротко)

```text
Shared mutable state + threads
  → locks / GCD serial queues (ручные правила)
  → Swift Concurrency: isolation как язык + runtime
  → actor: компилятор помогает держать границу
  → MainActor: тот же принцип для UI world
```

Warehouse: [ActorsQueuesLocksInterview.playground](../ActorsQueuesLocksInterview.playground).

---

## Как это работает

| Идея | Смысл |
|------|--------|
| <a class="eu-term" href="../../../glossary/#glossary-isolation">Isolation</a> | Код и состояние принадлежат домену; снаружи — через `await` |
| Actor | Тип с изолированным mutable state; входы сериализуются |
| Сериализация | Вызовы в actor не пересекают мутацию состояния хаотично |
| Reentrancy | После `await` внутри actor другая работа может зайти — перепроверь инварианты |
| Не thread | Executor планирует; один actor ≠ один OS thread навсегда |

Снаружи actor ты **не** трогаешь свойства напрямую — только через `await`:

```text
await cache.store(item)   // crossing isolation boundary
```

<a class="eu-term" href="../../../glossary/#glossary-actor">Actor</a> лечит **владение состоянием**, не заменяет всю модель <a class="eu-term" href="../../../glossary/#glossary-concurrency">concurrency</a>. Задачи, suspension, cancel — по-прежнему в игре.

Ментальная модель:

```text
class + lock     →  «я сам помню mutex»
actor            →  «язык знает границу; await = дверь»
```

---

## Внутри

Level 3 — дверь.

`nonisolated` / `nonisolated(unsafe)` — исключения из правила; не default. Подробности API — в labs и warehouse, не здесь.

Reentrancy — частый источник «actor же должен был защитить»:

```text
actor Bank {
  var balance = 100
  func withdraw(_ n: Int) async {
    guard balance >= n else { return }
    await log()              // другой withdraw может зайти здесь
    balance -= n             // инвариант мог измениться
  }
}
```

Урок: после каждого `await` внутри actor — **перечитай** состояние, не доверяй старым локальным предположениям.

---

## Пример

Псевдокод «очередь руками» vs «actor»:

```text
Плохо (class + queue, легко ошибиться):
  class Cache {
    var map = [:]
    let q = DispatchQueue(label: "cache")
    func get(key) { q.sync { map[key] } }   // sync на hot path?
    func set(key, val) { q.async { map[key] = val } }  // race с get?
  }

Лучше (идея actor):
  actor Cache {
    var map = [:]
    func get(key) -> Value? { map[key] }
    func set(key, value) { map[key] = value }
  }
  // снаружи: await cache.set(...) — граница явная
```

Actor не отменяет необходимость думать про **async** API и reentrancy — но убирает класс «забыл lock».

---

## Production

Привычка:

> Перед `class` + ручные serial queues: **нужен явный владелец состояния?** Часто actor или `@MainActor` яснее.

Чеклист:

1. Mutable shared state — у кого один владелец?
2. Есть ли `await` внутри actor-метода → reentrancy проверена?
3. UI state — не в generic actor, а в [MainActor world](../mainactor-and-ui/)?
4. Legacy callback не обходит isolation через `nonisolated(unsafe)` без красной лампы?

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Actor vs serial queue? | Языковая граница vs ручной дисциплина |
| Actor = thread? | Нет; сериализация доступа, не 1:1 thread |
| Reentrancy после await? | Другой вызов может войти; инварианты заново |
| Как связано с data race? | Isolation предотвращает гонки **внутри** правил |
| Actor vs class + lock? | Компилятор + await на границе |

**Типичные ошибки:** thread-per-object; игнорировать reentrancy; mutable UI state в actor без MainActor.

---

## Лабораторная

Пока теория. Практика: [ActorsQueuesLocksInterview.playground](../ActorsQueuesLocksInterview.playground) — actor vs queue vs lock. Практика — по желанию.

---

## Конспект

Коротко со стола.

1. <a class="eu-term" href="../../../glossary/#glossary-isolation">Isolation</a> = правило доступа, не «свой поток».  
2. Actor сериализует доступ к **своему** состоянию.  
3. После `await` возможна **reentrancy** — перепроверяй инварианты.  
4. Снаружи actor — только через `await`.  
5. UI world — отдельная граница ([MainActor](../mainactor-and-ui/)).

---

## Рефлексия

> **до:** «actor = поток на объект»  
> **после:** isolation + сериализация; thread — деталь executor

**Дальше:** [MainActor и UI](../mainactor-and-ui/)

---

## Evidence

Теория этой главы в библиотеке (v1.1). Практика (playground / код) — по желанию читателя; не гейт Publish.

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise

## Open questions

Где в твоём коде `await` внутри actor меняет инвариант, который ты проверил «до»?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/actors-and-isolation` |
| **Version** | v1.1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [tasks-and-unstructured-work](../tasks-and-unstructured-work/) |
| **Next** | [mainactor-and-ui](../mainactor-and-ui/) |
| **Hub** | [../README.md](../README.md) |
| **Handoff** | [`.author/SWIFT_SHELF_HANDOFF.md`](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
