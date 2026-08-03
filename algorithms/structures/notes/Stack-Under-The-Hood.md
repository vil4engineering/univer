# Stack under the hood (LIFO implementations)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `506750` |
| Related | [Structures](../README.md) |

---

🤔 Что под капотом стэка?

Это абстрактная структура данных, работающая по принципу LIFO (Last In, First Out), что означает "последний пришёл — первый вышел". Это значит, что последний добавленный элемент будет первым при извлечении из стека. Под капотом реализации стека могут быть разные, и они зависят от конкретного языка программирования и задач, которые необходимо решить. 

🟠Массивы
Один из самых распространённых способов реализации стека — это использование массива. В такой реализации элементы стека хранятся в массиве, и индекс последнего элемента (вершина стека) отслеживается отдельной переменной.
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

🟠Связные списки
Стек можно реализовать с использованием связных списков, где каждый элемент списка содержит данные и ссылку на следующий элемент в стеке. Вершина стека в такой реализации — это начало связного списка.
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

🟠Стек вызовов
Это системный стек, который используется во время выполнения программы для хранения информации о вызовах функций/методов. Он хранит адреса возврата, параметры функций, локальные переменные и другие данные, необходимые для управле
