# Interview pack — Почему одного Stack оказалось недостаточно?

Projection of [`../README.md`](../README.md). Short answers only.

---

## Q1 — Почему одного Stack оказалось недостаточно? Почему появился Heap?

**Expected time:** 30–60 sec

**Short:** Stack идеален для данных, чей lifetime совпадает с выполнением функции: frame исчез — память освободилась, это быстро и детерминированно. Когда данные должны пережить создавшую их функцию, нужна другая область — Heap: lifetime больше не привязан к конкретному вызову.

**Senior notes:**

- Различие Stack/Heap — про **lifetime management**, не про «какие типы можно хранить».
- Reference types стали возможны потому что есть Heap — не наоборот.
- Heap решает lifetime; ownership — следующая боль (refcount / ARC).

**Common mistakes:**

- «Heap хранит долгоживущие объекты» (размыто) → лучше: lifetime **независим от конкретной функции**.
- «Heap — это про classes / reference types» как определение.
- Путать memory Stack с ADT Stack (LIFO-коллекция).

---

## Follow-ups

- Почему Stack быстрее Heap?
- Почему нельзя сделать Stack огромным?
- Что хранится в Stack Frame?
- Почему Heap появился раньше ARC?
- Почему объект класса живёт в Heap?
- Может ли `struct` оказаться в Heap?
- Кто владеет объектом в Heap после `return`? (мост к ownership)

---

## Canonical

[`../README.md`](../README.md) · Glossary: Stack · Stack Frame · Heap · Lifetime
