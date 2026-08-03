# Interview pack — Swift Concurrency (M03)

Projection of canonical topic [`swift/concurrency`](../README.md). Short answers only. No second encyclopedia.

Skill: `interview-preparation` · Workflow: [`.ai/workflows/interview-prep-session.md`](../../../.ai/workflows/interview-prep-session.md)

---

## Q1 — Data races without freezing main

**Question:** Как убрать data races без заморозки main thread?

**Short (30s):** Изолировать shared mutable state (actor / immutable values). UI на `MainActor`. Тяжёлую работу — off MainActor, hop back через `await`.

**Canonical:** [../README.md](../README.md) Level 2 · What breaks  
**Follow-ups:** Почему lock across `await` опасен? Чем actor отличается от serial queue?  
**Common mistakes:** всё на MainActor; `@unchecked Sendable` без доказательства.

---

## Q2 — Structured concurrency

**Question:** Что решает structured concurrency?

**Short:** Явная иерархия задач: lifetime, cancellation и ошибки не «теряются» в fire-and-forget так же легко, как у detached/unstructured без дисциплины.

**Canonical:** [structured-concurrency](../structured-concurrency/) · notes/Structured-Concurrency-What-Structured-Means.md  
**Follow-ups:** Когда оправдан `Task.detached`? Что наследует child `Task`?  
**Common mistakes:** `Task { }` в `View` без отмены при disappear.

---

## Q3 — Actor vs serial queue

**Question:** Actor vs serial-queue mental model?

**Short:** Оба сериализуют доступ. Actor — язык/изолция + reentrancy на `await`. Queue — ручной контракт, без компиляторных границ `Sendable`.

**Canonical:** ActorsQueuesLocksInterview.playground · Level 2 Actor  
**Follow-ups:** Что такое actor reentrancy? Когда очередь всё ещё ок?  
**Common mistakes:** «actor = просто очередь, reentrancy не важно».

---

## Q4 — Testing async

**Question:** Как тестировать async без `sleep`?

**Short:** Детерминированные зависимости (clock/protocol), ожидание completion через async тесты / expectations, инъекция suspension points — не wall-clock sleep.

**Canonical:** [testing-concurrent-systems](../testing-concurrent-systems/)  
**Follow-ups:** Как флапает тест с real network?  
**Common mistakes:** `sleep(1)` как sync barrier.

---

## Q5 — Ignoring cancellation

**Question:** Что будет, если игнорировать cancellation?

**Short:** Работа продолжает жечь CPU/сеть после ухода пользователя; возможны update UI после dispose; лишние гонки при повторном входе.

**Canonical:** [cancellation-and-cooperation](../cancellation-and-cooperation/) · hub What breaks  
**Follow-ups:** Где ставить `checkCancellation`? Как связать с `URLSession` task cancel?  
**Common mistakes:** только `isCancelled` в конце длинного цикла.

---

## Q6 — Sendable

**Question:** Что такое Sendable и зачем strict concurrency?

**Short:** Sendable — тип безопасен для пересечения isolation domains без data race; не «struct всегда ok». Strict mode делает границы обязательными в сборке.

**Canonical:** [sendable-and-strict-concurrency](../sendable-and-strict-concurrency/)  
**Follow-ups:** `@unchecked Sendable` когда оправдан? Чем Sendable отличается от actor?  
**Common mistakes:** Sendable = immutability magic; unchecked без инварианта.

---

## Q7 — Production migration

**Question:** Как мигрировать с GCD на Swift Concurrency в проде?

**Short:** Слои UI/domain/infra; legacy за adapter; модуль за модулем DoD (Sendable boundaries, cancel, tests) — не big bang rewrite.

**Canonical:** [production-architecture-and-migration](../production-architecture-and-migration/) · hub What breaks  
**Follow-ups:** Где actor vs MainActor? Когда continuation-bridge?  
**Common mistakes:** «перепишем всё к релизу»; strict на monolith day one.

---

## Live Interviewer opener

```text
Role: Interviewer. Never explain.
Scenario: typeahead search fires 10 requests/sec; user leaves screen mid-flight.
Ask: what races / leaks / UI bugs appear? Go deeper until limit.
Canonical: swift/concurrency
```
