<p class="chapter-kicker">Mobile Systems · Swift · Concurrency</p>

# Как жить с concurrency в проде и мигрировать с GCD?

<p class="chapter-deck">
Границы UI/domain, phased migration, DoD без «всё сразу на async» — production это слои, не big bang rewrite.
</p>

<p class="chapter-meta">
≈ 15 мин · Interview ★★★★ · гл.12 M03 · §D · capstone
</p>

<details>
<summary>Learning · маршрут и связи</summary>

| | |
|--|--|
| **Faculty** | Mobile Systems · Swift Concurrency |
| **Prerequisites** | [Testing concurrent systems](../testing-concurrent-systems/) |
| **Next** | [Concurrency hub](../) · notes / labs |
| **Interview** | ★★★★ |
| **Difficulty** | Medium |
| **Time** | ≈ 15 min |
| **Levels** | 1–2 |

</details>

---

## Интуиция

Теория M03 — actors, MainActor, Sendable, cancel, тесты. Production — **где** это живёт в приложении и **как** не утонуть в миграции с [GCD era](../gcd-and-callback-era/).

Представь рефакторинг не как «перепишем всё на async», а как **границы**:

- UI world — `@MainActor` / ViewModel;
- domain — <a class="eu-term" href="../../../glossary/#glossary-actor">actor</a> или чистые async services;
- legacy GCD — за adapter, пока не дойдёшь.

> DoD миграции: **модуль за модулем**, strict mode / Sendable на границах, тесты на cancel — не «zero DispatchQueue в репо к пятнице».

---

## Проблема

Типичные production боли (из hub «What breaks»):

| Симптом | Частая причина |
|---------|----------------|
| UI freeze | sync work on MainActor |
| TSan / random crash | non-<a class="eu-term" href="../../../glossary/#glossary-sendable">Sendable</a> crossing |
| Duplicate requests | unstructured <a class="eu-term" href="../../../glossary/#glossary-task">Task</a> без coalescing |
| Zombie work | no cancel on dismiss |
| «Невозможная» гонка на actor | reentrancy после await |

Миграция ломается, когда:

- смешивают «новый async API» и старые callbacks без **adapter layer**;
- включают strict concurrency на весь monolith сразу;
- нет [тестов](../testing-concurrent-systems/) на границах — регресс не виден.

Ошибка интервью: «Swift Concurrency заменяет GCD полностью завтра». Реальность: GCD остаётся в SDK и legacy годами; выигрыш — **новые** границы и постепенная замена hot paths.

---

## История (коротко)

```text
GCD + callbacks (ручные queue rules)
  → async/await surface + continuations для legacy
  → actors / MainActor для ownership
  → Sendable + strict per-target
  → phased module migration + CI gates
```

Warehouse: [legacy archive](../notes/legacy-warehouse-archive.md) · [ImageLoadingConcurrencyLab](../ImageLoadingConcurrencyLab.playground).

---

## Как это работает

| Слой | Роль |
|------|------|
| UI / presentation | `@MainActor` ViewModel · SwiftUI observation borders |
| Domain services | `actor` или stateless async structs · <a class="eu-term" href="../../../glossary/#glossary-sendable">Sendable</a> payloads |
| Infrastructure | URLSession async · cache · persistence — off MainActor |
| Legacy adapter | `withCheckedContinuation` / wrapper queue · не протекать non-Sendable |
| Migration unit | Feature module / framework · DoD per module |

Default decision tree (hub Level 2, production voice):

```text
Shared mutable state     → actor (или immutable values)
UI state                 → MainActor
Long CPU / I/O           → off MainActor, hop back via await
Legacy callback module   → adapter → async boundary → tests
```

Phased migration — не хронология «сверху вниз по файлам», а **риск**:

1. New code — только Swift Concurrency rules.  
2. Hot crash/TSan paths — Sendable + isolation first.  
3. Leaf modules — strict mode enable.  
4. Core monolith — last, with adapters.

DoD одного модуля (пример):

- Public API crosses isolation только с Sendable или actor.  
- Screen dismiss cancels structured work.  
- Unit tests: happy + cancel ([testing chapter](../testing-concurrent-systems/)).  
- No new `DispatchQueue` unless justified (legacy bridge).

