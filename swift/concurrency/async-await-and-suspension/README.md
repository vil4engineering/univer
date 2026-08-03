<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Чем suspension отличается от блокировки потока?

<p class="chapter-deck">
<code>await</code> говорит: «эта <em>задача</em> ждёт». Блокировка говорит: «этот <em>поток</em> занят и никому не отдаётся». Путать их — путь к UI freeze и ложным обещаниям про async.
</p>

<p class="chapter-meta">≈ 14 мин · Interview ★★★★★ · после structured concurrency</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Prerequisites** | [Structured concurrency](../structured-concurrency/) · [Process/thread](../processes-and-threads/) |
| **Next** | [Tasks / unstructured](../tasks-and-unstructured-work/) · [hub](../) |
| **Interview** | ★★★★★ |

</details>

---

## Интуиция

Представь колл-центр.

**Блокировка:** оператор держит трубку у уха и молчит — линия занята, следующий клиент не обслуживается этим оператором.

**Suspension:** оператор поставил клиента на удержание *правильно*: положил трубку в систему ожидания и взял другого. Когда ответ готов — система вернула разговор.

`await` ближе ко второму. Поток OS может пойти делать другую работу; **задача** ждёт.

---

## Проблема

После structured concurrency ясно: есть задачи и scope.

Следующая путаница на интервью:

- «async значит не блокирует» — не всегда: внутри async можно сделать sync-ад;  
- «await спит поток» — обычно нет: suspends **task**.

Без этой развилки дальше actors/`Task` звучат как магия.

---

## История (коротко)

```text
callback «потом»
  → async/await: тот же «потом», но как обычный control flow
  → под капотом: suspension points, а не обязательно занятый thread
```

---

## Как это работает

| | Suspension (`await`) | Blocking |
|--|----------------------|----------|
| Что ждёт | **Task** (единица concurrency) | **Thread** (OS) |
| Поток | Может быть отдан другой работе | Занят ожиданием / sync-работой |
| UI risk | Низкий, *если* нет sync-работы на main | Высокий на main thread |

```text
task:  work → await network → (suspend) → resume → UI update
thread: may run other tasks while this one is suspended
```

<a class="eu-term" href="../../../glossary/#glossary-async-await">async / await</a> — способ писать асинхронный поток линейно. Смысл `await`: здесь задача может уступить.

---

## Внутри

Level 3 — дверь. Кто именно resume'ит задачу (executor) — позже. Сейчас правило: **долгий sync на MainActor/main thread** всё ещё блокирует UI, даже если функция `async`.

---

## Пример

```text
Плохо: async func load() { heavySyncZip(); await fetch() }
       // heavySyncZip на main = freeze, async не спас

Лучше: тяжёлое — с main; await — на ожидании I/O
```

---

## Production

> Увидел freeze в «async» экране — спроси: **где sync-работа на main**, а не «почему await тормозит».

---

## Интервью

| Вопрос | Смотрят |
|--------|---------|
| await блокирует thread? | Обычно нет — suspends task |
| Почему UI всё равно фризит? | Sync work / wrong isolation |
| Зачем async/await? | Линейный async control flow |

---

## Лабораторная

[SwiftConcurrencyPrimer.playground](../SwiftConcurrencyPrimer.playground) — отметь suspension vs sync. Evidence async.

---

## Конспект

1. Suspension = ждёт task.  
2. Blocking = держит thread.  
3. async не отменяет sync-ад на main.  
4. Дальше — когда `Task { }` инструмент, а когда сирота.

---

## Рефлексия

> **до:** «await = sleep потока»  
> **после:** await = пауза задачи

**Дальше:** [Tasks и unstructured work](../tasks-and-unstructured-work/)

---

## Evidence

- [ ] Explained · Mock · Lab · Exercise  

<details><summary>For contributors</summary>

| Topic id | `swift/concurrency/async-await-and-suspension` |
| Design | [DESIGN.md](DESIGN.md) |

</details>
