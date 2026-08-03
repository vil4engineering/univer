<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Почему общее изменяемое состояние ломается без правил?

<p class="chapter-deck">
Threads одного process делят память. Без договора «кто когда пишет» программа перестаёт быть однозначной — даже если каждый кусок кода «локально логичен».
</p>

<p class="chapter-meta">
≈ 16 мин · Interview ★★★★★ · после process/thread
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [Process и thread](../processes-and-threads/) · [Почему concurrency](../why-concurrency-exists/) |
| **Next** | [GCD / callback era](../gcd-and-callback-era/) (следующий unit) · [hub](../) |
| **Interview** | ★★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 16 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Два сотрудника в одной фирме правят одну и ту же таблицу Excel на общем диске.

Один пишет сумму. Другой в тот же миг читает и дописывает строку. Никто не «глупый». Просто нет правила: *кто сейчас владеет таблицей*.

В process то же самое: threads делят адресное пространство. Общее **изменяемое** состояние без правил — лотерея.

> Боль не в «много threads». Боль в **shared mutable state** без договора.

---

## Проблема

После главы про process/thread понятно: внутри одного process память общая.

Значит возможны:

- два исполнения читают/пишут одну переменную / объект;
- компилятор и CPU переупорядочивают операции (ты этого не видишь в исходнике);
- баг проявляется «иногда», на устройстве, под нагрузкой.

Это не «Swift глючит». Это цена общей памяти без дисциплины.

На Execution Spine это всё ещё программа для CPU — только теперь несколько линий исполнения спорят за одни и те же байты смысла.

---

## История (коротко)

```text
Один thread → состояние «мое»
  → несколько threads → нужна синхронизация
  → locks / queues / serial ownership
  → позже: isolation (actors), Sendable, structured lifetime
```

Люди сначала ставили замки на двери. Потом поняли: меньше общих изменяемых комнат — меньше замков. Современный Swift толкает ко второму, но боль остаётся той же.

---

## Как это работает

| Термин | Смысл здесь |
|--------|-------------|
| Shared state | Данные, к которым могут добраться ≥2 исполнения |
| Mutable | Состояние можно менять |
| <a class="eu-term" href="../../../glossary/#glossary-data-race">Data race</a> | Конфликтный доступ к shared mutable state без синхронизации |

Упрощённая картинка гонки:

```text
Thread A:  read x → … → write x
Thread B:       read x → write x
                 overlapping without a rule → смысл x не определён
```

**Не путать:**

- **Data race** — проблема памяти/доступа.  
- **Race condition** (шире) — логическая гонка «кто первый»; бывает и без data race.  
- **Deadlock** — все ждут друг друга; другая болезнь.

Способы договориться (идея, не каталог API):

1. **Не делить** — у каждого своя копия / value / сообщение.  
2. **Сериализовать** — один мир за раз (lock, serial queue, позже actor).  
3. **Сделать неизменяемым** после публикации.

Какой механизм выбрать — следующие главы. Здесь важно *узнать боль*.

---

## Внутри

Level 3 — дверь.

Thread Sanitizer ловит многие data races в debug. Это инструмент доказательства, не замена модели. Цифры «насколько медленнее lock» — измеряй; не учи фольклор.

Actors / `Sendable` / strict concurrency — ответы на эту главу; их why — дальше по roadmap.

---

## Пример

Псевдокод без API:

```text
var counter = 0   // shared mutable

Thread A: counter = counter + 1
Thread B: counter = counter + 1

Ожидание: 2
Реальность без правил: 1 или 2 — зависит от чередования
```

Исправление на уровне идеи: либо один владелец counter, либо явная сериализация обновлений.

---

## Production

Привычка:

> Увидел «иногда» и shared `class` / global — спроси: **кто владеет этим состоянием, и кто имеет право писать?**

Не начинай с «добавь lock everywhere». Сначала уменьши shared mutation.

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Что такое data race? | Shared mutable + нет синхронизации |
| Почему опасно на iOS? | UI + background; «иногда» |
| Lock всегда спасает? | Цена, deadlock, всё ещё нужна модель владения |
| Чем поможет value type? | Меньше случайного sharing |

**Ошибки:** data race = любой баг concurrency; «просто возьми atomic» без модели.

---

## Лабораторная

Теория покрыта. Практика async: [ActorsQueuesLocksInterview.playground](../ActorsQueuesLocksInterview.playground) — сравни «общий счётчик» vs сериализация; отметь в Evidence.

---

## Конспект

1. Threads одного process делят память.  
2. Shared mutable state без правил → data race.  
3. Data race ≠ любой race condition ≠ deadlock.  
4. Лечи владением и сериализацией, не «ещё threads».  
5. Дальше — очереди/callback era как исторический ответ.

---

## Рефлексия

> **до:** «надо синхронизировать всё»  
> **после:** сначала кто владеет состоянием; потом механизм

**Дальше:** [Что дали очереди и callback — и почему этого мало?](../gcd-and-callback-era/)

---

## Evidence

Теория этой главы покрыта (v1). Практика / Path write-back — асинхронно.

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise


## Open questions

Какой shared `class` в твоём коде сейчас «общий для всех» без явного владельца?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/shared-state-and-races` |
| **Version** | v1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [processes-and-threads](../processes-and-threads/) |
| **Handoff** | [§8b](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
