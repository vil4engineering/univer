<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Зачем граница UI отдельным миром?

<p class="chapter-deck">
UI на Apple — отдельный мир. <a class="eu-term" href="../../../glossary/#glossary-mainactor">@MainActor</a> называет эту границу isolation, а не «просто main thread навсегда везде».
</p>

<p class="chapter-meta">≈ 12 мин · ★★★★★ · после actors</p>

<details>
<summary>Learning</summary>

| Prerequisites | [Actors](../actors-and-isolation/) · [suspension](../async-await-and-suspension/) |
| Next | [Cancellation](../cancellation-and-cooperation/) |

</details>

---

## Интуиция

Сцена театра: декорации трогает только сцена. Кулисы готовят реквизит. Если грузчики толкают декорации во время спектакля — хаос.

---

## Проблема

UIKit/AppKit исторически требуют UI-обновлений с main. Concurrency без границы = «иногда краш / warning / порча UI».

---

## Как это работает

| Идея | Смысл |
|------|--------|
| UI world | Обновления интерфейса — в main isolation |
| `@MainActor` | Тип/функция живут в этом мире |
| Hop | Тяжёлая работа off MainActor → назад для UI |

`@MainActor` ≠ «весь app однопоточный». Это **граница**, куда возвращаешься за UI.

---

## Production

> Тяжёлый zip/parse на MainActor? Вынеси. UI update — вернись.

---

## Интервью

Почему UI main · MainActor vs «просто DispatchQueue.main» · freeze при async UI.

---

## Конспект

1. UI — отдельный isolation world.  
2. MainActor маркирует границу.  
3. Sync-ад на MainActor = freeze.  

**Дальше:** [Cancellation / cooperation](../cancellation-and-cooperation/)

## Evidence

- [ ] Explained  

<details><summary>For contributors</summary>

`swift/concurrency/mainactor-and-ui` · [DESIGN.md](DESIGN.md)

</details>
