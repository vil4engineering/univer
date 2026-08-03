# DESIGN — Почему isolation, а не «поток на объект»?

**Topic id:** `swift/concurrency/actors-and-isolation` · Accept pending  
**H1:** Почему isolation, а не «поток на объект»?  
**Claims:** Actor serializes access to its state (fact); reentrancy after await (fact); actor ≠ thread-per-object (fact).

- [x] Один why · не actor API dump  
- [ ] Formal Accept
