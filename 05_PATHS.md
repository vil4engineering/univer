# 05 · Paths

**Project:** Engineering University  
**Status:** Phase 1 governance (revised — Path Alpha lesson contract)  
**Related:** [01_CHARTER.md](01_CHARTER.md) · [03_CURRICULUM.md](03_CURRICULUM.md)

## One university, multiple routes

Paths are routes through the same faculties and principles.

Paths are not separate universities and not synonyms for folder trees.

Every path still obeys:

- Completeness Principle
- Problem-first learning
- Interview Readiness inside subjects
- Progressive difficulty
- Honesty about experience

## Path Alpha — Senior → Senior+/Lead (Student A)

**Goal:** systematically eliminate the gaps between a strong Senior and a Senior+/Lead.

**Not the goal:** isolated technology tours or interview trivia.

Always optimize for engineering reasoning, decision-making, and real-world ownership.

### Lesson contract

Every Alpha lesson follows the Senior+/Lead contract in [03_CURRICULUM.md](03_CURRICULUM.md):

Mental model → Decision framework → Alternatives → Interview perspective → Ownership levels → Connect to experience (honest) → Interview answer → Deep dive until mastery.

Do not advance to the next competency until the current one is mastered.

### Spine (problem classes, not folders)

1. **Technical Ownership** (Leadership 01)
2. **Decision Making** (Leadership 03)
3. **Architecture** as a response to change and risk (Leadership 02 + Software/Mobile)
4. **Engineering Standards** and **Code Review** (Leadership 04–05)
5. Modularization / SDK / API design as ownership tools
6. Correctness under concurrency and state
7. Quality, performance, security, and failure modes
8. **Product Engineering** and **Cross-functional Communication** (Leadership 07–08)
9. **Mentoring** (Leadership 06)
10. **Career Story** and **Interview Engineering** (Leadership 09–10) — honest narration only
11. Craft depths (concurrency, testing, CI/CD, security, …) as **decision cases** inside the above

Technologies (MVVM, TCA, Coordinators, Combine vs async/await, pinning, Fastlane, …) appear as **decision cases** — never as the spine itself.

Alpha uses Faculty of Engineering Leadership first, then Software Engineering, Mobile Engineering, Product Engineering, and Career Development.

## Path Beta — Foundations (Student B)

**Goal:** learn to think and build, gradually.

Spine:

1. Simple real problems with clear feedback
2. Computer science and algorithmic thinking
3. Programming craft and small verified programs
4. Basic software structure
5. Tiny labs that answer one question
6. Teaching-back moments with Student A

Beta uses Faculty of Computer Science first, then carefully introduces Mobile and Software Engineering.

Leadership subjects arrive later, in simplified form — the faculty remains valuable over a decade.

## Path Gamma — AI-Native Engineer

**Goal:** Engineer + AI, not AI instead of engineer.

Spine follows AI maturity — not a technology checklist:

```text
AI Foundations
  → Model Integration
  → Structured Outputs
  → Tool Calling
  → Evaluations
  → Reliable AI Systems
  → Agent Systems
```

Primary audience: Student A.  
Student B may enter later through simplified problems inside AI Foundations only.

Existing `ai-engineering` materials are candidate content for this path. They are incomplete until Completeness gates close.

## Path Epsilon — Teaching Loop

**Goal:** knowledge survives because it can be taught.

Spine:

1. Complete a subject / lesson to Interview Readiness (and Alpha mastery gate when applicable)
2. Explain it simply to the other student
3. Rebuild a smaller version as a lab or exercise
4. Reflect on what was hard to explain

Epsilon is available to both students and should appear inside Alpha, Beta, and Gamma — not only as a standalone track.

## Interview readiness (not a separate path)

Interview preparation is **embedded** in every subject and in every Alpha lesson.

Faculty of Career Development maintains cross-cutting craft:

- answer depth tiers
- trade-off narration
- production storytelling
- pressure communication

It does not own private career facts, salary strategy, or the external `career` repository.

## How to choose a path

| If you need… | Start with |
|--------------|------------|
| Senior → Senior+/Lead depth | Alpha (start at Ownership) |
| First principles and gradual building | Beta |
| Reliable AI systems skill | Gamma |
| Retention through teaching | Epsilon (alongside another path) |

Student A and Student B may walk different paths in the same week. The university stays one system.

## Path design rules

1. Paths name **problem progressions**, not directory tours.
2. A path may cross many faculties.
3. Skipping Completeness gates is allowed for exploration; claiming mastery is not.
4. Harder problems come after simpler ones are honestly completed.
5. Alpha lessons do not advance until the deep-dive gate passes.
6. Paths may be revised during university setup — without mass file migration.

## Near-term path work (setup continuation)

- Run Alpha lesson 01: Technical Ownership (contract sections 1–8)
- Map Leadership subjects 01–10 into lesson queue
- Map existing strong craft topics (concurrency, testing, architecture notes) as decision cases
- Map algorithms / CodeKata materials onto Beta
- Remap AI topic pages onto the Gamma maturity spine
