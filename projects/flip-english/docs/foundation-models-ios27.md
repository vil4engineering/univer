# Foundation Models on iOS 27 — platform overview

Study reference for FlipEnglish. Summarizes WWDC26 / iOS 27 direction: Foundation Models as a real AI platform layer, not only “call on-device LLM from Swift.”

**Primary video:** [What’s new in the Foundation Models framework (WWDC26, 241)](https://developer.apple.com/videos/play/wwdc2026/241/)

**Agentic patterns (FlipEnglish Session 4):** [Build agentic app experiences (WWDC26, 242)](https://developer.apple.com/videos/play/wwdc2026/242/)

---

## Shift from iOS 26 to iOS 27

| iOS 26 feel | iOS 27 direction |
|-------------|------------------|
| Neat way to invoke system on-device model from Swift | Platform layer for multiple models, context sources, execution modes |
| Single local LLM for in-app hints | Local + PCC + third-party providers behind one API |
| Chat-style features | Agentic workflows, tools, RAG, evaluations |

**Interview framing:** Choose boundaries explicitly — what stays on-device, what goes to PCC, what should not be built on an LLM at all.

---

## New on-device model

Apple reports stronger **logic** and **tool calling** on the rebuilt on-device model.

**New APIs (context budgeting):**

- Inspect model **context size**
- **Token counting** for instructions, prompts, and transcripts

Apps can adapt prompts to the device instead of hoping the prompt fits.

**FlipEnglish:** batch card import → measure tokens before enrich; trim transcript per device (ties to Session 4 `historyTransform` / summarize).

---

## Vision (multimodal prompts)

Images can be attached to prompts:

- `UIImage`, `NSImage`, `CGImage`
- Core Image types, Core Video pixel buffers
- File URLs

Larger images → more tokens → higher latency. Multimodal is an API for real features, not a demo-only path.

**FlipEnglish (later):** user pastes interview notes *and* a screenshot; extract phrases from image via vision + OCR tools (see System tools below).

---

## Private Cloud Compute (`PrivateCloudComputeLanguageModel`)

Same **Foundation Models** API surface; model runs on **Private Cloud Compute**, not on device.

| | On-device | PCC |
|---|-----------|-----|
| Context | Smaller | Larger |
| Reasoning | Lighter | `reasoningLevel` (e.g. deep) |
| Network | Offline-capable | Required |
| Privacy | Never leaves device | Ephemeral; Apple’s PCC privacy model |

**Developer terms (as presented):** no API keys, no separate auth, **no cloud API costs** for developers with fewer than **2M first-time downloads** (verify current Apple terms in documentation).

**FlipEnglish mapping:** Extract / Validate → `SystemLanguageModel`; Enrich / Interview parsing → `PrivateCloudComputeLanguageModel` where needed.

---

## Unified `LanguageModel` protocol

Main architectural shift: one abstraction, multiple backends.

Implementations / options mentioned in platform direction:

- `SystemLanguageModel` (on-device)
- `PrivateCloudComputeLanguageModel` (PCC)
- Core AI
- MLX
- Third-party models (e.g. Anthropic, Google)
- Your own server backend

**Downstream app code** can depend on `LanguageModel` / session APIs without hard-coding “always on-device” or “always cloud.”

**FlipEnglish:** `FlipEnglishProfile` switches `.model(...)` per phase — same pattern as WWDC26 Origami / Craft sample (session 242).

---

## System tools: Vision and Spotlight

Built-in tools the model can call:

| Tool | Role |
|------|------|
| OCR | Structured text from images |
| Barcode reader | Read barcode payloads |
| Spotlight search | **Local RAG** over Spotlight index |

**Spotlight-powered search** is the direct path to AI features over **personal or domain context** without shipping everything to a remote API.

**General concept:** RAG = retrieve → augment prompt → generate.  
**Apple implementation:** Spotlight index + FM search tool (local).

**FlipEnglish:** before enrich, retrieve user’s existing cards (dedup, related phrases) — simple keyword/in-memory first; Spotlight tool when wiring Session 4 RAG.

---

## Dynamic Profiles (agentic apps)

Declarative **modes** inside one `LanguageModelSession` instead of manually recreating sessions.

Example pattern:

- Profile A: analyze image with on-device model
- Profile B: switch to PCC with deep reasoning for idea generation

Related primitives (session 242):

- `DynamicProfile`, `DynamicInstructions`
- `historyTransform`, lifecycle modifiers (`onResponse`)
- Orchestration: **baton-pass**, **phone-a-friend**
- `ToolCallingMode`: allowed / disallowed / required
- Open-source **Foundation Models framework utilities** (Skills, rolling window modifiers)

**FlipEnglish:** `ImportOrchestrator` + `FlipEnglishProfile` — Extract → Enrich → Validate → Persist.

---

## Evaluations framework

Apple’s acknowledgment: LLM features are **non-deterministic** — they need **measurement**, not three manual taps.

Evaluations framework:

- Test sets of inputs
- Expected properties / rubrics
- Statistical comparison after prompt, tool, or model changes

**This is “tests for AI”** — complementary to unit tests:

| Layer | What tests |
|-------|------------|
| Unit (XCTest / Swift Testing) | SRS, `CardValidator`, orchestrator order with fakes |
| Evaluations | “10 interview texts → ≥3 phrases, no single words” |

FlipEnglish v1: evals **out of CI**; mention on interview; optional manual eval set later.

---

## Decision checklist (for any AI feature)

```text
1. Is the task deterministic?        → Pure Swift + unit tests, not LLM
2. Needs private user data?            → On-device or PCC, not random cloud API
3. Needs domain knowledge?             → RAG (Spotlight / app retrieval)
4. Multi-step with side effects?     → Agent + tools + orchestrator
5. Quality regression risk?          → Evaluations + guardrails (CardValidator)
6. Context too long?                 → Token APIs + trim/summarize / child sessions
```

---

## FlipEnglish session map

| Platform topic | Our session |
|----------------|-------------|
| Token / context APIs | Session 4 transcript management |
| `@Generable` structured output | Session 2 |
| Tools | Session 3 |
| Dynamic Profiles, phone-a-friend | Session 4 |
| Spotlight RAG | Session 4 optional |
| Evaluations | Out of scope v1; interview talking point |
| Vision + OCR tools | Phase 2 / future |

---

## Original study notes (RU)

Краткая выжимка для быстрого повторения:

- **iOS 27:** FM — платформа (модели, контекст, режимы выполнения), не только локальный LLM.
- **On-device:** сильнее logic + tool calling; API context size и token counting.
- **Vision:** картинки в prompt; размер → токены и latency.
- **PCC:** тот же API, больше контекст и reasoning; без API keys / cloud costs (лимит загрузок — см. Apple docs).
- **LanguageModel protocol:** локальная, PCC, Core AI, MLX, сторонние провайдеры — один слой для app code.
- **System tools:** OCR, barcode, **Spotlight = локальный RAG**.
- **Dynamic Profiles:** агенты внутри приложения (режимы, не один чатик).
- **Evaluations:** измерять качество LLM-фич, не только «потыкать три раза».

Смотреть WWDC 241 одним из первых при проектировании AI в приложении — чтобы выбрать границы: device vs PCC vs «не на LLM».
