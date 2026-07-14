# ADR-0008: Local Tool Registry for Function Calling

## Status

Accepted

## Context

Tool Calling is the **most important module** in the portfolio. The user should say "Remind me tomorrow to call John" and see the LLM invoke `createReminder()` locally.

Challenges:

- Each LLM provider formats tool definitions differently in API requests
- Tools must be **defined**, **discovered**, **invoked**, and **return results** to the model
- Multi-step loops: model may call several tools before a final answer
- Demo tools (Weather, Calendar, Reminders) should run **on-device** without external APIs

## Decision

Implement a **`ToolRegistry`** actor mapping tool name → `ToolExecutor`, plus a **`ToolOrchestrator`** for multi-step loops.

```swift
protocol ToolExecutor: Sendable {
    var definition: ToolDefinition { get }
    func execute(argumentsJSON: String) async throws -> String
}
```

Flow:

1. `ToolRegistry.definitions` → passed in `ChatRequest.tools`
2. LLM returns `ToolCallRequest` with name + arguments JSON
3. `ToolRegistry.execute(call:)` validates and runs local executor
4. Result appended as `role: .tool` message
5. Loop until no more tool calls or `maxSteps` reached

Default tools: Weather, Calendar, Reminders, Contacts, Notes, Clipboard, Search (demo implementations).

## Consequences

### Positive

- **End-to-end demo** — shows function calling lifecycle without mocking tool results.
- **Argument validation** — JSON parsing errors surface as `ToolCallResult(isError: true)`.
- **Extensible** — `register(_ executor:)` adds tools; MCP tools can register later.
- **Separation** — tool *definitions* go to LLM; tool *execution* stays on device.

### Negative

- **Demo stubs** — Reminders/Calendar don't call real EventKit yet (Roadmap Phase 2).
- **Provider parsing gap** — non-streaming `complete()` path assumes tool calls in response; streaming tool deltas need per-provider parsers.
- **Security** — production apps must sandbox tool permissions; demo trusts all registered tools.
- **Schema sync** — `ToolDefinition.parameters` must match what the model actually sends.

## Alternatives Considered

| Alternative | Why not |
|-------------|---------|
| **Hard-coded if/else on user text** | Fakes AI; fails interview "show real tool calling" question. |
| **MCP-only tools** | MCP is Phase 3; local registry needed first. |
| **Apple App Intents as tools** | Great future integration; adds permission complexity for Phase 1. |
| **Server-side tool execution** | Violates on-device action story; adds backend dependency. |
| **Single monolithic `executeTool(name:)` switch** | Works but violates open/closed principle; registry is cleaner. |

## Interview Sound Bite

> "Tools are registered locally with JSON Schema definitions sent to the LLM. The orchestrator loops: model proposes a call → we execute on device → feed the result back → model continues. It's the same pattern ChatGPT Plugins and MCP use, just with a local registry."
