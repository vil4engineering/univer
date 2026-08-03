# Stack under the hood (LIFO implementations)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `506750` |
| Related | [Structures](../README.md) |

---

🤔 **Что под капотом стека?**

Абстрактная структура данных по принципу **LIFO** (Last In, First Out) — «последний пришёл — первый вышел». Последний добавленный элемент извлекается первым. Реализации зависят от языка и задачи.

🟠 **Массивы**

Распространённый способ — массив. Элементы в массиве, индекс вершины (top) — отдельная переменная.

```swift
struct Stack<Element> {
    private var storage: [Element] = []

    mutating func push(_ element: Element) {
        storage.append(element)
    }

    mutating func pop() -> Element? {
        return storage.popLast()
    }

    func peek() -> Element? {
        return storage.last
    }

    var isEmpty: Bool {
        return storage.isEmpty
    }
}
```

🟠 **Связные списки**

Стек на linked list: каждый узел — данные и ссылка на следующий. Вершина — начало списка.

```swift
class Node<Element> {
    var value: Element
    var next: Node?

    init(value: Element) {
        self.value = value
    }
}

struct Stack<Element> {
    private var head: Node<Element>?

    mutating func push(_ element: Element) {
        let node = Node(value: element)
        node.next = head
        head = node
    }

    mutating func pop() -> Element? {
        let node = head
        head = head?.next
        return node?.value
    }

    func peek() -> Element? {
        return head?.value
    }

    var isEmpty: Bool {
        return head == nil
    }
}
```

🟠 **Стек вызовов**

Системный stack во время выполнения программы: адреса возврата, параметры функций, локальные переменные и прочие данные для управления выполнением.
