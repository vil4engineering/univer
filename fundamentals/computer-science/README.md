# Computer Science

Hub / index for CS foundations used in Senior iOS prep — **not** a Living why-chapter.

Deep answers live in dedicated chapters. This page maps Focus areas and points to SoT.

## Living chapters (memory)

| Why | Chapter |
|-----|---------|
| Почему одного Stack оказалось недостаточно? | [Why Heap appeared](../why-heap-appeared/) |

Execution Spine (другая цепочка — задача → CPU): [Computer Science · PART_I](../PART_I.md).

## In 30 seconds

CS fundamentals explain *why* Swift and iOS behave as they do: memory lifetime, algorithmic cost, concurrency primitives, caching, common structures. Interviewers test reasoning about performance, memory, and correctness — not API names.

**How we teach:** Problem → History → Analogy → Architecture → Implementation — not Definition → API → code. Plant model: [PART_I](../PART_I.md). Desk/warehouse memory: [Why Heap appeared](../why-heap-appeared/).

## Focus vs Defer

### Focus

- **Stack vs Heap (lifetime)** — canonical: [Why Heap appeared](../why-heap-appeared/). Criterion = lifetime vs function call, not “classes vs structs”. Swift/ARC illustration: [Memory & ARC](../../swift/memory-arc/).
- **Big-O for mobile work** — O(1), O(log n), O(n), O(n log n), O(n²); scrolling, search, batching.
- **Process vs thread vs task** — OS units vs Swift Concurrency. Glossary: [Process](../../glossary/#glossary-process), [Thread](../../glossary/#glossary-thread), [Task](../../glossary/#glossary-task).
- **Caching trade-offs** — CPU vs memory vs staleness; `NSCache`, `URLCache`.
- **Core data structures** — array, dictionary, set, queue; **ADT** Stack (LIFO) ≠ memory Stack — see [Stack under the hood](../../algorithms/structures/notes/Stack-Under-The-Hood.md).
- **Amortized complexity** — `Array.append` and `reserveCapacity`.

### Defer

- Custom allocators / balanced trees from scratch unless the role is systems-heavy.
- Formal algorithm proofs; competitive-programming tricks unrelated to mobile work.
- Deep CPU cache-line tuning without Instruments evidence.

## Key concepts (pointers)

- **Stack / Heap / Stack Frame / Lifetime** — [Why Heap appeared](../why-heap-appeared/) · [Glossary](../../glossary/)
- **Stack (ADT)** — LIFO structure; not the memory region — [note](../../algorithms/structures/notes/Stack-Under-The-Hood.md)
- **Big-O · Process · Thread · Cache · CoW** — short defs remain interview hooks; deepen in dedicated pages when they exist

## Apple docs

- [MemoryLayout](https://developer.apple.com/documentation/swift/memorylayout)
- [Automatic Reference Counting (Swift Book)](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/)
- [Concurrency (Swift Book)](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)

## Exercises

1. **Stack vs heap:** After reading [Why Heap appeared](../why-heap-appeared/), classify `Point`, `Node`, escaping closure — argue via **lifetime**, then Swift illustration.
2. **Big-O spot check:** Nested `users × orders` — complexity + one refactor.
3. **Structure pick:** In-memory LRU for thumbnails with a cost cap.
4. **Thread vs Task:** Callback retry → `async/await`; what still runs on threads?
5. **Amortized cost:** Append 1…10_000 with/without `reserveCapacity`.

## Interview Q&A (Knowledge cards)

<!-- knowledge-cards-canonical:start -->

### Q1
- **Question:** Stack vs heap—what is the difference?

- **Answer:** See canonical chapter [Why Heap appeared](../why-heap-appeared/). Short: Stack lifetime matches the function/frame; Heap lifetime is independent of the creating function. Prefer that wording over “long-lived objects.” Swift details: [Memory & ARC](../../swift/memory-arc/).

### Q2
- **Question:** Explain Big-O using a list in an iOS app.

- **Answer:** Big-O describes growth with input size n. Index access is O(1); full array transforms on the main thread are O(n); sorting is O(n log n); nested scans are O(n²). Table/collection reuse keeps UI work proportional to visible items, not total n.

### Q3
- **Question:** Process vs thread—what matters for iOS developers?

- **Answer:** A process is an isolated memory space (iOS app sandbox). Threads share memory within a process; the main thread drives UI. GCD schedules blocks on thread pools; Swift tasks add structured concurrency but still require synchronization for shared mutable state.

### Q4
- **Question:** When and how should you cache on iOS?

- **Answer:** Cache when recomputation or network is costly and staleness is acceptable. Use URLCache for HTTP, NSCache for memory-sensitive objects, or layered memory+disk with explicit TTL and invalidation. Always cap size and respond to memory pressure.

<!-- knowledge-cards-canonical:end -->
