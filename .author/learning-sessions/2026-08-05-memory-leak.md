---
date: 2026-08-05
track: CS Foundations · Memory
status: persisted
canonical: swift/memory-arc/notes/Memory-Leak.md
---

# Learning session — Memory Leak

## Chain

```text
Heap → Ownership → Retain cycle → Memory Leak → weak / unowned / capture list → Instruments
```

## Validated wording

- Leak: memory stays allocated, unused, not released.
- Danger: footprint growth, jetsam, degraded UX.
- Under ARC, classic interview mechanism = retain cycle (not the only leak kind).
- Break with weak / unowned / [weak self]; do not make everything weak.
- Find via deinit, Memory Graph, Instruments — tools chapter is quality/debug.

## Mistakes corrected

| Avoid | Prefer |
|-------|--------|
| ARC frees memory (magic) | ARC manages reference counting |
| Leak only means forgot free | Often ownership cycle / abandoned owner |
| unowned is always safer than weak | unowned needs lifetime guarantee |

## Interview questions

- Чем опасна утечка памяти?
- Как разорвать retain cycle?
- weak vs unowned?
- Как найти утечку в Xcode?

## Decisions

- Canonical note on memory-arc shelf (not second handbook; not CS hub essay).
- Tools: link `quality/debug`, do not rewrite Instruments essay.
- Glossary: add Memory Leak; improve retain cycle card.

## Gaps

- [ ] Abandoned cache / unbounded NSCache as non-cycle leak
- [ ] Timer / CADisplayLink ownership patterns (deep)
- [ ] Side table + weak implementation (Senior)

## Artifacts (after persist)

| Artifact | Path |
|----------|------|
| Note | `swift/memory-arc/notes/Memory-Leak.md` |
| Glossary | `glossary/README.md` · Memory Leak |
| Tools | `quality/debug/README.md` (existing) |
| Session | this file |
