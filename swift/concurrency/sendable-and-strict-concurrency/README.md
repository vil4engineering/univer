<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Зачем Sendable и strict concurrency?

<p class="chapter-deck">
Границы изоляции без <a class="eu-term" href="../../../glossary/#glossary-data-race">data race</a> — компилятор помогает, не магия immutability.
</p>

<p class="chapter-meta">
≈ 15 мин · Interview ★★★★★ · гл.10 M03 · §D · после cancel
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [Actors / isolation](../actors-and-isolation/) · [Cancellation](../cancellation-and-cooperation/) |
| **Next** | [Testing concurrent systems](../testing-concurrent-systems/) |
| **Interview** | ★★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 15 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Ты уже знаешь: <a class="eu-term" href="../../../glossary/#glossary-actor">actor</a> — кабинет с одной дверью. Снаружи кабинета — другой мир: другой actor, background <a class="eu-term" href="../../../glossary/#glossary-task">Task</a>, `@MainActor`.

Когда данные **пересекают** такую границу, компилер спрашивает: «это безопасно?» Не «красиво», не «immutable звучит модно» — **можно ли передать без гонки?**

> <a class="eu-term" href="../../../glossary/#glossary-sendable">Sendable</a> — не «всё value type автоматом ок». Это **разрешение** пересечь isolation domain без <a class="eu-term" href="../../../glossary/#glossary-data-race">data race</a>.

Strict concurrency — когда эти вопросы перестают быть «warning в углу» и становятся частью сборки. Не наказание за Swift 6 — продолжение линии actors + isolation: границы должны быть явными.

---

## Проблема

[Shared mutable state](../shared-state-and-races/) + передача между потоками/задачами = классическая боль.

До Sendable:

- «Передам `class` в closure — сам разберусь»;
- `@unchecked Sendable` как duct tape;
- компилятор молчит, TSan орёт на CI.

После actors ты защитил **внутри** кабинета. Но API всё ещё может протащить non-Sendable reference через `Task { }`, callback или `async let`. Гонка переезжает на **границу**, не исчезает.

Ошибка интервью: «Sendable = struct, class — нет». Реальность: value type с mutable shared reference внутри тоже может быть небезопасен; `final class` с immutable полями может быть Sendable — если доказуемо.

Без Sendable strict mode — isolation и MainActor остаются **локальными** правилами; cross-boundary дыры остаются.

---

## История (коротко)

```text
Threads / GCD — «сам следи за queue»
  → actors / MainActor — границы в языке
  → Sendable — типы, которым разрешено пересекать границы
  → strict concurrency — компилятор не даёт «забыл»
  → постепенная миграция модулей, не big bang
```

Warehouse: [ActorsQueuesLocksInterview.playground](../ActorsQueuesLocksInterview.playground) · hub Level 2 Sendable.

---

## Как это работает

| Идея | Смысл |
|------|--------|
| <a class="eu-term" href="../../../glossary/#glossary-sendable">Sendable</a> | Маркер: тип безопасен для передачи между isolation domains |
| Isolation domain | Actor, `@MainActor`, global actor, иногда task-local контекст |
| Cross-boundary | `await`, `Task { }`, callback, `async let` — точки проверки |
| Strict concurrency | Build setting: нарушения Sendable/isolation → ошибки |
| Не immutability magic | `Sendable` class возможен при доказуемой безопасности; struct — не автомат win |

Что обычно Sendable «из коробки»:

- `Int`, `String`, чистые value types без shared refs;
- `actor` types (изолированное состояние);
- некоторые generic collections, если элемент Sendable.

Что часто **не** Sendable без работы:

- arbitrary `class` с mutable fields;
- closure, захватывающий non-Sendable;
- legacy NSObject subclasses.

Ментальная модель:

```text
actor внутри     →  сериализация внутри кабинета
Sendable снаружи →  «что я передаю через дверь — без гонки?»
strict mode      →  компилятор не пропускает сомнительное
```

`@unchecked Sendable` — **ты** берёшь ответственность. На интервью и в коде: только с доказанным инвариантом, не «чтобы warning пропал».

---

## Внутри

