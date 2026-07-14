# ADR-0002: AsyncSequence for LLM Streaming

## Status

Accepted

## Context

The Chat module must display tokens as they arrive from the model (streaming). Cloud APIs deliver responses via **Server-Sent Events (SSE)** over HTTP — a sequence of partial chunks, not a single JSON body.

Requirements:

- Update UI incrementally with low latency (TTFT metric)
- Support **cancellation** when the user taps Stop
- Work with **Swift Concurrency** (project stack constraint)
- Avoid blocking the main thread

The user rules also specify: prefer Swift async/await over Combine.

## Decision

Expose streaming through **`AsyncThrowingStream<ChatStreamEvent, Error>`** returned from `LLMProvider.stream(_:)`.

```swift
func stream(_ request: ChatRequest) -> AsyncThrowingStream<ChatStreamEvent, Error>
```

Inside each provider adapter:

1. `URLSession.shared.bytes(for:)` yields an `AsyncSequence` of lines
2. `SSEParser` extracts `data:` payloads
3. Provider-specific JSON parsing emits `ChatStreamEvent.textDelta`
4. On completion, emit `.completed(ChatCompletionResult)` with usage metadata

ViewModels consume with:

```swift
for try await event in provider.stream(request) {
    switch event.kind { ... }
}
```

Cancellation: `streamTask?.cancel()` → `continuation.onTermination` cancels the underlying `Task`.

## Consequences

### Positive

- **Natural fit with Swift 6** — `async/await` end-to-end; no Combine bridge.
- **Structured cancellation** — `Task.cancel()` propagates cleanly; critical for Stop button UX.
- **Composable** — streams can be wrapped (timeout, logging) without publisher gymnastics.
- **TTFT measurement** — first `.textDelta` timestamp minus request start = Time To First Token.

### Negative

- **No backpressure API** — `AsyncThrowingStream` does not expose fine-grained flow control; fast models may flood UI updates (mitigated by SwiftUI batching).
- **Per-provider SSE parsing** — OpenAI, Anthropic, and Gemini use different event shapes; shared `SSEParser` only handles line splitting.
- **Error mid-stream** — partial text may already be shown when an error arrives; ViewModel must handle `.error` and `.completed` distinctly.

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **Combine `Publisher`** | Project stack prefers Observation + async/await; adds `AnyCancellable` lifecycle in ViewModels. |
| **Callback delegates** | Harder to cancel; callback hell for multi-step tool loops. |
| **`URLSessionDataDelegate` streaming** | Lower-level; more boilerplate than `bytes(for:)`. |
| **Wait for full response, animate typing** | Fake streaming; does not demonstrate SSE, TTFT, or real cancellation. |
| **Third-party SSE library** | Unnecessary; SSE line protocol is simple enough to parse inline. |

## Interview Sound Bite

> "Streaming is an `AsyncThrowingStream` of domain events, not raw bytes. The provider adapter owns SSE parsing; the ViewModel only sees `textDelta` and `completed`. Cancellation is cooperative via `Task.cancel()`."
