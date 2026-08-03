<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Когда `Task { }` — инструмент, а когда дырка lifetime?

<p class="chapter-deck">
<a class="eu-term" href="../../../glossary/#glossary-task">Task</a> — единица работы. Unstructured <code>Task { }</code> удобен, но легко становится сиротой: экран умер, работа живёт.
</p>

<p class="chapter-meta">≈ 14 мин · ★★★★★ · после suspension</p>

<details>
<summary>Learning</summary>

| Prerequisites | [async/await · suspension](../async-await-and-suspension/) · [structured](../structured-concurrency/) |
| Next | [Actors / isolation](../actors-and-isolation/) |

</details>

---

## Интуиция

Structured scope — семейная поездка.  
`Task { }` с sync-улицы — иногда вызвать такси *отдельно*: полезно, но водитель может везти пассажира после того, как ты уже ушёл.

---

## Проблема

Нужно стартовать работу из места без async-контекста (кнопка, `init`, delegate). `Task { }` — мост. Цена: **lifetime не привязан** к scope экрана автоматически.

---

## Как это работает

| | Structured | Unstructured `Task { }` |
|--|------------|-------------------------|
| Lifetime | Привязан к parent scope | Может пережить создателя |
| Cancel | Вниз по дереву | Сам храни `Task` / cancel |
| Когда ок | Default внутри async scope | Явный мост + владелец |

Правило: unstructured — только с ответом «кто отменит и кто ждёт результат».

---

## Production

> Перед `Task { }` из View: **хранишь ли ты handle и отменяешь на disappear?**

---

## Интервью

Unstructured vs structured · зачем `Task.detached` опасно как default · cancel на dismiss.

---

## Лабораторная

[TaskVersatility.playground](../TaskVersatility.playground) · Evidence async.

---

## Конспект

1. Task = единица работы.  
2. Unstructured легко становится сиротой.  
3. Default — structured; unstructured — с владельцем.  

**Дальше:** [Actors и isolation](../actors-and-isolation/)

## Evidence

- [ ] Explained · Lab  

<details><summary>For contributors</summary>

`swift/concurrency/tasks-and-unstructured-work` · [DESIGN.md](DESIGN.md)

</details>
