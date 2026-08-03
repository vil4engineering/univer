<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Почему isolation, а не «поток на объект»?

<p class="chapter-deck">
<a class="eu-term" href="../../../glossary/#glossary-actor">Actor</a> — не «выдели поток». Это <a class="eu-term" href="../../../glossary/#glossary-isolation">isolation</a>: состояние трогает один мир за раз, а на <code>await</code> дверь может впустить другую работу.
</p>

<p class="chapter-meta">≈ 15 мин · ★★★★★ · после Task</p>

<details>
<summary>Learning</summary>

| Prerequisites | [Shared state](../shared-state-and-races/) · [Tasks](../tasks-and-unstructured-work/) |
| Next | [MainActor / UI](../mainactor-and-ui/) |

</details>

---

## Интуиция

Один кабинет с одной дверью: внутри правят документы кабинета. Не «сотрудник навсегда приклеен к кабинету», а **правило входа**.

---

## Проблема

Shared mutable state ломается без правил. Lock — один ответ. Actor — другой: компилятор помогает держать границу, вместо ручного «не забудь lock».

Ошибка интервью: «actor = thread на объект».

---

## Как это работает

| Идея | Смысл |
|------|--------|
| Isolation | Код/состояние принадлежат домену; снаружи — через `await` |
| Сериализация | Входы в actor не пересекают мутацию состояния хаотично |
| Reentrancy | После `await` внутри actor другая работа может зайти — инварианты перепроверь |

Actors лечат **владение состоянием**, не заменяют модель concurrency целиком.

---

## Production

> Перед `class` + ручные очереди: **нужен явный владелец состояния?** Часто actor / MainActor яснее.

---

## Интервью

Actor vs queue · reentrancy · почему не thread-per-object · связь с data race.

---

## Лабораторная

[ActorsQueuesLocksInterview.playground](../ActorsQueuesLocksInterview.playground)

---

## Конспект

1. Isolation = правило доступа, не «свой поток».  
2. Actor сериализует доступ к своему состоянию.  
3. После await возможна reentrancy.  

**Дальше:** [MainActor и UI](../mainactor-and-ui/)

## Evidence

- [ ] Explained · Lab  

<details><summary>For contributors</summary>

`swift/concurrency/actors-and-isolation` · [DESIGN.md](DESIGN.md)

</details>
