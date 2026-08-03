<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Почему отмена кооперативная?

<p class="chapter-deck">
Отмена в Swift Concurrency — не «убить поток». Это сигнал: задача <em>должна заметить</em> и остановиться сама. Иначе «cancel» — иллюзия.
</p>

<p class="chapter-meta">≈ 14 мин · ★★★★★ · после MainActor</p>

<details>
<summary>Learning</summary>

| Prerequisites | [Structured](../structured-concurrency/) · [Tasks](../tasks-and-unstructured-work/) |
| Next | [hub](../) · later: Sendable / testing (parking) |
| Related | [async-defer](../../async-defer/) — cleanup ≠ cancel |

</details>

---

## Интуиция

Пожарная тревога в офисе: сирена = сигнал. Люди **сами** выходят. Никто не телепортирует их на улицу. Кто заткнул уши — остаётся внутри.

---

## Проблема

Хочется «останови всё» при dismiss. Если рантайм просто убьёт исполнение mid-write — порча состояния. Поэтому модель: **cooperative** — проверь `Task.isCancelled` / `checkCancellation`, выйди чисто.

Cleanup (`defer`, close session) — про lifetime ресурса. Cancellation handler — про *реакцию на сигнал*. Не путай: см. [async-defer](../../async-defer/).

---

## Как это работает

| | |
|--|--|
| Cancel signal | Пометить дерево задач (structured — вниз) |
| Cooperation | Код периодически проверяет и выходит |
| Не cancel | Сам по себе `defer` не отменяет сеть |

```text
cancel parent → children marked
child work: check → stop / throw CancellationError → cleanup
```

---

## Production

> На dismiss: **cancel Task handle** и убедись, что hot loop / network path *смотрит* на cancellation.

---

## Интервью

Почему cooperative · cancel ≠ kill · structured propagation · cleanup vs cancel.

---

## Лабораторная

[StructuredConcurrencyLab](../StructuredConcurrencyLab.playground) · [async-defer](../../async-defer/)

---

## Конспект

1. Cancel = сигнал, не kill.  
2. Код должен сотрудничать.  
3. Structured несёт отмену вниз.  
4. Cleanup ≠ cancellation primitive.  

**Дальше:** [Concurrency hub](../) · Final polish (handoff §10) после закрытия theory chain.

## Evidence

- [ ] Explained · Lab  

<details><summary>For contributors</summary>

`swift/concurrency/cancellation-and-cooperation` · [DESIGN.md](DESIGN.md)

</details>
