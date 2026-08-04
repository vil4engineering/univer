# Почему нельзя сделать все ссылки `weak`

Шпаргалка · junior mental model. Related: [Memory & ARC](../README.md) · glossary [weak](../../../glossary/README.md#glossary-weak) · [ARC](../../../glossary/README.md#glossary-arc) · [retain cycle](../../../glossary/README.md#glossary-retain-cycle) · playground [ARCAdvanced](../ARCAdvanced.playground).

---

## Вопрос

В чём проблема, если **все** переменные в коде сделать `weak`?

## Короткий ответ

`weak` **не владеет** объектом. Если нигде нет **strong**-ссылки, retain count = 0 → ARC сразу вызывает `deinit` → все `weak` становятся `nil`. Объекты «живут», только пока ими кто-то владеет.

`weak` — не способ «сэкономить память». Это способ сказать: *я смотрю на объект, но не отвечаю за его жизнь*.

## Как работает `weak`

| Факт | Смысл |
|------|--------|
| Не увеличивает strong retain count | Не держит объект в памяти |
| Только для **class** (reference type) | На `String` / `struct` / `Int` — compile error |
| Всегда `Optional` | Объект может исчезнуть в любой момент → `nil` |
| Типичные роли | back-link, `delegate`, `[weak self]` в closure |

```swift
class Person {
    weak var name: String? // ❌ value type — weak нельзя
}
```

## Пример: владелец + weak назад (правильно)

```swift
class Person {
    var car: Car?           // strong — Person владеет Car
}

class Car {
    weak var owner: Person? // weak — Car не владеет Person (нет цикла)
}

var person: Person? = Person()
person?.car = Car()
person?.car?.owner = person

print(person?.car?.owner != nil) // true — person ещё жив (strong var)
```

Здесь `owner` weak **не** убивает `Person`: его держит `var person`.

## Пример: никто не владеет (ломается)

```swift
weak var person: Person? = Person()
// временный strong от правой части Person() кончается сразу
// → deinit → person == nil
print(person) // nil
```

Или если **оба** конца weak — граф владения пустой, объекты не живут.

## Когда `weak` полезен

1. **Retain cycle** — взаимные strong (часто `delegate`, parent ↔ child, `self` в `@escaping` closure).
2. **«Я не владею»** — ячейка не владеет VC; child не продлевает жизнь parent.

```swift
protocol SomeDelegate: AnyObject {
    func doSomething()
}

class ViewController {
    weak var delegate: SomeDelegate? // ✅ разрыв цикла owner ↔ delegate
}
```

## Правило на пальцах

- **Strong** = кто владеет жизнью объекта (нужен хотя бы один путь владения).
- **Weak** = безопасный взгляд без владения (и без цикла).
- **Unowned** = тоже без retain, но не Optional — только если lifetime другого объекта **гарантированно** не короче (иначе crash). См. glossary [unowned](../../../glossary/README.md#glossary-unowned).

## Interview one-liner (EN)

> If every reference were `weak`, nothing would keep the object alive — ARC would deallocate it immediately. Use `strong` for ownership and `weak` only for non-owning links (delegates, back-references, `[weak self]`).
