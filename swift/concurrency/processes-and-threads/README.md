<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Зачем программе process и thread?

<p class="chapter-deck">
Concurrency уже нужна как идея. Process и thread — ответ операционной системы: <em>где</em> живёт программа и <em>кому</em> CPU отдаёт кванты времени.
</p>

<p class="chapter-meta">
≈ 16 мин · Interview ★★★★ · после «почему concurrency»
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [Почему concurrency](../why-concurrency-exists/) · гл.0 Execution Spine |
| **Next** | shared state / races (следующий unit) · [hub](../) |
| **Interview** | ★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 16 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Представь офисное здание и людей внутри.

**Process** — вся фирма в своём здании: свои комнаты, свои документы, своя охрана на входе. Чужая фирма в соседнем здании твои бумаги просто так не читает.

**Thread** — сотрудник внутри фирмы. Их может быть несколько. Все ходят по одним коридорам фирмы (общее адресное пространство), но в один момент каждый занят своим делом — или ждёт.

CPU — как лифт/время на совещании: OS решает, *кому* сейчас дать ход. Это не отменяет Execution Spine:

> задача → человек → алгоритм → программа → Compiler → Machine Code → CPU → действие в мире

Process/thread — про то, **как OS упаковывает программу**, которую CPU исполняет.

---

## Проблема

Глава «почему concurrency» сказала: одной жёсткой очереди дел мало.

Следующий вопрос: *что именно* OS даёт программе, чтобы дел могло быть несколько?

Если смешать уровни, получится каша на интервью:

- «concurrency = threads»  
- «process = thread»  
- «MainActor = main thread навсегда и везде»

Нужна чистая картинка: **контейнер программы** vs **единица исполнения внутри него**.

---

## История (коротко)

```text
Одна программа ≈ один поток мысли
  → OS: process изолирует программы друг от друга
  → внутри process появляются threads (несколько исполнителей на общие данные фирмы)
  → дальше люди изобретают очереди, operations, async/await — чтобы не жить на сырых threads
```

Сырой `Thread` на Apple-платформах всё ещё существует. Современный iOS-код чаще поднимается выше. Но без process/thread ты не поймёшь, *от чего* эти абстракции спасают.

---

## Как это работает

| | <a class="eu-term" href="../../../glossary/#glossary-process">Process</a> | <a class="eu-term" href="../../../glossary/#glossary-thread">Thread</a> |
|--|----------|--------|
| Что это | Экземпляр программы в OS: память, файлы, права | Единица планирования: «кому сейчас CPU» внутри process |
| Изоляция | Сильная между процессами | Слабая: threads одного process делят память |
| Зачем | Безопасность и учёт ресурсов | Параллель / переключение дел внутри одной программы |

Важные следствия:

1. **Два process** не делят память «просто так» — нужен IPC / другие механизмы.  
2. **Два thread одного process** легко портят общее состояние, если нет правил (это следующая глава).  
3. **Main thread** на iOS — привилегированная привычка платформы для UI: трогать UIKit/AppKit с него — правило мира Apple, не закон физики CPU.

Concurrency (организация дел) может использовать threads, но **не определяется** ими. Один thread тоже может «делать concurrency» через ожидание и переключение работы — см. прошлую главу.

---

## Внутри

Level 3 — дверь.

OS планировщик отдаёт CPU threads по политике приоритетов. Точные кванты и ядра — эвристика платформы; не учи наизусть цифры. Для инженера важнее: blocking на main thread убивает отзывчивость; «много threads» без дисциплины увеличивает гонки и контекстные переключения.

Глубже про RunLoop / GCD / structured tasks — позже по roadmap. Warehouse-линия эволюции: [Concurrency evolution note](../notes/Concurrency-Evolution-From-Threads-to-Modern-Swift.md) · [ConcurrencyEvolutionFromThreads.playground](../ConcurrencyEvolutionFromThreads.playground).

---

## Пример

Псевдокод идеи — без API-туризма:

```text
Process "MyApp"
  Thread main:    рисуй UI, принимай жесты
  Thread worker:  качай данные (ждёт сеть)
  общее:          модель, которую оба могут тронуть ← опасное место
```

Плохо: worker пишет в модель, main читает без правил.  
Хорошо (идея): договориться, *кто* владеет состоянием — очереди, actors, изоляция (следующие главы).

---

## Production

Привычка:

> Увидел «подвисает UI» — сначала спроси: **не держу ли я main thread** длинной работой или синхронным ожиданием?

Не начинай с «надо больше threads». Часто нужно *убрать работу с main*, а не размножить хаос.

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Process vs thread? | Изоляция памяти vs единица планирования |
| Почему UI на main? | Платформенное правило + отзывчивость |
| Concurrency = threads? | Нет |
| Зачем тогда threads? | Механизм OS под организацию работы |

**Ошибки:** путать process/thread; обещать «thread на каждый экран»; прыгать в GCD на первой фразе.

---

## Лабораторная

Теория покрыта. Практика async: в [ConcurrencyEvolutionFromThreads.playground](../ConcurrencyEvolutionFromThreads.playground) найди блок про process/thread и отметь в Evidence.

---

## Конспект

1. Process — здание программы в OS.  
2. Thread — сотрудник внутри; CPU планирует их.  
3. Threads одного process делят память → риск гонок.  
4. Main thread — мир UI на Apple; не блокируй его.  
5. Concurrency ≠ threads; threads — один механизм.  
6. Дальше — боль shared mutable state.

---

## Рефлексия

> **до:** «поток = concurrency»  
> **после:** process/thread — OS-упаковка; concurrency — организация дел

**Дальше:** почему общее изменяемое состояние ломается без правил (shared state / races) · пока [hub](../).

---

## Evidence

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise  

## Open questions

Где в твоём последнем баге «UI freeze» работа сидела на main thread — и как ты это доказал?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/processes-and-threads` |
| **Version** | v1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [why-concurrency-exists](../why-concurrency-exists/) |
| **Handoff roadmap** | [`.author/SWIFT_SHELF_HANDOFF.md`](../../../.author/SWIFT_SHELF_HANDOFF.md) §8b |

</details>
