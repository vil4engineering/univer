# Engineering guide

## Overview

**FlipEnglish** — multiplatform SwiftUI app (`flip-english` repo). Local-first storage, on-device AI for card generation, spaced repetition for review.

## Platform and stack

| Item | Choice |
|------|--------|
| Repo | `flip-english` |
| App | FlipEnglish |
| Platforms | iOS 26+ and macOS 26+ (SwiftUI multiplatform, not Catalyst) |
| Language | Swift 6 |
| UI | SwiftUI |
| Persistence | SwiftData + CloudKit sync (local-first) |
| AI | Foundation Models + FoundationModelsUtilities |
| Architecture | MV — `Domain/`, `Services/`, `Features/`, `AgentLab/` |
| Backend / auth | None |

**Requirements:** Apple Intelligence — iPhone 15 Pro+ on iOS; M-series Mac on macOS.

## Layer structure

| Layer | Responsibility | Examples |
|-------|----------------|----------|
| Domain | Pure logic, models | `SpacedRepetitionEngine`, `CardValidator`, `Card` |
| Services | Persistence, AI orchestration | `CardStoring`, `ImportOrchestrator` |
| Features | SwiftUI screens | Today, Learning, Import |
| AgentLab | FM experiments, tools | `@Generable`, `DynamicProfile`, tool calling |

## Folder structure

```
FlipEnglish/
├── Domain/
├── Services/
├── Features/
├── AgentLab/
FlipEnglishTests/
├── Support/
├── Domain/
└── Services/
```

## Multiplatform

| Aspect | iOS | macOS |
|--------|-----|-------|
| Primary UX | Swipe cards one-handed | Import and Agent Lab on large screen |
| Gestures | DragGesture swipe | Click or drag (same engine) |
| Shared code | Domain, Services, Tests | Same |

Use `#if os(...)` only where needed (gestures, toolbar).

## AI pipeline

**Flow:** Extract → Enrich → Validate → Persist

| Step | Task |
|------|------|
| Extract | Text → phrase list |
| Enrich | Phrase → full card |
| Validate | Card → pass/reject (`CardValidator`) |
| Persist | Save to store (`SaveCardTool`) |

**Patterns:** orchestrator (`ImportOrchestrator`), tool calling, phone-a-friend / `DynamicProfile`, optional RAG over existing cards (dedup, related phrases).

### General → Apple mapping

| Concept | Apple API |
|---------|-----------|
| LLM inference | `LanguageModelSession.respond(to:)` |
| Structured output | `@Generable`, `@Guide` |
| Tools | `Tool` protocol |
| Multi-agent | `DynamicProfile`, session handoff |
| Context management | `historyTransform`, rolling window utilities |
| RAG | App-side retrieval or FM Spotlight search tool |
| On-device vs cloud | `SystemLanguageModel` vs `PrivateCloudComputeLanguageModel` |

Extract/Validate → on-device; Enrich/Interview parsing → PCC where needed.

## Testing

- One test target — XCTest and Swift Testing together.
- **Paired tests per module:** `ModuleNameXCTests.swift` + `ModuleNameSwiftTests.swift`, same scenarios.
- First domain target for TDD: `SpacedRepetitionEngine` (pure Swift, no UI, no AI).
- Shared `Fixtures.swift` for both frameworks.
- **Never** call real LLM in unit tests.
- **Do not unit-test** SwiftUI `body`, pass-through ViewModels, or Apple frameworks directly.

### Test doubles

| Type | Example |
|------|---------|
| Fake | `InMemoryCardStore` — real save/fetch, no SwiftData |
| Stub | `FakeCardGenerator` returns one hardcoded card |
| Spy | `ExtractPhaseSpy.callCount`, `lastInput` |

Mock **boundaries** (network, DB, LLM), not every class.

## Out of scope (v1)

Fine-tuning · custom vector DB in production · Share Extension · Image Playground auto-images · CloudKit debugging marathons · UI polish · Apple Watch · widgets · Evaluations framework in CI

## Hard constraints

- English only — no translations in generated cards
- Phrases, not single words — guardrails in prompts and `CardValidator`
- No backend, external DB, or auth
- Prefer Swift Concurrency over GCD
- No comments in source unless requested

## References

- [Product spec](product.md)
- [Foundation Models platform overview (iOS 27)](foundation-models-ios27.md)
- WWDC25: [Foundation Models intro](https://developer.apple.com/videos/play/wwdc2025/286/)
- WWDC26: [What’s new in FM (241)](https://developer.apple.com/videos/play/wwdc2026/241/)
- WWDC26: [Agentic app experiences (242)](https://developer.apple.com/videos/play/wwdc2026/242/)
