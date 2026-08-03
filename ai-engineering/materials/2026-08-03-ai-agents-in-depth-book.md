# AI Agents in Depth — book overview (Bojie Li)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `505892` |
| Related | [AI materials](README.md) |

---

## Выжимка

Книга Bojie Li про инженерию AI-агентов: формула **Agent = LLM + context + tools**, и всё, что вокруг модели, — реальная конкурентоспособность. PDF лежит в папке материалов.

## Обзор глав (1–10)

1. **Базовые знания об агенте.** Формула Agent = LLM + Context + Tools; инженерные возможности вне модели — то, что отличает продукт.

2. **Разработка контекста.** Контекст задаёт потолок агента: структура API, KV-cache-friendly дизайн, prompt engineering, dynamic prompts, skills, метаинформация в state string, стратегии сжатия контекста.

3. **Пользовательская память и база знаний.** Память между сессиями и доступ к внешним знаниям: user memory systems, базовые RAG-pipeline, structured indexes, knowledge maps — не только plain text.

4. **Tools — «руки» агента.** Классификация и дизайн инструментов, MCP и tool selection, perception/execution/collaboration tools, event-driven async agents.

5. **Programmer и генерация кода.** Код как мета-инструмент: пример production-grade coding agent как самого мощного универсального tool.

6. **Оценка агента.** От eval environment и dataset design до metrics, statistical significance, observability, eval-based selection, offline eval и production simulation.

7. **Post-training.** Три этапа: pre-training, SFT, RL — когда что выбирать и как это влияет на агента.

8–10. *(в PDF — продвинутые темы multi-agent, deployment и production patterns; см. полный текст.)*

## Формула

Agent = LLM + context + tools. PDF в папке материалов, если скачан.

## Артефакт

[`2026-08-03-ai-agents-in-depth/AI-Agents-in-Depth-Bojie-Li-v1.2.pdf`](2026-08-03-ai-agents-in-depth/AI-Agents-in-Depth-Bojie-Li-v1.2.pdf)
