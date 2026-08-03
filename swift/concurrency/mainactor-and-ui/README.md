<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Зачем граница UI отдельным миром?

<p class="chapter-deck">
UI на Apple — отдельный мир. <a class="eu-term" href="../../../glossary/#glossary-mainactor">@MainActor</a> называет эту границу <a class="eu-term" href="../../../glossary/#glossary-isolation">isolation</a>, а не «просто main thread навсегда везде».
</p>

<p class="chapter-meta">
≈ 12 мин · Interview ★★★★★ · гл.8 M03 · после actors
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [Actors](../actors-and-isolation/) · [suspension](../async-await-and-suspension/) |
| **Next** | [Cancellation](../cancellation-and-cooperation/) · [hub](../) |
| **Interview** | ★★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 12 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Сцена театра: декорации и занавес трогает только сцена во время спектакля. Кулисы готовят реквизит, но не толкают декорации посреди сцены.

UI — «сцена»: пользователь видит результат **здесь**. Фоновая работа — «кулисы»: fetch, parse, disk. Если грузчики правят декорации с произвольной линии — хаос, warning, иногда crash.

> MainActor — **имя границы** UI world, не «весь app однопоточный».

---

## Проблема

UIKit и AppKit исторически требуют: мутация и чтение UI — с main. Это не «прихоть Swift», а контракт фреймворков.

Concurrency без явной границы возвращает старые симптомы:

- «иногда красный warning Main Thread Checker»;
- «обновил label с background — один раз сработало»;
- async не спасает, если **тяжёлый sync** сидит на MainActor.

Путаница на интервью: `@MainActor` = «main thread» vs `@MainActor` = **isolation domain** (как actor, но для UI).

---

## История (коротко)

```text
Single-threaded UI assumption (Cocoa)
  → GCD: DispatchQueue.main «вернись сюда для UI»
  → Swift Concurrency: @MainActor как языковая метка
  → hop: off main для work → await → back для UI
```

Связь с [actors](../actors-and-isolation/): MainActor — глобальный actor для UI; те же правила isolation и `await` на границе.

---

## Как это работает

| Идея | Смысл |
|------|--------|
| UI world | Обновления интерфейса — в main isolation |
| `@MainActor` | Тип / функция / property живут в этом мире |
| Hop | Тяжёлая работа off MainActor → `await` → назад для UI |
| Не «весь app main» | Только то, что помечено / наследует MainActor |
| Sync на MainActor | Блокирует UI так же, как sync на main thread |

<a class="eu-term" href="../../../glossary/#glossary-mainactor">@MainActor</a> ≠ «все async автоматически на background». Это **граница**, куда возвращаешься за UI.

Ментальная модель:

```text
@MainActor view model
  → await fetch()           // может suspend; не держи sync тут
  → await processOffMain()  // work вне UI world
  → title = result          // снова на MainActor — ок
```

Старый паттерн `DispatchQueue.main.async { }` — тот же hop, но без compile-time проверок. MainActor — способ **назвать** границу в типах.

---

## Внутри

Level 3 — дверь.

SwiftUI часто генерирует MainActor-isolated view code; UIKit — смешанный legacy. Правило остаётся: **touch UI только в UI world**.

`MainActor.assumeIsolated` и подобное — escape hatches для interop; не учебный default.

Связь с [suspension](../async-await-and-suspension/): `await` на MainActor suspends **task**, но sync-цикл до `await` всё ещё freeze. Async UI-код ≠ автоматически responsive.

---

## Пример

Псевдокод «freeze на MainActor» vs «hop»:

```text
Плохо:
  @MainActor func refresh() async {
    let raw = downloadSync()     // держит main
    let parsed = parseSync(raw)  // всё ещё main
    label.text = parsed
  }

Лучше (идея):
  @MainActor func refresh() async {
    label.text = "Loading…"
    let parsed = await loadAndParseOffMain()
    label.text = parsed
  }

  func loadAndParseOffMain() async -> String {
    let raw = await fetch()
    return parse(raw)            // вне MainActor — ok
  }
```

«Off main» не обязательно «новый thread навсегда» — это **вне UI isolation**, часто через async task / nonisolated work.

---

## Production

Привычка:

> Тяжёлый zip / parse / decode на MainActor? **Вынеси.** UI update — **вернись.**

Чеклист:

1. Где `@MainActor` на type — не тащи ли туда network layer?
2. SwiftUI `Task { }` в `.onAppear` — cancel на disappear ([tasks](../tasks-and-unstructured-work/))?
3. Legacy `DispatchQueue.main` и новый `@MainActor` — одна политика, не два мира?
4. Preview / test — учитывают MainActor isolation?

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Почему UI на main? | Контракт UIKit/AppKit / main run loop |
| MainActor vs `DispatchQueue.main`? | Isolation в языке vs ручной hop |
| Почему freeze при async UI? | Sync work на MainActor до/без await |
| MainActor = один thread? | UI isolation; executor может переиспользовать |
| Как связано с actor? | MainActor — global actor для UI |

**Типичные ошибки:** «async значит UI не блокируется»; весь app на MainActor; обновлять UI с background без hop.

---

## Лабораторная

Пока теория. Практика: [SwiftConcurrencyPrimer.playground](../SwiftConcurrencyPrimer.playground) · [TaskVersatility.playground](../TaskVersatility.playground) — hop on/off MainActor. Evidence async.

---

## Конспект

Коротко со стола.

1. UI — отдельный **isolation world**.  
2. `@MainActor` маркирует границу, не «магический background».  
3. Sync-ад на MainActor = freeze, даже в `async`.  
4. Паттерн: work off main → await → UI update on MainActor.  
5. Дальше — как **остановить** work, когда UI world уже закрыт.

---

## Рефлексия

> **до:** «MainActor = main thread везде»  
> **после:** именованная граница UI; hop туда и обратно осознанно

**Дальше:** [Cancellation / cooperation](../cancellation-and-cooperation/)

---

## Evidence

Теория этой главы покрыта (v1.1). Практика / Path write-back — асинхронно.

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise

## Open questions

Где у тебя `@MainActor` type случайно тянет тяжёлую работу «потому что так проще»?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/mainactor-and-ui` |
| **Version** | v1.1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [actors-and-isolation](../actors-and-isolation/) |
| **Next** | [cancellation-and-cooperation](../cancellation-and-cooperation/) |
| **Hub** | [../README.md](../README.md) |
| **Handoff** | [`.author/SWIFT_SHELF_HANDOFF.md`](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
