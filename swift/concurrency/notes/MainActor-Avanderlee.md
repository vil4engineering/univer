# @MainActor — main thread без ручного `DispatchQueue.main`

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | [Antoine van der Lee — @MainActor in Swift explained with code examples](https://www.avanderlee.com/swift/mainactor-dispatch-main-thread/) |
| Related | [MainActor / UI chapter](../mainactor-and-ui/) · [Actors](../actors-and-isolation/) · [Approachable Concurrency](Approachable-Concurrency-Thread-Hopping-nsvasilev.md) |

---

## Выжимка (прочитай до тела)

**О чём статья.** Практический гайд Antoine van der Lee: что такое `@MainActor`, куда вешать атрибут (тип / свойство / метод / closure), чем заменить `DispatchQueue.main.async`, и как не обмануться «атрибут = всегда main».

**Анализ (зачем нам).** Закрывает дыру между Living-главой [mainactor-and-ui](../mainactor-and-ui/) (why / hop) и «как писать руками»: много копируемых примеров + Swift 5 pitfall + Swift 6.2 Default Actor Isolation. Для новичков — карта API; для миграции — когда opt-out, а не «клеить везде».

**В 30 секунд.** `@MainActor` — global actor на main thread; компилятор требует hop вместо ручного `DispatchQueue.main`. С 6.2 + default isolation новый app часто уже на MainActor — вопрос *когда снимать* (`nonisolated` / `@concurrent`). `MainActor.run` = короткий hop; `Task { @MainActor in }` = весь Task на main; `assumeIsolated` = assert, не dispatch. Sync-вызов `@MainActor` метода с background в Swift 5 может **не** попасть на main.

**Для кого.** Новичок → граница UI; middle → API и ловушки; senior → 6.2 default isolation vs явный атрибут.

Ниже — развёрнутый склад примеров. Living-урок не дублируем.

---

## Что такое MainActor

MainActor — **глобально уникальный** actor: одна shared-инстанция на процесс, задачи на main thread.

Идея из SE-0316 Global Actors. Упрощённо в stdlib:

```swift
@globalActor
final actor MainActor: GlobalActor {
    static let shared: MainActor
}
```

Везде, где стоит `@MainActor`, синхронизация идёт через `MainActor.shared` — взаимно исключающий доступ к помеченным объявлениям (как у обычного actor, но «сцена» = UI / main).

> MainActor ведёт себя как другие actors, с одним важным отличием: **все его задачи — на main thread**.

Свой global actor можно определить отдельно (см. статьи Antoine про Global Actors) — MainActor уже дан платформой.

---

## Нужен ли ещё `@MainActor` в Swift 6.2+?

С Swift 6.2 / Xcode 26+ в **новых** проектах часто включён **Default Actor Isolation**: код app target изолирован на MainActor, пока явно не opt-out.

| Режим проекта | Практический вопрос |
|---------------|---------------------|
| Default isolation on | Когда **снять** MainActor: `nonisolated`, `@concurrent`, тяжёлая работа |
| Старый / без default | Куда **повесить** `@MainActor`: UI types, UI-touching methods/properties |

Сам атрибут работает так же. Меняется только «кто пишет аннотацию» — ты или дефолт компилятора. Подробнее hop/nonsending: [Approachable note](Approachable-Concurrency-Thread-Hopping-nsvasilev.md).

---

## Куда можно повесить атрибут

### 1. Весь тип (типичный ViewModel)

```swift
@MainActor
final class HomeViewModel {
    var title: String = ""
    // все члены по умолчанию на MainActor
}
```

Ограничения наследования (из языка / статьи):

- класс без superclass — ок;
- superclass с **тем же** global actor — ок;
- superclass = `NSObject` — ок;
- subclass global-actor типа **обязан** быть на том же global actor.

`actor` **нельзя** пометить `@MainActor` — у actor уже своя isolation; конфликт. Нужен UI-мир → `@MainActor class`, не `actor`.

### 2. Отдельное свойство

```swift
final class HomeViewModel {
    @MainActor var images: [UIImage] = []
}
```

Читать/писать `images` можно только из MainActor-контекста (или через `await`). Удобно в MVVM/SwiftUI: redraw триггерится с main.

### 3. Отдельный метод

```swift
@MainActor
func updateViews() {
    // в concurrency-контексте вызов потребует hop на MainActor
}
```

Важно: гарантия «всегда main» для **синхронного** метода зависит от того, *откуда* его вызвали. В Swift 5 language mode легко обойти ожидания — см. раздел про ловушку ниже. Swift 6 mode ловит большинство таких случаев на компиляции.

### 4. Closure

```swift
func updateData(completion: @MainActor @escaping () -> Void) {
    Task {
        await someHeavyBackgroundOperation()
        await completion()
    }
}
```

Antoine советует в таких местах скорее переписать API на `async`, без completion — но паттерн `@MainActor` на closure валиден для legacy границ.

### 5. `nonisolated` — осознанный opt-out

На `@MainActor` типе методы без нужды в main лучше помечать `nonisolated`, чтобы не ждать main и не блокировать UI-очередь:

```swift
@MainActor
final class HomeViewModel {
    nonisolated func hashSeed() -> Int {
        // не ждёт MainActor; сам отвечает за thread-safety того, что трогает
        42
    }
}
```

---

## Прямой API: `MainActor.run`

```swift
extension MainActor {
    public static func run<T>(
        resultType: T.Type = T.self,
        body: @MainActor @Sendable () throws -> T
    ) async rethrows -> T
}
```

Пример hop после фона:

```swift
Task {
    await someHeavyBackgroundOperation()
    await MainActor.run {
        // UI updates
    }
}
```

Замена привычного `DispatchQueue.main.async { }`, но с async-границей. Antoine рекомендует **всё равно** маркировать UI-типы `@MainActor`: иначе кто-то забудет `run` и обновит UI с background.

---

## `MainActor.run` vs `Task { @MainActor in }`

Тонкая, но важная разница.

```swift
// Весь Task — на MainActor (включая всё до первого await внутри)
Task { @MainActor in
    imageView.image = image
}
```

```swift
// Фон → короткий hop только для closure
Task {
    let image = try await downloadImage() // не на MainActor
    await MainActor.run {
        imageView.image = image           // только этот кусок
    }
}
```

| Когда | Что выбрать |
|-------|-------------|
| Весь смысл Task — UI | `Task { @MainActor in … }` |
| Большая часть — фон, UI в конце | `await MainActor.run { … }` (или `@MainActor` метод после `await`) |

---

## `MainActor.assumeIsolated`

Когда **ты уверен**, что уже на main, а компилятор из sync/nonisolated контекста это не видит:

```swift
nonisolated func handleCallback() {
    MainActor.assumeIsolated {
        updateViews()
    }
}
```

Критично:

- `assumeIsolated` **не** диспатчит на main;
- если вызвали не с MainActor isolation → **trap** / остановка процесса;
- только для interop / legacy callback, где контракт «уже main» железный.

Для обучения default — hop через `await` / `@MainActor` Task, не `assumeIsolated`.

---

## Когда вешать атрибут (чеклист)

### Без Default Actor Isolation

Вешай `@MainActor` на то, что **трогает UI** или UI-наблюдаемое состояние:

- View / ViewModel / Presenter с привязкой к экрану;
- свойства, от которых SwiftUI/UIKit redraw;
- методы, которые мутируют UI.

Сеть внутри `@MainActor async` метода **не** держит main на время `await URLSession…` — suspend отпускает actor; hop обратно после resume только когда нужно продолжить isolated код:

```swift
@MainActor
func fetchImage(for url: URL) async throws -> UIImage {
    let (data, _) = try await URLSession.shared.data(from: url)
    guard let image = UIImage(data: data) else {
        throw ImageFetchingError.imageDecodingFailed
    }
    return image
}
```

Тяжёлый **sync** decode/zip на MainActor после resume — уже freeze. Выноси parse off MainActor.

### С Default Actor Isolation (6.2+)

Вопрос наоборот: что **не** должно блокировать main → `nonisolated` / `@concurrent` / отдельный actor / non-MainActor service.

---

## Ловушка: `@MainActor` ≠ всегда main для sync вызова

Миф новичка: «повесил атрибут — значит метод всегда на main».

Факт: **синхронный** вызов из non-isolated контекста в Swift 5 language mode может выполниться на **том же потоке, что и caller** — атрибут не «магически» перекидывает sync call.

Сценарий из статьи (упрощённо):

1. Работа уходит на background queue.
2. Оттуда синхронно вызывают `@MainActor` метод.
3. В Swift 5 это может скомпилироваться и бежать **не** на main → UI warning / crash.
4. Swift 6 language mode — большинство таких дыр закрывает на compile time.

Практика:

- миграция на Swift 6 language mode;
- вызывать UI-методы из async/`await` или явно hop;
- не строить длинные sync-цепочки «background → … → @MainActor sync».

Живая глава уже фиксирует родственную мысль: sync-ад на MainActor = freeze даже внутри `async`.

---

## Связка с главой и интервью

| Вопрос | Короткий ответ |
|--------|----------------|
| MainActor vs `DispatchQueue.main`? | Isolation в типах + compiler vs ручной hop |
| Можно `@MainActor` на `actor`? | Нет — своя isolation |
| `run` vs `Task { @MainActor }`? | Кусок hop vs весь Task на main |
| `assumeIsolated`? | Assert, не dispatch |
| Зачем ещё атрибут при 6.2? | Правила те же; default isolation ≠ «атрибут мёртв» |

Интервью-банк: [Interview-Pack](Interview-Pack.md). Маршрут: глава 8 [mainactor-and-ui](../mainactor-and-ui/).

---

## Типичные ошибки (сводка)

1. Весь networking layer сделать `@MainActor class` «чтобы проще» — тащишь лишнюю работу на UI world.
2. Тяжёлый sync parse после `await` всё ещё на MainActor.
3. `Task.detached` + UI update без hop.
4. `assumeIsolated` «на всякий случай» из callback с неизвестной очереди.
5. В Swift 5 верить sync `@MainActor` методу как гарантии main thread.
6. Путать «async» с «не блокирует UI».

---

## Source

- Статья: https://www.avanderlee.com/swift/mainactor-dispatch-main-thread/
- Соседние по курсу Antoine (продолжение): Actors, Global actors, nonisolated/isolated, Default Actor Isolation, Threads vs Tasks, Swift 6 migration.

## Gap vs Living chapter

Глава [mainactor-and-ui](../mainactor-and-ui/) — интуиция, hop-паттерн, интервью. Эта note — развёрнутые **API-примеры** (property/method/closure/`run`/`Task`/`assumeIsolated`) + Swift 5 pitfall + 6.2 default isolation из внешнего гайда.
