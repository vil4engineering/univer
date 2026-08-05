<p class="chapter-kicker">Computer Science · Foundations · Memory</p>

# Почему одного Stack оказалось недостаточно?

<p class="chapter-deck">
Stack идеально совпадает с жизнью функции.
Heap появился, когда данные должны пережить тот вызов, который их создал.
</p>

<p class="chapter-meta">
≈ 25 мин · Interview ★★★★ · Computer Science
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Computer Science |
| **Path** | Mode A · CS Foundations · Memory |
| **Prerequisites** | Функция · вызов · базовое ощущение «память процесса» |
| **Next** | Ownership / Reference Counting (пока gaps) · [Memory & ARC](../../swift/memory-arc/) как Swift-иллюстрация |
| **Interview** | ★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 25 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Представь склад с лентой: кладёшь коробку, когда заходишь в комнату, и забираешь её, когда выходишь. Пока все коробки живут ровно столько, сколько ты в комнате — лента идеальна.

Потом появляется нужда: коробка должна остаться в здании **после** того, как ты вышел из комнаты. Лента на это не рассчитана. Нужен другой склад — с другим правилом жизни вещей.

В памяти процесса лента — это <a class="eu-term" href="../../glossary/#glossary-stack">Stack</a>. Другой склад — <a class="eu-term" href="../../glossary/#glossary-heap">Heap</a>.

---

## История

Долгое время модели «память живёт вместе с вызовом функции» хватало: параметры, локальные переменные, адрес возврата — всё укладывается в <a class="eu-term" href="../../glossary/#glossary-stack-frame">Stack Frame</a>.

Боль пришла не из «классов» и не из Swift. Боль пришла из **срока жизни**: некоторые данные должны существовать дольше функции, которая их создала.

---

## Ментальная модель

| | |
|--|--|
| **Проблема** | Данные должны переживать функцию, которая их создала |
| **Аналогия** | Рабочий стол / конвейер смены (Stack) vs склад долгосрочного хранения (Heap) |
| **Инженерная модель** | Lifetime привязан к frame vs lifetime независимо от функции |
| **Swift / iOS** | `class` и многие buffers — Heap; value часто stack-friendly, но CoW/escaping → Heap |
| **Почему лучше** | Один Stack был бы быстрее, но не закрывал outliving-data; Heap дал нужный lifetime (ownership — следующий слой) |

---

## Проблема

Stack оптимизирован под данные, чьё <a class="eu-term" href="../../glossary/#glossary-lifetime">Lifetime</a> совпадает с выполнением функции.

- Память освобождается автоматически при завершении Stack Frame — это быстро и предсказуемо.
- Но данные, которые должны пережить `return`, на Stack положить нельзя: frame исчезнет вместе с ними.

Одного Stack оказалось недостаточно не потому, что «нужны объекты», а потому, что появилось новое требование к **времени жизни**.

---

## Решение

Появился Heap: область памяти, где lifetime объекта **не привязан** к жизненному циклу конкретной функции.

Важное различение:

| | Stack | Heap |
|--|-------|------|
| Главный критерий | Lifetime = выполнениеция / frame | Lifetime независим от создавшей функции |
| Не главный критерий | «Какой тип данных» | «Какой тип данных» |

Stack и Heap различаются **управлением lifetime**, а не «что можно хранить».

На Stack в frame обычно лежат параметры, локальные переменные, return address, сохранённые регистры и **ссылки** на объекты в Heap — не «только объекты» и не «всё подряд без правил».

Reference types стали практичны **потому что** есть Heap — не наоборот.

---

## Trade-offs

| Stack | Heap |
|-------|------|
| Очень быстрый · детерминированный lifetime | Гибкий lifetime · нужна отдельная модель ownership |
| Размер и глубина ограничены моделью вызовов | Медленнее allocate/free · сложнее рассуждать о владельце |

