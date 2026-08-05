# Interview Prep Map

**Version:** 0.1  
**Last updated:** 2026-08-04  
**Purpose:** 10–15 min blitz before an interview — connectivity of blocks, not a second textbook.  
**Audience:** Owner Mode A (Creator Portal). **Not** Learn chrome / sidebar.

Prep Map status ≠ Library Publish ≠ `interview_ready` / `mastered` in [PROGRESS](../campus/PROGRESS.md).  
✅ / 🟡 here = *prep mental model* for the block. Canonical depth lives in Living chapters (links below).

## Status legend

| Mark | Meaning |
|------|---------|
| ✅ | Block closed for prep blitz (mental model + phrases) |
| 🟡 | Started; gaps listed |
| ⬜ | Not opened |

After each **block close** (not every pulse): update chain · 3–7 key thoughts · **Самое важное понимание** · **Интервью-фраза** · canonical links. See [persist-learning-session](../.ai/workflows/persist-learning-session.md).

---

## 1. Computer Science Foundations ✅

How text becomes a running program.

```text
Compiler → Runtime → Operating System → Process → Thread
```

**Key thoughts**

- Compiler builds the program.
- Runtime serves an already running program.
- OS creates a Process.
- Thread executes code.
- CPU executes only machine instructions.

**Самое важное понимание:** Программа — это путь от текста к machine code; Process/Thread — как OS даёт этому пути жить во времени.

**Интервью-фраза:** "The Compiler builds the program; the Runtime serves it once it is running — Process and Thread are how the OS schedules that work."

**Analogy (plant):** [PART_I · Ментальная модель: завод](../fundamentals/PART_I.md)

**Canonical:** [Execution Spine / PART_I](../fundamentals/PART_I.md) · [What is programming](../fundamentals/what-is-programming/) · Glossary: [Compiler](../glossary/#glossary-compiler), [Process](../glossary/#glossary-process), [Thread](../glossary/#glossary-thread)

---

## 2. Memory Management ✅

```text
Stack
  → Heap
  → Manual Memory Management
  → Reference Counting
  → ARC
  → Struct / Class
  → Copy-on-Write
```

**Key thoughts**

- Stack and Heap differ by lifetime-management model, not by “what types they store.”
- Heap appeared so data can outlive the creating function.
- Manual MM led to Memory Leak, Double Free, Dangling Pointer.
- Reference Counting addressed manual `free`.
- ARC automates retain/release.
- `struct` — value semantics; `class` — reference semantics.
- CoW keeps value semantics with efficient sharing until mutation.

**Самое важное понимание:** Все темы Memory сводятся к двум вопросам: кто владеет объектом (ownership) и как долго он живёт (lifetime).

**Интервью-фраза:** "Stack and Heap differ not by data type, but by how lifetime is managed."

**Canonical:** [Why Heap appeared](../fundamentals/why-heap-appeared/) · [Memory Leak](../swift/memory-arc/notes/Memory-Leak.md) · [Memory & ARC](../swift/memory-arc/) (Swift illustration) · session [2026-08-04-stack-heap](learning-sessions/2026-08-04-stack-heap.md) · [2026-08-05-memory-leak](learning-sessions/2026-08-05-memory-leak.md)

**Prep note:** Below Heap (Manual MM → ARC → CoW) = prep chain; Leak/retain-cycle note landed; not every step is a full Living chapter yet.

---

## 3. Concurrency Foundations ✅

```text
Single Thread
  → Waiting
  → Multiple Threads
  → Race Condition
  → Critical Section
  → Mutex
  → Semaphore
  → Dispatch Queue
  → Swift Concurrency
  → Actor
```

**Key thoughts**

- Threads exist to use compute efficiently — not “for UI.”
- Race Condition comes from shared mutable state.
- The pain is non-atomic read → modify → write.
- Solutions evolved from Mutex toward Actor.

**Самое важное понимание:** Concurrency — про безопасный shared mutable state во времени, а не про «побольше потоков».

**Интервью-фраза:** "A race is shared mutable state without a safe critical section — Actors are the Swift-era answer in that evolution."

**Canonical:** [Concurrency hub](../swift/concurrency/) · Glossary: [Concurrency](../glossary/#glossary-concurrency), [Data race](../glossary/#glossary-data-race), [Actor](../glossary/#glossary-actor)

---

## 4. Closures ✅

```text
Closure
  → Lifetime
  → non-escaping
  → @escaping
  → Capture List
  → weak / unowned
  → Retain Cycle
```

**Key thoughts**

- `@escaping` changes lifetime, not “magic.”
- Capture List decides how the closure captures outer objects.
- `weak` allows `nil`; `unowned` requires the object to outlive the reference.

**Самое важное понимание:** Closure связывает Memory (lifetime/ownership) с кодом, который «убегает» за scope.

**Интервью-фраза:** "@escaping is about lifetime; the capture list is about ownership — weak vs unowned is the interview fork."

**Canonical:** [unowned](../glossary/#glossary-unowned) · [weak](../glossary/#glossary-weak) · [retain cycle](../glossary/#glossary-retain-cycle) · [Why-Not-All-Weak](../swift/memory-arc/notes/Why-Not-All-Weak.md) — dedicated Living chapter still prep draft.

---

## 5. SwiftUI 🟡

```text
UIKit
  → Imperative UI
  → Why it stopped scaling?
  → SwiftUI
  → Declarative UI
  → View = struct
  → State
  → Diffing
  → Rendering Pipeline
```

**Closed (prep)**

- Why SwiftUI appeared.
- Why View is a `struct`.

**Still open**

- Where `@State` lives.
- Diffing · Identity · `@Binding` · `@Environment` · Observable.

**Самое важное понимание:** SwiftUI — declarative View as value; state and identity drive updates (details still open).

**Интервью-фраза:** "SwiftUI views are structs — cheap descriptions; the hard part is state identity and the update pipeline."

**Canonical:** [SwiftUI shelf](../ios-sdk/swiftui/) (as published) — finish block ~30 min.

---

## Remaining to interview

| Block | Est. | Status |
|-------|------|--------|
| SwiftUI (finish) | ~30 min | 🟡 |
| Architecture (MVC → MVVM → VIPER → TCA) | ~30–40 min | ⬜ |
| Testing | ~40–50 min | ⬜ |
| Performance / Instruments | ~15 min | ⬜ |
| Final Blitz 50–70 questions | — | ⬜ |

Bump version when a block closes or Remaining changes materially.
