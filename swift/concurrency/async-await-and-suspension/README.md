<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Чем suspension отличается от блокировки потока?

<p class="chapter-deck">
<code>await</code> говорит: «эта <em>задача</em> ждёт». Блокировка говорит: «этот <em>поток</em> занят и никому не отдаётся». Путать их — путь к UI freeze и ложным обещаниям про async.
</p>

<p class="chapter-meta">
≈ 14 мин · Interview ★★★★★ · гл.5 M03 · после structured concurrency
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [Structured concurrency](../structured-concurrency/) · [Process/thread](../processes-and-threads/) |
| **Next** | [Tasks / unstructured](../tasks-and-unstructured-work/) · [hub](../) |
| **Interview** | ★★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 14 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Представь колл-центр.

**Блокировка:** оператор держит трубку у уха и молчит — линия занята, следующий клиент не обслуживается этим оператором. Пока он ждёт ответа от техподдержки, он *ничем другим* не занимается.

**Suspension:** оператор поставил клиента на удержание *правильно*: положил трубку в систему ожидания и взял другого. Когда ответ готов — система вернула разговор туда, где прервали.

`await` ближе ко второму. <a class="eu-term" href="../../../glossary/#glossary-thread">Thread</a> OS может пойти делать другую работу; **задача** (<a class="eu-term" href="../../../glossary/#glossary-task">Task</a>) ждёт.

> Suspension — про **задачу**. Blocking — про **поток**. Это разные единицы.

---

## Проблема

После [structured concurrency](../structured-concurrency/) ясно: есть scope, дерево задач, отмена вниз.

Следующая путаница на интервью и в коде:

- «async значит не блокирует» — **не всегда**: внутри `async` можно сделать sync-ад и держать поток;
- «await спит поток» — **обычно нет**: suspends **task**, не обязательно thread;
- «переписал на async — UI ожил» — иногда ложь: тяжёлая sync-работа на main всё ещё freeze.

Без этой развилки дальше actors, `Task { }` и MainActor звучат как магия, а не как продолжение одной модели.

---

## История (коротко)

```text
callback «потом» (completion handler)
  → pyramid of doom, lifetime руками
  → async/await: тот же «потом», но как обычный control flow
  → под капотом: suspension points, а не обязательно занятый thread
  → structured concurrency: задача в иераархии, не «просто callback»
```

Warehouse: [What's “structured”](../notes/Structured-Concurrency-What-Structured-Means.md) — suspension вписан в scope, а не висит в воздухе.

---

## Как это работает

Два слова, которые путают на интервью:

| | Suspension (`await`) | Blocking |
|--|----------------------|----------|
| Что ждёт | **Task** (единица <a class="eu-term" href="../../../glossary/#glossary-concurrency">concurrency</a>) | **Thread** (OS) |
| Поток | Может быть отдан другой работе | Занят ожиданием / sync-работой |
| UI risk | Низкий, *если* нет sync-работы на main | Высокий на main thread |
| Модель | «Задача уступила; вернётся на suspension point» | «Поток стоит, пока не вернётся» |

<a class="eu-term" href="../../../glossary/#glossary-async-await">async / await</a> — способ писать асинхронный поток **линейно**. Смысл `await`: здесь задача может уступить, пока ждёт I/O или другую async-работу.

Ментальная модель:

```text
task:   work → await network → (suspend) → resume → UI update
thread: may run other tasks while this one is suspended
```

`async` на функции — обещание: внутри могут быть suspension points. Это **не** обещание «ни один поток не блокируется».

---

## Внутри

Level 3 — дверь, не комната.

Кто именно resume'ит задачу (executor, планировщик) — позже. Сейчас правило:

- **Долгий sync на MainActor / main thread** всё ещё блокирует UI, даже если функция `async`.
- Suspension point — место, где runtime *может* отдать поток; sync-цикл до `await` — нет.

Связь с [process/thread](../processes-and-threads/): поток — ресурс OS; задача — единица Swift Concurrency. Один поток может обслуживать много suspended tasks.

---

## Пример

Псевдокод «плохо» vs «зачем различать» — без API-каталога:

```text
Плохо:
  @MainActor async func load() {
    heavySyncZip()      // держит main — freeze
    await fetch()       // await не спасает то, что было ДО него
    updateUI()
  }

Лучше (идея):
  @MainActor async func load() {
    let data = await fetchOffMain()   // suspension на I/O
    updateUI(with: data)              // короткий sync на main — ок
  }
```

Ещё ловушка:

```text
«Не блокирует» ≠ «быстро»
  await slowNetwork()  // task suspended, thread свободен
  await slowNetwork()  // UI жив, но пользователь всё равно ждёт данные
```

Отзывчивость и скорость — разные оси.

---

## Production

Одна привычка:

> Увидел freeze в «async» экране — спроси: **где sync-работа на main**, а не «почему await тормозит».

Чеклист перед ревью:

1. Есть ли цикл / parse / decode **до** первого `await` на MainActor?
2. Обещали «async = параллель» там, где только suspension на одном потоке?
3. Callback заменили на `await`, но тяжёлое осталось в том же месте?

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| `await` блокирует thread? | Обычно нет — suspends **task** |
| Почему UI всё равно фризит в async-коде? | Sync work / wrong isolation / work до await |
| Зачем async/await после callbacks? | Линейный control flow + structured scope |
| Suspension vs blocking? | Task vs thread; разные единицы |
| async = non-blocking? | Нет; sync внутри async всё ещё blocking |

**Типичные ошибки:** «await sleep потока»; «async автоматически на background»; игнорировать sync-ад на main.

---

## Лабораторная

Пока теория. Практика асинхронно: [SwiftConcurrencyPrimer.playground](../SwiftConcurrencyPrimer.playground) — отметь, где suspension, а где sync держит поток. Evidence async.

---

## Конспект

Коротко со стола.

1. Suspension = ждёт **task**; blocking = держит **thread**.  
2. `await` — suspension point; до него sync-работа блокирует как раньше.  
3. `async` не отменяет sync-ад на main / MainActor.  
4. Отзывчивость UI ≠ «всё async»; важно *где* sync.  
5. Это мост от structured scope к Task и isolation дальше.

---

## Рефлексия

> **до:** «await = sleep потока» · «async = не блокирует»  
> **после:** await = пауза **задачи**; blocking смотри по **потоку** и sync-участкам

**Дальше:** [Tasks и unstructured work](../tasks-and-unstructured-work/)

---

## Evidence

Теория этой главы покрыта (v1.1). Практика / Path write-back — асинхронно.

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise

## Open questions

Где в твоём последнем PR «async» экран всё ещё делает тяжёлую sync-работу до первого `await`?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/async-await-and-suspension` |
| **Version** | v1.1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [structured-concurrency](../structured-concurrency/) |
| **Next** | [tasks-and-unstructured-work](../tasks-and-unstructured-work/) |
| **Hub** | [../README.md](../README.md) |
| **Handoff** | [`.author/SWIFT_SHELF_HANDOFF.md`](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