Heap решает **lifetime**. Heap **не** решает ownership. Ownership — следующая инженерная боль (Reference Counting → ARC и соседи).

---

## Production

В проде путаница почти всегда звучит так: «Heap хранит долгоживущие объекты» или «Heap — это про classes».

Точнее:

> Heap хранит объекты, чей lifetime **не зависит** от конкретной функции.

Иначе Senior-ответ скатывается в словарь типов вместо модели памяти.

См. также процесс и поток: <a class="eu-term" href="../../glossary/#glossary-process">Process</a>, <a class="eu-term" href="../../glossary/#glossary-thread">Thread</a> (у каждого потока свой Stack; Heap — на процесс).

---

## Ошибочные модели

| ❌ | ✅ |
|----|----|
| Stack — место, где лежат `struct` | Stack — модель управления lifetime данных относительно функции / frame |
| Heap — про classes / reference types | Heap — storage с lifetime независимо от создавшей функции |
| Heap хранит «долгоживущие» объекты | Heap хранит объекты, чей lifetime не привязан к конкретной функции |
| Memory Stack = ADT Stack (LIFO-коллекция) | Разные идеи; ADT — [отдельная note](../../algorithms/structures/notes/Stack-Under-The-Hood.md) |

---

## Swift

В Swift `class` живёт в Heap; локальные value часто удобны на Stack — но `struct` с кучей/CoW-буфером или escaping capture всё равно упирается в Heap. Это **иллюстрация** модели lifetime, не определение Heap.

Глубже про retain/release: [Memory & ARC](../../swift/memory-arc/). Фундамент здесь — why Heap exists.

Не путать memory Stack с ADT Stack (LIFO-структура данных): [Stack under the hood](../../algorithms/structures/notes/Stack-Under-The-Hood.md).

---

## Интервью

Короткий pack: [notes/Interview-Pack.md](notes/Interview-Pack.md).

**30–60 с:** Stack идеален, пока lifetime данных = выполнениеция. Когда данные должны пережить создавший вызов — нужен Heap: storage с lifetime независимо от функции. Ownership — следующий вопрос, не этот.

---

## Пример

Функция создаёт объект и возвращает на него ссылку вызывающему. Сам объект не может жить только в frame этой функции: frame исчезнет. Объект — в Heap; в frames остаются ссылки.

---

## Открытые вопросы

- [ ] Stack Pointer  
- [ ] Return Address (глубже)  
- [ ] Virtual Memory  
- [ ] Почему Heap медленнее (allocate path)  
- [ ] Fragmentation  
- [ ] malloc / free  
- [ ] Manual Memory Management → Leak → Double Free → Dangling Pointer  
- [x] Memory Leak / retain cycle (prep note) → [Memory Leak](../../swift/memory-arc/notes/Memory-Leak.md)  
- [ ] Reference Counting → <a class="eu-term" href="../../glossary/#glossary-arc">ARC</a>  

Ссылки только: не создавать пустые главы «на будущее».

---

## Рефлексия

**до:** Stack vs Heap казались разделением «короткие / длинные» или «value / class».  
**после:** критерий — lifetime относительно функции; Heap чинит lifetime, ownership — следующая задача.

---

## Дальше

Ownership и подсчёт ссылок — следующая боль после Heap. Пока смотри gaps выше и Swift-иллюстрацию [Memory & ARC](../../swift/memory-arc/). Карта CS-хаба: [Computer Science](../computer-science/).

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `fundamentals/why-heap-appeared` |
| **Status** | `learning` |
| **Version** | v1 |
| **Design** | Owner persist 2026-08-04 (session → chapter; Design stub deferred) |
| **Confidence** | — |
| **Assets** | Interview-Pack · glossary seeds |
| **Last updated** | 2026-08-04 |
| **Session** | [`.author/learning-sessions/2026-08-04-stack-heap.md`](../../.author/learning-sessions/2026-08-04-stack-heap.md) |

</details>
