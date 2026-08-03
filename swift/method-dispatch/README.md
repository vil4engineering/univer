<p class="chapter-kicker">Mobile Systems · Swift · runtime</p>

# Почему один вызов метода в Swift может идти разными путями?

<p class="chapter-deck">
Когда ты пишешь <code>x.foo()</code>, машине всё равно нужно понять: <em>какой</em> код исполнить.
Swift выбирает стратегию по типу полиморфизма — не «магией OOP», а разными таблицами и моментами решения.
</p>

<p class="chapter-meta">
≈ 18 мин · Interview ★★★★ · после входа в Swift
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift |
| **Prerequisites** | [Зачем Swift](../what-is-swift/) · class / struct на базовом уровне |
| **Next** | [Protocols](../protocols/) |
| **Interview** | ★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 18 min |
| **Levels** | 1–2 (L3 — лёгкий мост) |

</details>

---

## Интуиция

Представь ресепшен отеля. Ты говоришь: «Позовите Иванова». Имя одно. Но за стойкой всё равно нужно понять: *какого* Иванова и в какую комнату звонить.

Вызов метода — то же самое. Имя `printMessage` на экране одно. Адрес кода — нет.

Иногда компилятор уже знает комнату (прямой вызов).  
Иногда у объекта есть таблица «какая реализация у этого класса».  
Иногда таблица привязана к протоколу.  
Иногда решение уходит в Objective-C runtime — как в старом отеле с другой АТС.

> Диспетчеризация отвечает не на «что такое метод», а на «какой код побежит».

---

## Проблема

Строка `instance.printMessage()` *выглядит* одинаково. Но за ней разные миры:

- у value type часто одна известная реализация;
- у class может быть `override` в подклассе;
- у протокола как типа (`any P`) конкретный тип спрятан до runtime;
- у Cocoa / KVO метод может резолвиться через Objective-C.

Если бы у Swift был только один способ, пришлось бы либо запретить половину языка, либо всегда платить за самый дорогой путь.

Сначала держи картинку: одно имя на экране — несколько возможных «дверей» к коду. Имена стратегий ниже — ярлыки этих дверей, не словарь ради словаря.

Поэтому стратегий несколько. Их обычно называют так:

| Стратегия | Коротко |
|-----------|---------|
| <a class="eu-term" href="../../glossary/#glossary-static-dispatch">Static Dispatch</a> | адрес известен на этапе компиляции |
| <a class="eu-term" href="../../glossary/#glossary-vtable">Vtable</a> | таблица методов класса |
| <a class="eu-term" href="../../glossary/#glossary-witness-table">Witness Table</a> | таблица соответствия протоколу |
| <a class="eu-term" href="../../glossary/#glossary-dynamic-dispatch">Dynamic Dispatch</a> (Obj-C) | `objc_msgSend` / Objective-C runtime |

---

## История

Коротко, как менялся *выбор реализации*:

```text
C: прямой вызов (адрес известен)
  → C++ / классическое OOP: vtable для виртуальных методов
  → Objective-C: почти всё через message send (гибко, дороже)
  → Swift: разные стратегии под разные формы полиморфизма
```

Swift не «придумал диспетчеризацию». Он разделил то, что в Objective-C часто шло одним дорогим каналом: где можно — прямой вызов и предсказуемые таблицы; где нужен Cocoa — мост в Obj-C runtime.

Идея та же, что на Execution Spine: <a class="eu-term" href="../../glossary/#glossary-compiler">Compiler</a> и runtime готовят путь к коду, который исполнит CPU. Меняется только *как* выбирают путь.

---

## Как это работает

### 1. Static Dispatch

Компилятор знает точный адрес. В runtime нет поиска по таблице.

Типично: `struct` / `enum`, `final` class или `final` метод, часто `private`, generics после specialization.

```swift
struct Counter {
    func bump() { print("bump") }
}

let c = Counter()
c.bump() // адрес известен на compile time
```

### 2. Vtable Dispatch

У class в metadata есть таблица указателей на методы. По *динамическому* типу объекта выбирается реализация — даже если переменная объявлена как базовый класс.

```swift
class Animal {
    func speak() { print("…") }
}

class Dog: Animal {
    override func speak() { print("woof") }
}

let a: Animal = Dog()
a.speak() // через vtable → Dog.speak
```

### 3. Witness Table Dispatch

Когда тип спрятан за протоколом как existential (`any P` / старый `P` как тип), у значения есть контейнер и **witness table**: «вот как *этот* тип выполняет требования протокола».

```swift
protocol Speakable {
    func speak()
}

struct Cat: Speakable {
    func speak() { print("meow") }
}

let s: any Speakable = Cat()
s.speak() // через witness table
```

Важный нюанс: если протокол стоит в **generic-ограничении** (`func f<T: Speakable>(_ x: T)`), после specialization вызов часто становится **static**, а не witness. Existential и generic — разные истории.

### 4. Dynamic Dispatch (Objective-C)

Метод резолвится через Objective-C runtime (`objc_msgSend`). Нужен для `@objc`, `dynamic`, KVO, method swizzling, части UIKit API.

```swift
import Foundation

class Bell: NSObject {
    @objc dynamic func ring() {
        print("ding")
    }
}

Bell().ring() // Obj-C runtime
```

Здесь «dynamic» — не синоним «любой runtime». Vtable и witness тоже решают в runtime, но это механизмы Swift. **Dynamic** в этой четвёрке почти всегда значит Obj-C message send.

### Карта выбора

```mermaid
flowchart TD
  call["Вызов x.foo()"] --> known{"Конкретный тип<br/>известен компилятору?"}
  known -->|да| static["Static Dispatch"]
  known -->|нет| kind{"Какой полиморфизм?"}
  kind -->|class + override| vt["Vtable"]
  kind -->|existential protocol| wt["Witness Table"]
  kind -->|@objc / dynamic| objc["Obj-C Dynamic"]
```