---

## Внутри

Level 3 — дверь.

Executors, priority inversion, custom executors — earned depth в notes, не здесь.

`@preconcurrency import` и incremental strict — tooling для legacy, не «выключить проверки навсегда». Цель — сузить surface, не застрять в warnings.

Связь с [cancellation](../cancellation-and-cooperation/): production checklist — каждый long-running path имеет cancel + test.

Связь с [MainActor](../mainactor-and-ui/): VM не держит sync network; domain не трогает UIKit напрямую.

---

## Пример

Псевдокод «big bang» vs «phased boundary»:

```text
Плохо (big bang):
  // 500 files: replace DispatchQueue.global with Task overnight
  // CI red · no adapters · legacy SDK callbacks broken

Лучше (phased):
  // Module Search:
  //   SearchService — async API, actor-backed cache
  //   LegacyImageLoader — GCD inside, adapter exposes async load() -> Sendable ImageToken
  //   SearchViewModel @MainActor — cancels Task on disappear
  // DoD: strict on Search target · tests for debounce cancel
```

Adapter pattern:

```text
Legacy: func load(completion: @escaping (Data?) -> Void)
Bridge: func load() async -> Data? {
  await withCheckedContinuation { cont in
    legacy.load { cont.resume(returning: $0) }
  }
}
```

Bridge — не финал; финал — Sendable domain types и actor ownership.

---

## Production

Привычка:

> Перед новым `Task { }` в View: **lifetime = screen?** cancel on disappear · coalesce duplicates · [test cancel path](../testing-concurrent-systems/).

Чеклист релиза:

1. MainActor: нет sync heavy work?  
2. Boundaries: Sendable payloads?  
3. Structured vs unstructured: handle stored?  
4. Migration: module DoD, не global flag day?  
5. Observability: signposts / Points of Interest на hot async paths?

Инструменты hub: Thread Sanitizer · Instruments · strict concurrency per target · не выдумывать «метрики WWDC» — мери у себя.

---

## Интервью

| Вопрос | На что смотрят |
|--------|----------------|
| Как мигрировать с GCD? | Phased · adapters · module DoD |
| Заменит ли async весь GCD? | Новые границы да; legacy/SDK — долго coexist |
| Где actor vs MainActor? | Domain ownership vs UI world |
| Production symptom → fix? | Карта hub What breaks |
| Big bang vs incremental? | Incremental + CI gates |

**Типичные ошибки:** rewrite всего репо; unchecked Sendable в adapter «временно» без срока; нет cancel; strict on monolith day one.

---

## Лабораторная

Пока теория. Практика: выбери один legacy GCD module · нарисуй adapter + DoD · [ImageLoadingConcurrencyLab](../ImageLoadingConcurrencyLab.playground). Evidence async.

---

## Конспект

Коротко со стола.

1. Production = **слои** UI / domain / infra / legacy adapter.  
2. Миграция **по модулям**, не big bang.  
3. DoD: Sendable boundaries · cancel · tests.  
4. GCD coexist — adapters, не denial.  
5. Hub «What breaks» — карта симптомов.  
6. §D завершён → hub · labs · Level 3 notes.

---

## Рефлексия

> **до:** «надо переписать всё на async»  
> **после:** границы · phased DoD · adapters · измеряемые gates

**Дальше:** [Concurrency hub](../) · [Interview pack](../notes/Interview-Pack.md) · labs

---

## Evidence

Теория этой главы покрыта (v1). Практика / Path write-back — асинхронно.

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise

## Open questions

Какой legacy module у тебя первым получит module DoD (strict + cancel tests)?

---

<details>
<summary>For contributors</summary>

| | |
|--|--|
| **Topic id** | `swift/concurrency/production-architecture-and-migration` |
| **Version** | v1 |
| **Design** | [DESIGN.md](DESIGN.md) |
| **Prev** | [testing-concurrent-systems](../testing-concurrent-systems/) |
| **Next** | [hub](../README.md) |
| **Hub** | [../README.md](../README.md) |
| **Handoff** | [`.author/SWIFT_SHELF_HANDOFF.md`](../../../.author/SWIFT_SHELF_HANDOFF.md) |

</details>
