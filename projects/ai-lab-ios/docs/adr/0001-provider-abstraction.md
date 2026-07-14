# ADR-0001: Provider Abstraction for Multi-LLM Support

## Status

Accepted

## Context

AI Workspace must support **four different model backends** — OpenAI, Anthropic, Gemini, and Apple Foundation Models — without rewriting UI or ViewModels every time the user switches providers.

Each API differs in:

- Request/response JSON shape
- Streaming format (SSE event structure)
- Authentication headers
- Tool calling wire format
- Capability set (vision, embeddings, on-device)

The app also needs a **capability matrix** in the Models module so users can see what each provider supports.

## Decision

Introduce a **`LLMProvider` protocol** and a **`ProviderRegistry`** that maps `AIProviderKind` → concrete adapter.

```swift
protocol LLMProvider: Sendable {
    var kind: AIProviderKind { get }
    var capabilities: ProviderCapabilities { get }
    var availableModels: [AIModelDescriptor] { get }
    func complete(_ request: ChatRequest) async throws -> ChatCompletionResult
    func stream(_ request: ChatRequest) -> AsyncThrowingStream<ChatStreamEvent, Error>
}
```

ViewModels depend only on `ProviderRegistry` and `ChatRequest`/`ChatCompletionResult` — never on provider-specific types.

Provider-specific translation (OpenAI `choices[].delta.content`, Anthropic `content_block_delta`, Gemini `candidates[].parts`) lives inside each adapter.

## Consequences

### Positive

- **UI stability** — Chat, Tools, and Voice modules work with any provider; only Settings changes the active one.
- **Testability** — a mock `LLMProvider` can drive all feature tests without network.
- **Interview clarity** — maps directly to the Adapter pattern and dependency inversion.
- **Foundation Models** slot in as just another adapter, enabling cloud vs on-device comparison.

### Negative

- **Lowest common denominator risk** — shared `ChatRequest` may not expose every provider-specific knob (e.g. Gemini's 1M context metadata).
- **Maintenance cost** — each new provider needs a full adapter; streaming tool-call parsing is still per-provider work (see Roadmap Phase 2).
- **Leaky abstractions** — Vision and Embeddings use separate protocols (`VisionCapable`, `EmbeddingProvider`) because not all LLM providers support them.

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **Single OpenAI-only client** | Cannot demo multi-provider architecture — a core portfolio goal. |
| **Third-party unified SDK** (e.g. LiteLLM-style wrapper) | Adds dependency; hides iOS networking and Swift Concurrency learning value. |
| **Enum with switch in ViewModel** | Business logic bleeds into UI layer; every new provider touches every screen. |
| **One mega-protocol with 40 methods** | Violates interface segregation; Foundation Models would stub most methods. |

## Follow-up at Scale

- Add a `ProviderMiddleware` layer for retries, rate limiting, and fallback chains.
- Extend `ChatStreamEvent` with provider-agnostic tool-call deltas once all adapters implement them.