| Стратегия | Когда решать | Типичный кейс | Грубая стоимость (эвристика) |
|-----------|--------------|---------------|------------------------------|
| Static | compile time | struct, final, specialized generic | ниже |
| Vtable | runtime | class hierarchy | средняя |
| Witness | runtime | `any P` | средняя |
| Obj-C dynamic | runtime | `@objc dynamic`, KVO | выше |

Колонка стоимости — **грубая эвристика для интервью**, не бенчмарк и не обещание рантайма. Измеряй горячий путь, если решение зависит от цифр.

Оптимизации (`final`, Whole Module Optimization, известный конкретный тип) *могут* **devirtualize** vtable-вызов обратно в static — это поведение компилятора/режима сборки, не железный закон. Поэтому «класс = всегда vtable» — упрощение для интервью.

---

## Внутри

Level 3 здесь короткий мост, не отдельный курс по SIL.

Простыми словами: у объекта class есть «телефонная книга» методов (vtable). У значения за протоколом (`any P`) — контейнер плюс таблица «как *этот* тип выполняет контракт» (witness table). Отдельно от этого — правила копирования/уничтожения значения (value witnesses): не путай с выбором *какой* метод вызвать.

- У class metadata несёт vtable.  
- У existential — контейнер значения + witness table (+ value witnesses для копирования/уничтожения).  
- Stack vs heap отвечают на *где лежит значение*; dispatch — на *какую функцию вызвать*. Это разные оси (см. также Memory & ARC / layout).

Глубже в SIL / LLVM — позже, когда заработан L3 по runtime. Здесь достаточно ментальной модели «четыре стратегии».

---

## Пример

Одна идея — четыре формы. Сравни не синтаксис, а *как выбирается* реализация.

| Форма | Dispatch |
|-------|----------|
| `struct` + прямой вызов | Static |
| `Base` / `Sub` + `override` | Vtable |
| `any Proto` | Witness |
| `NSObject` + `@objc dynamic` | Obj-C dynamic |

Мини-эксперимент: возьми сниппет выше с `Animal` / `Dog`. Поменяй объявление на `let a = Dog()` (конкретный тип). Подумай: компилятор *может* упростить путь. Потом верни `let a: Animal = Dog()` — снова явный полиморфизм через vtable.

---

## Production

Одна инженерная привычка, не каталог багов:

> Перед тем как тащить `any Protocol` в горячий путь или «на всякий случай» оставлять открытый class API, спроси: **нужен ли здесь полиморфизм — и какой?**

- Нужна одна известная реализация → struct / `final` / конкретный тип.  
- Нужно наследование поведения class → vtable осознанно.  
- Нужен контракт без общего предка → protocol; в API предпочитай generic/`some`, если existential не обязателен.  
- Нужны KVO / Obj-C hooks → `@objc dynamic` осознанно, не «потому что так в туториале».

---

## Интервью

**Базовый вопрос:** Какие виды method dispatch есть в Swift?

**Сильный ответ (скелет):** Static · Vtable · Witness table · Obj-C dynamic. Дальше — *когда какой* и чем «runtime» vtable/witness отличается от Obj-C `dynamic`.

**Follow-ups, на которые смотрят:**

- Почему у struct обычно static?  
- Что меняет `final`?  
- Почему `any P` и `T: P` могут диспетчеризоваться по-разному?  
- Зачем `@objc dynamic`, если уже есть vtable?

**Типичные ошибки:**

- назвать любой runtime-вызов «dynamic»;  
- сказать, что протоколы «всегда» witness (забыв generics);  
- смешать stack/heap с dispatch.

---

## Лабораторная

**Миссия:** на бумаге или в playground отметь у шести вызовов вид диспетчеризации.

1. Метод `struct`.  
2. `override` через переменную базового class.  
3. Тот же `override`, но переменная конкретного `final` subclass.  
4. Вызов через `any P`.  
5. Вызов `func f<T: P>(_ x: T)` внутри тела `f`.  
6. `@objc dynamic` у наследника `NSObject`.

Пока отдельного playground в теме нет — достаточно Xcode Playground или файла рядом с главой. Open question: зафиксировать шесть ответов и спорные места (особенно п.3 и п.5) в чате / Evidence.

---

## Конспект

- Вызов метода — это выбор реализации, а не просто «синтаксис точки».  
- В Swift обычно четыре стратегии: static, vtable, witness table, Obj-C dynamic.  
- Static — адрес на compile time; типично value types и final.  
- Vtable — полиморфизм class / override.  
- Witness table — existential протокола; generic constraint часто уходит в static.  
- Obj-C dynamic — message send; нужен для Cocoa-мостов и KVO.  
- «Runtime» ≠ автоматически «dynamic» в смысле Objective-C.  
- Production-привычка: не платить за полиморфизм, который не нужен.

---

## Рефлексия

> Что изменилось в твоей картине: `x.foo()` — это всегда «динамический вызов», или теперь ты сначала спрашиваешь, *какой* полиморфизм здесь вообще есть?

---

## Дальше

**Дальше:** [Protocols](../protocols/) — контракт «что умеет тип», без которого witness table не из чего строить.

<details>
<summary>Engineering · авторы</summary>

| | |
|--|--|
| **Topic id** | `swift/method-dispatch` |
| **Status** | `learning` |
| **Version** | v1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Review** | pending dual-pass |
| **Confidence** | — /5 |
| **Assets** | diagram in-page · lab stub · glossary seeds |
| **Last updated** | 2026-07-31 |

</details>
