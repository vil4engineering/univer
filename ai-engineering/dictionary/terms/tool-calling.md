# Tool Calling

Russian: вызов инструментов

Category: Agents

Importance: Essential

Status: full

## Definition

Tool Calling (function calling) — модель возвращает структурированный выбор функции и аргументов; runtime исполняет tool и может вернуть результат обратно в LLM.

## Why it matters

Мост между языком модели и реальными API/БД/устройством. Без tools LLM только генерирует текст.

## Example

```python
tools = [{"name": "get_weather", "parameters": {"city": "string"}}]
# модель: call get_weather(city="Berlin")
# app вызывает API и продолжает диалог
```

Swift: схемы tools / `@Generable` / Foundation Models tool API — тот же паттерн.

## Related

- [Function Calling](function-calling.md)
- [Structured Output](structured-output.md)
- [AI Agent](ai-agent.md)
- [Topic: Tool Calling](../../tool-calling/)
- [Glossary portal](../../../glossary/)
