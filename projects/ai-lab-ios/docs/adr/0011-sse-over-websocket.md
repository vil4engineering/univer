# ADR-0011: SSE over WebSocket for LLM Streaming

## Status

Accepted

## Context

LLM chat APIs (OpenAI, Anthropic, Gemini) deliver streaming responses as a sequence of partial tokens. Two common transport patterns exist:

- **Server-Sent Events (SSE)** — HTTP POST returns `text/event-stream`; server pushes `data:` lines
- **WebSocket** — bidirectional persistent connection; client and server send frames

AI Workspace must:

- Stream tokens into SwiftUI with low TTFT
- Work through standard HTTP infrastructure (proxies, URLSession)
- Align with what cloud LLM providers actually expose
- Support cancellation via `URLSession` + `Task.cancel()`

## Decision

Use **HTTP + SSE** as the streaming transport. Parse SSE lines in provider adapters via `URLSession.shared.bytes(for:)` and `SSEParser`.

```text
POST /v1/chat/completions
Accept: text/event-stream

data: {"choices":[{"delta":{"content":"Hello"}}]}
data: {"choices":[{"delta":{"content":" world"}}]}
data: [DONE]
```

No WebSocket client, no persistent connection manager, no heartbeat/reconnect logic in the app.

## Consequences

### Positive

- **Provider reality** — OpenAI, Anthropic, and Gemini streaming APIs are SSE-over-HTTP, not WebSocket. Using SSE means zero impedance mismatch.
- **URLSession native** — `bytes(for:)` returns `AsyncSequence`; no third-party socket library.
- **Firewall/proxy friendly** — HTTP POST works everywhere WebSocket sometimes breaks (corporate proxies).
- **Stateless requests** — each chat turn is one HTTP request; no connection lifecycle to manage.
- **Simpler mental model** — request in, event stream out; maps cleanly to `AsyncThrowingStream`.

### Negative

- **Unidirectional** — client cannot send data mid-stream on the same connection (must abort and start new request).
- **No server push outside request** — unlike WebSocket, server cannot initiate messages without a client request.
- **Line buffering** — malformed chunk boundaries require careful parsing; partial JSON lines need handling.
- **HTTP overhead** — new TCP/TLS handshake per request (mitigated by HTTP/2 connection reuse in URLSession).

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **WebSocket client** | LLM chat APIs don't offer it for completions; we'd wrap HTTP anyway or build a custom gateway. |
| **Long-polling** | Higher latency; no advantage over SSE for token streaming. |
| **gRPC streaming** | Not exposed by OpenAI/Anthropic public APIs. |
| **WebSocket for Voice only** | Real-time audio (OpenAI Realtime API) is a separate pipeline; Voice module uses on-device Speech + HTTP LLM, not Realtime WebSocket. |
| **Socket.IO / Starscream** | Extra dependency for a protocol our providers don't use. |

## When WebSocket *Would* Make Sense

| Use case | Transport |
|----------|-----------|
| OpenAI Realtime API (speech-to-speech) | WebSocket |
| Custom backend with bidirectional events | WebSocket |
| MCP over SSE (server → client push) | SSE (see Phase 3) |
| Standard chat completions | **SSE** ✓ |

## Interview Sound Bite

> "Cloud LLM streaming is SSE over HTTP, not WebSocket. I use URLSession's async byte sequence, parse `data:` lines, and expose an AsyncThrowingStream to the ViewModel. WebSocket would add complexity without matching what the APIs actually offer — except for specialized realtime audio APIs, which are a different module."

## Related

- [ADR-0002: AsyncSequence for Streaming](0002-async-streaming.md)
- Roadmap Phase 3: MCP may also use SSE transport