Level 3 — дверь.

`nonisolated(unsafe)` и `@unchecked Sendable` — escape hatches для legacy. Не default. Подробности API и migration tooling — в [production chapter](../production-architecture-and-migration/) и warehouse.

Типичный сценарий strict mode:

```text
@MainActor class ViewModel { ... }   // UI world
Task {
  await vm.update(from: payload)     // crossing — payload Sendable?
}
```

Если `payload` — mutable class, shared между экранами — strict mode не даст «на авось».

Связь с [cancellation](../cancellation-and-cooperation/): отменённая задача всё ещё может **передавать** non-Sendable, если ты уже нарушил границу. Sendable и cancel — разные оси; обе нужны в production checklist.

---

## Пример

Псевдокод «дыра на границе» vs «явная граница»:

```text
Плохо (non-Sendable class через Task):
  class Session { var token: String? }
  let s = Session()
  Task {
    await fetch(s)        // shared mutable class — гонка с MainActor
  }

Лучше (идея):
  struct SessionSnapshot: Sendable { let token: String? }
  actor SessionStore {
    private var token: String?
    func snapshot() -> SessionSnapshot { SessionSnapshot(token: token) }
  }
  let snap = await store.snapshot()
  Task { await fetch(snap) }   // Sendable value crosses boundary
```

Не обязательно всё в actor — но **mutable shared** не должен бесшумно пересекать границы.

---

## Production

Привычка:

> Перед `@unchecked Sendable`: **какой инвариант** доказываешь? Если не можешь одним предложением — не unchecked.

Чеклист:

1. Новый тип уходит в `Task` / actor / `@MainActor` API → Sendable?
2. Legacy `class` — snapshot / actor wrapper / изоляция на границе?
3. Strict mode включён хотя бы на target/module в CI?
4. Warning «Sendable conformance» — fix, не suppress пачкой?

Симптом из hub «What breaks»: random crashes / TSan → первым делом ищи non-Sendable crossing, не «Swift 6 сломан».

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Что такое Sendable? | Безопасность cross-isolation, не «только struct» |
| Sendable vs actor? | Actor изолирует; Sendable разрешает **передачу** |
| `@unchecked Sendable`? | Ручная гарантия; риск и ответственность |
| Strict concurrency зачем? | Ловить границы на compile time |
| Value type всегда Sendable? | Нет, если внутри shared mutable ref |

**Типичные ошибки:** Sendable = immutability magic; unchecked без доказательства; игнорировать crossing в unstructured Task.

---

## Лабораторная

Пока теория. Практика: включи strict concurrency на маленьком target · прогон [ActorsQueuesLocksInterview.playground](../ActorsQueuesLocksInterview.playground) с Sendable errors. Evidence async.

---

## Конспект

Коротко со стола.

1. <a class="eu-term" href="../../../glossary/#glossary-sendable">Sendable</a> — разрешение пересечь isolation без <a class="eu-term" href="../../../glossary/#glossary-data-race">data race</a>.  
2. Actor защищает **внутри**; Sendable — **на границе**.  
3. Strict concurrency делает границы обязательными в сборке.  
4. Value type ≠ автомат Sendable; class ≠ автомат запрет.  
5. `@unchecked Sendable` — только с доказанным инвариантом.  
6. Дальше — как **тестировать** эти границы без sleep.

---

## Рефлексия

> **до:** «Sendable = struct, class — нет»  
> **после:** cross-isolation contract; компилятор как соавтор границ

**Дальше:** [Как тестировать concurrent код](../testing-concurrent-systems/)

---

## Evidence

Теория этой главы покрыта (v1). Практика / Path write-back — асинхронно.

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise

## Open questions

Где у тебя `@unchecked Sendable` без комментария «какой инвариант»?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/sendable-and-strict-concurrency` |
| **Version** | v1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [cancellation-and-cooperation](../cancellation-and-cooperation/) |
| **Next** | [testing-concurrent-systems](../testing-concurrent-systems/) |
| **Hub** | [../README.md](../README.md) |
| **Handoff** | [`.author/SWIFT_SHELF_HANDOFF.md`](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
