<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Как тестировать concurrent код без sleep и флаков?

<p class="chapter-deck">
Детерминизм важнее wall-clock; inject clock/protocols; cancellation paths — не «подожди секунду и надеемся».
</p>

<p class="chapter-meta">
≈ 15 мин · Interview ★★★★ · гл.11 M03 · §D · после Sendable
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [Sendable / strict](../sendable-and-strict-concurrency/) |
| **Next** | [Production / migration](../production-architecture-and-migration/) |
| **Interview** | ★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 15 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Concurrent код **по определению** зависит от порядка и времени. Тест хочет **повторяемый** ответ: «если A, то B». `sleep(1)` — ставка на wall-clock: CI медленнее, симулятор занят, тест флапает.

> Хороший async-тест контролирует **зависимости**, не секунды на часах.

Подмени «реальное время» и «реальную сеть» на протоколы, которые **ты** двигаешь в тесте. Тогда suspension — часть сценария, а не лотерея.

Cancellation из [предыдущей главы](../cancellation-and-cooperation/) — отдельный сценарий: «ушёл пользователь → work остановился → UI не обновился». Без inject это почти не проверить детерминированно.

---

## Проблема

Типичные анти-паттерны:

- `sleep` / `DispatchQueue.asyncAfter` как «sync barrier»;
- real network в unit test;
- один глобальный singleton без reset между тестами;
- нет проверки **отмены** — только happy path;
- race «иногда зелёный» маскируется retry в CI.

Concurrent баги **не детерминированы** на уровне scheduling — но **контракт** твоего кода (что вернёт store после cancel, что покажет VM) должен быть детерминирован. Тест проверяет контракт, не OS scheduler.

Ошибка интервью: «async нельзя тестировать». Реальность: нельзя **надёжно** тестировать через sleep; можно через async tests + controlled deps.

Без тест-дисциплины [Sendable](../sendable-and-strict-concurrency/) и actors остаются «на бумаге» — регресс на границе никто не поймает.

---

## История (коротко)

```text
Sync tests + callbacks — expectations / semaphores (хрупко)
  → async XCTest / Swift Testing — await в тесте
  → inject protocols (clock, network, store)
  → deterministic scheduler / virtual time (где нужно)
  → cancellation + error paths как first-class scenarios
```

Warehouse: hub «What breaks» · ROADMAP M03 async testing follow-up.

---

## Как это работает

| Идея | Смысл |
|------|--------|
| Async test | `@MainActor` test или `async func test` — await completion, не sleep |
| Inject deps | `NetworkClient`, `Clock`, `Scheduler` — протокол + fake в тесте |
| Determinism | Контролируешь **ответы** deps, не real time |
| Cancellation test | Cancel <a class="eu-term" href="../../../glossary/#glossary-task">Task</a> / trigger disappear → assert no UI update |
| Flake source | Shared state, real I/O, wall-clock, missing isolation reset |

Паттерн «подмена времени»:

```text
protocol Clock { func now() -> Instant; func advance(by: Duration) }
struct TestClock: Clock { ... manually advance ... }
```

Паттерн «подмена сети»:

```text
protocol FeedLoader { func load() async throws -> [Item] }
struct StubLoader: FeedLoader { var result: Result<[Item], Error> }
```

Ментальная модель:

```text
Production     →  real URLSession, real time
Unit test      →  stub returns / test clock advances
Integration    →  отдельный слой; не смешивать с unit flake budget
```

Structured concurrency помогает: child <a class="eu-term" href="../../../glossary/#glossary-task">Task</a> в scope теста — lifetime ясен; cancel parent → проверь children ([StructuredConcurrencyLab](../StructuredConcurrencyLab.playground)).

---

## Внутри

Level 3 — дверь.

Полный test harness для actors, `@MainActor` ViewModels и Swift Testing migration — в labs и warehouse. Здесь — **принципы**, не каталог API.

`@MainActor` tests: UI-bound code тестируй на MainActor; иначе ловишь isolation errors вместо логики.

Проверка <a class="eu-term" href="../../../glossary/#glossary-data-race">data race</a> в тестах: Thread Sanitizer на integration/target tests; unit — через **контракт** (Sendable payloads, actor serialization), не «надеемся на scheduler».

Типичный cancellation scenario:

```text
1. Start load Task bound to screen scope
2. Cancel before completion (or trigger checkCancellation in stub)
3. Assert: no state publish after cancel · no duplicate side effect
```

---

## Пример

Псевдокод «флакает» vs «детерминирован»:

```text
Плохо:
  func testLoad() {
    viewModel.load()
    sleep(1)
    XCTAssertEqual(viewModel.items.count, 3)
  }

Лучше:
  func testLoad() async {
    stub.loader.result = .success(threeItems)
    await viewModel.load()
    XCTAssertEqual(viewModel.items.count, 3)
  }

Cancel path:
  func testCancelBeforeComplete() async {
    stub.loader = HangingLoader()
    let task = Task { await viewModel.load() }
    task.cancel()
    await task.value
    XCTAssertFalse(viewModel.didPublishAfterCancel)
  }
```

Stub «висит» — ты контролируешь момент cancel, без sleep.

---

## Production

Привычка:

> Новый async feature → **два** теста минимум: happy path + cancel/error path. Без sleep.

Чеклист:

1. Есть протокол для I/O и time?
2. Тесты `async` / `@MainActor` там, где production isolation?
3. Singleton / shared cache сбрасывается между тестами?
4. CI без «retry 3 times because flaky» на unit layer?

Симптом hub: duplicate requests / zombie work — часто нет теста на cancel при disappear.

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Как тестировать async без sleep? | Inject deps · async test · await completion |
| Почему sleep флакает? | Wall-clock · CI load · scheduler |
| Как тестировать cancel? | Controlled hang · cancel Task · assert no publish |
| Actor в тестах? | await calls · не лезть в state снаружи |
| Integration vs unit? | Real network — не в flaky unit budget |

**Типичные ошибки:** sleep как barrier; только happy path; global mutable test state; игнор MainActor isolation в test target.

---

## Лабораторная

Пока теория. Практика: перепиши один существующий тест с `sleep` на stub + `async` · [StructuredConcurrencyLab](../StructuredConcurrencyLab.playground) — cancel propagation. Практика — по желанию.

---

## Конспект

Коротко со стола.

1. Детерминизм через **inject**, не wall-clock.  
2. `async` test — await completion, не sleep.  
3. Cancel/error paths — обязательные сценарии.  
4. Stub protocols для network/time/store.  
5. `@MainActor` code — тест на MainActor.  
6. Flaky unit → ищи shared state и real I/O.  
7. Дальше — **production** границы и миграция.

---

## Рефлексия

> **до:** «async = sleep(1) в тесте»  
> **после:** контракт deps + cancel scenarios + async await

**Дальше:** [Production architecture / migration](../production-architecture-and-migration/)

---

## Evidence

Теория этой главы в библиотеке (v1). Практика (playground / код) — по желанию читателя; не гейт Publish.

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise

## Open questions

Какой один тест у тебя зелёный «на retry», но красный при полном CI run?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/testing-concurrent-systems` |
| **Version** | v1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [sendable-and-strict-concurrency](../sendable-and-strict-concurrency/) |
| **Next** | [production-architecture-and-migration](../production-architecture-and-migration/) |
| **Hub** | [../README.md](../README.md) |
| **Handoff** | [`.author/SWIFT_SHELF_HANDOFF.md`](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
