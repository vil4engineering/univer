# Чем опасна утечка памяти?

Шпаргалка · prep → Library. Related: [Memory & ARC](../README.md) · [Why Heap appeared](../../../fundamentals/why-heap-appeared/) · glossary [Memory Leak](../../../glossary/#glossary-memory-leak) · [retain cycle](../../../glossary/#glossary-retain-cycle) · tools [Debug & Instruments](../../../quality/debug/) · playground [ARCAdvanced](../ARCAdvanced.playground).

---

## Интуиция

Склад (Heap) выдал коробки. Ты забыл, что они твои, и ключ от склада потерял — но коробки всё ещё занимают место. Новые поставки начинают не влезать.

В приложении то же: память выделена, программа ею уже не пользуется, а освободить некому.

---

## История / проблема

После появления Heap понадобилось **ownership**: кто решает, когда объект можно убрать. Вручную (`malloc`/`free`) ошибались → Leak, Double Free, Dangling Pointer. <a class="eu-term" href="../../../glossary/#glossary-arc">ARC</a> автоматизировал retain/release, но **цикл strong-ссылок** снова оставляет объекты «занятыми навсегда».

---

## Ментальная модель

| | |
|--|--|
| **Проблема** | Память занята без пользы → растёт footprint, jetsam, деградация |
| **Аналогия** | Коробки на складе без владельца и без возврата |
| **Инженерная модель** | Lifetime не закончился, хотя логически объект мёртв (часто: retain cycle) |
| **Swift / iOS** | `class` + strong ↔ strong; `@escaping` без `[weak self]`; забытый timer/observer |
| **Почему важно** | Не «теория»: на устройстве память конечна |

---

## Чем опасна утечка

<a class="eu-term" href="../../../glossary/#glossary-memory-leak">Memory Leak</a> — память остаётся выделенной, программой уже не используется и не освобождается.

Последствия:

- растёт Resident Memory / dirty size;
- система убивает процесс (jetsam) под давлением;
- батарея и тепло — лишняя работа GC нет, но кэш/граф объектов живёт зря;
- баги «экран открыли N раз — всё тормозит».

В мире ARC типичный механизм этой боли — <a class="eu-term" href="../../../glossary/#glossary-retain-cycle">retain cycle</a>. Не единственный (брошенный кэш, не `invalidate` у `Timer` / display link), но главный interview-кейс.

---

## Как выглядит цикл (Swift)

```swift
final class Person {
    var pet: Pet?
    deinit { print("Person deinit") }
}

final class Pet {
    var owner: Person?
    deinit { print("Pet deinit") }
}

var person: Person? = Person()
var pet: Pet? = Pet()
person?.pet = pet
pet?.owner = person
person = nil
pet = nil
```

Оба объекта держат друг друга strong → refcount не падает до нуля → `deinit` не вызывается.

---

## Как рвать цикл

### `weak` — когда другая сторона может исчезнуть

```swift
final class Pet {
    weak var owner: Person?
    deinit { print("Pet deinit") }
}
```

`weak` не увеличивает retain count; после `deinit` владельца ссылка становится `nil`.

### `unowned` — когда lifetime другой стороны гарантированно не короче

```swift
final class Car {
    unowned let owner: Owner
    init(owner: Owner) { self.owner = owner }
}
```

Не `Optional`. Если гарантия врёт — crash. Не «замена weak везде».

### Capture list в `@escaping` closure

```swift
final class ViewController {
    var onDone: (() -> Void)?

    func setup() {
        onDone = { [weak self] in
            guard let self else { return }
            print(ObjectIdentifier(self))
        }
    }

    deinit { print("ViewController deinit") }
}
```

Без `[weak self]` (или явной модели владения) closure часто держит `self`, а `self` держит closure.

---

## Как искать

Не дублируем Instruments-главу — канон инструментов: [Debug & Instruments](../../../quality/debug/).

Кратко:

| Приём | Зачем |
|-------|--------|
| `deinit` + лог | Не вызвали → объект жив |
| Xcode Memory Graph | Граф strong-рёбер, cycles |
| Instruments · Leaks / Allocations | Рост кучи, утечки malloc |
| Повтор open/close экрана | Классический retain в VC |

---

## Ошибочные модели

| ❌ | ✅ |
|----|----|
| ARC «сам освобождает память» как волшебство | ARC управляет **reference counting**; цикл strong → zero никогда не наступает |
| Утечка = только забыли `free` | В Swift/iOS чаще цикл ownership / брошенный владелец |
| Все ссылки сделать `weak` | Без strong-владельца объект умирает сразу — [Why-Not-All-Weak](Why-Not-All-Weak.md) |
| `unowned` безопаснее `weak` | `unowned` строже по lifetime; ошибка → crash |

---

## Интервью (30–60 с)

**Q:** Чем опасна утечка памяти? Как её ловите в iOS?

**Short:** Память занята без пользы → рост footprint и риск jetsam. В ARC типичный кейс — retain cycle (`strong`↔`strong` или escaping closure). Рвём `weak` / `unowned` / `[weak self]`. Ищем через `deinit`, Memory Graph, Instruments Leaks.

**Follow-ups:** weak vs unowned · почему не все weak · timer/NotificationCenter · side table (Senior).

---

## Дальше

Фундамент lifetime: [Why Heap appeared](../../../fundamentals/why-heap-appeared/). Ownership / ARC shelf: [Memory & ARC](../README.md).
