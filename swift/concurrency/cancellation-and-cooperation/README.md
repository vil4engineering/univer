<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Почему отмена кооперативная?

<p class="chapter-deck">
Отмена в Swift Concurrency — не «убить поток». Это сигнал: задача <em>должна заметить</em> и остановиться сама. Иначе «cancel» — иллюзия.
</p>

<p class="chapter-meta">
≈ 14 мин · Interview ★★★★★ · гл.9 M03 · после MainActor
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [Structured](../structured-concurrency/) · [Tasks](../tasks-and-unstructured-work/) · [MainActor](../mainactor-and-ui/) |
| **Next** | [Concurrency hub](../) · позже: Sendable / testing (parking) |
| **Related** | [async-defer](../../async-defer/) — cleanup ≠ cancel |
| **Interview** | ★★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 14 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Пожарная тревога в офисе: сирена = **сигнал**. Люди **сами** выходят по лестнице. Никто не телепортирует их на улицу mid-шаг. Кто заткнул уши и продолжил писать в общий журнал — остаётся внутри и портит состояние.

Cancellation в Swift — та же модель: **cooperative**. Runtime помечает задачу; код должен периодически «услышать» и выйти чисто.

> Cancel = «пора остановиться», не «Thread.abort».

---

## Проблема

Хочется «останови всё» при dismiss экрана, смене tab, уходе пользователя.

Если рантайм просто **убьёт** исполнение mid-write:

- половина записи в файл / cache;
- UI обновлён после dealloc;
- lock не отпущен (в ручном коде);
- inconsistent shared state.

Поэтому модель Swift: **cooperative** — проверь `Task.isCancelled`, `try Task.checkCancellation()`, выйди, брось `CancellationError` где уместно.

Отдельная путаница: cleanup (`defer`, close session) — про **lifetime ресурса**. Cancellation handler — про *реакцию на сигнал*. Паттерны и caveat toolchain — [async-defer](../../async-defer/).

---

## История (коротко)

```text
Kill thread (unsafe mid-state)
  → flag «please stop» + cooperative checks
  → structured concurrency: cancel parent → children marked
  → Swift: Task.cancel() + checkCancellation в hot paths
```

Связь с [structured](../structured-concurrency/): отмена **сверху вниз** по дереву — практическое следствие иерархии. Unstructured task — cancel только если **ты** держишь handle ([tasks](../tasks-and-unstructured-work/)).

---

## Как это работает

| | |
|--|--|
| Cancel signal | Пометить задачу / дерево (structured — вниз) |
| Cooperation | Код периодически проверяет и выходит |
| Не cancel | Сам по себе `defer` не отменяет сеть |
| Не kill | Поток не «убивается»; задача дожидается точки проверки |
| Propagation | Parent cancel → children cancelled (кооперативно) |

<a class="eu-term" href="../../../glossary/#glossary-task">Task</a> в structured scope наследует отмену. Снаружи:

```text
task?.cancel()
```

Внутри hot loop / long async path:

```text
try Task.checkCancellation()
guard !Task.isCancelled else { return }
```

Ментальная модель:

```text
cancel parent → children marked cancelled
child work: check → stop / throw CancellationError → cleanup (defer)
```

Некоторые API (URLSession tasks и т.п.) нужно **явно** связать с Task cancellation — «вызвал cancel» ≠ «сеть оборвалась», пока ты не пробросил сигнал.

---

## Внутри

Level 3 — дверь.

Priority и cancellation — разные оси: отменённая задача может ещё briefly run до check point.

`withTaskCancellationHandler` — hook «когда cancel пришёл»; не замена проверкам внутри work. Подробности — warehouse и [async-defer](../../async-defer/).

<a class="eu-term" href="../../../glossary/#glossary-sendable">Sendable</a> и testing async code — parking в хабе (план §D); здесь фокус на **поведении** cancel.

---

## Пример

Псевдокод dismiss экрана:

```text
Плохо (иллюзия cancel):
  onDisappear {
    task?.cancel()
  }
  func load() async {
    while true {
      let chunk = await socket.read()   // никогда не checkCancellation
      append(chunk)
    }
  }

Лучше (cooperation):
  onDisappear { task?.cancel() }
  func load() async throws {
    while true {
      try Task.checkCancellation()
      let chunk = try await socket.read()
      append(chunk)
    }
  }

Structured (идея):
  scope экрана {
    try await loadAll()
  } // уход = cancel детей + await завершения
```

Разница: **сигнал** без **сотрудничества** = пользователь ушёл, работа и UI race остались.

---

## Production

Привычка:

> На dismiss: **cancel Task handle** и убедись, что hot loop / network path *смотрит* на cancellation.

Чеклист:

1. Unstructured task — handle хранится и cancel на disappear?
2. Structured scope — parent живёт столько же, сколько UI?
3. Long-running loop — `checkCancellation` в итерации?
4. Cleanup файла / socket — `defer`, не путать с cancel signal ([async-defer](../../async-defer/))?
5. После cancel — не обновляешь UI на MainActor без guard?

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Почему cooperative? | Безопасность состояния; не kill mid-write |
| Cancel ≠ kill thread? | Сигнал задаче; поток может быть занят другим |
| Structured propagation? | Parent cancel → children |
| `defer` отменяет work? | Нет; cleanup vs cancel signal |
| Unstructured cancel? | Нужен явный handle + checks в work |

**Типичные ошибки:** «вызвал cancel — значит stopped»; нет checks в loop; путать defer и cancellation; UI update после dismiss.

---

## Лабораторная

Пока теория. Практика: [StructuredConcurrencyLab](../StructuredConcurrencyLab.playground) — cancel вниз по дереву · [async-defer](../../async-defer/) — cleanup vs cancel. Практика — по желанию.

---

## Конспект

Коротко со стола.

1. Cancel = **сигнал**, не kill потока / задачи mid-flight.  
2. Код должен **сотрудничать** — checks в hot paths.  
3. Structured несёт отмену **вниз** по дереву.  
4. Unstructured — cancel только с handle.  
5. Cleanup (`defer`) ≠ cancellation primitive.  
6. Дальше — [Sendable / strict](../sendable-and-strict-concurrency/) (§D).

---

## Рефлексия

> **до:** «cancel = остановил всё мгновенно»  
> **после:** сигнал + cooperation + structured propagation

**Дальше:** [Sendable и strict concurrency](../sendable-and-strict-concurrency/)

---

## Evidence

Теория этой главы в библиотеке (v1.1). Практика (playground / код) — по желанию читателя; не гейт Publish.

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise

## Open questions

Где у тебя `task?.cancel()` на dismiss, но work внутри никогда не вызывает `checkCancellation`?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/cancellation-and-cooperation` |
| **Version** | v1.1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [mainactor-and-ui](../mainactor-and-ui/) |
| **Next** | [sendable-and-strict-concurrency](../sendable-and-strict-concurrency/) |
| **Related** | [async-defer](../../async-defer/) |
| **Handoff** | [`.author/SWIFT_SHELF_HANDOFF.md`](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
