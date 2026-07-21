# MCP

Russian: Model Context Protocol

Category: Agents

Importance: Essential

Status: full

## Definition

MCP (Model Context Protocol) — открытый протокол, через который **host** (IDE, агент, приложение) подключает модели к внешним **tools**, **resources** и **prompts** единообразно.

## Why it matters

Вместо уникального glue-кода на каждый tool source — стандартный способ расширять контекст ассистента. Важен и для AI-assisted SE (Track 1), и для AI Technology (Track 2).

## Example

Cursor/IDE host подключает MCP-сервер с доступом к issue tracker: модель читает ticket и создаёт PR-комментарий через tool.

Короткая запись также в [iOS Glossary · MCP](../../../glossary/README.md#glossary-mcp).

## Related

- [Tool Calling](tool-calling.md)
- [AI Agent](ai-agent.md)
- [Topic: MCP](../../mcp/)
- [Glossary portal](../../../glossary/)
