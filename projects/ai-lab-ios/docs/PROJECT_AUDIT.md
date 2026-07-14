# Аудит проекта AI Workspace

Дата: июль 2026  
Статус: **Phase 1 завершена** → переход к Phase 2

Этот документ — рабочий аудит: что сделано, что планируется, в каком порядке работать, и как измерять готовность к интервью.

---

## 1. Цель проекта (напоминание)

Портфолио-приложение, которое позволяет **уверенно ответить** на вопрос:

> «Какие AI-сценарии вы лично реализовывали?»

Критерий готовности — не «все фичи работают», а **умение объяснить архитектуру и trade-offs** на техническом интервью.

---

## 2. Что уже сделано (Phase 1)

### Код

| Область | Статус | Комментарий |
|---------|--------|-------------|
| Структура проекта (MVVM, Feature Modules) | ✅ | 12 экранов, `AppContainer` DI |
| Provider abstraction | ✅ | OpenAI, Anthropic, Gemini, FM scaffold |
| Chat + SSE streaming | ✅ | cancel, retry, regenerate, metrics |
| Structured Output | ✅ | JSON → Codable + recovery |
| Tool Registry + Orchestrator | ✅ | 7 demo tools, multi-step loop |
| Voice pipeline | ✅ | Speech → LLM → TTS (on-device) |
| Vision | ✅ | PhotosPicker + vision API |
| RAG (Documents) | ✅ | chunk → embed → search → answer |
| Memory | ✅ | semantic store + context injection |
| Models / Foundation Models | ✅ | switching + capability matrix |
| MCP | 🔶 | scaffold only |
| Debug + Metrics | ✅ | TTFT, tokens, cost, traces |
| SwiftData | ✅ | chat, logs, cache, memory metadata |
| Unit tests | 🔶 | vector math, chunker, JSON parser |

### Документация

| Документ | Статус |
|----------|--------|
| README + Mermaid диаграммы | ✅ |
| `docs/ARCHITECTURE.md` | ✅ |
| `docs/ROADMAP.md` | ✅ |
| `docs/adr/` (12 ADR) | ✅ |
| Скриншоты / GIF | ❌ |
| Lessons Learned (в README) | ✅ кратко |

### ADR (Architecture Decision Records)

| # | Тема |
|---|------|
| 0001 | Provider abstraction |
| 0002 | AsyncSequence для стриминга |
| 0003 | SwiftData vs SQLite |
| 0004 | MVVM + Observation |
| 0005 | Protocol-first AI layer |
| 0006 | In-memory vector store |
| 0007 | Feature modules + DI |
| 0008 | Local tool registry |
| 0009 | Unified embedding provider |
| 0010 | Actor isolation |
| 0011 | **SSE vs WebSocket** |
| 0012 | **RAG vs fine-tuning** |

---

## 3. Что НЕ сделано (честный gap-анализ)

### Критичные для демо на интервью

| Gap | Риск на интервью | Приоритет |
|-----|------------------|-----------|
| Tool calling в **streaming** (реальный parse deltas) | «Покажите tool call в реальном времени» — сейчас только `complete()` path | **P0** |
| Проект **не собран на устройстве** с реальными API keys | Нет скриншотов, нет уверенности что код компилируется | **P0** |
| PDFKit extraction | Documents принимает только paste text | P1 |
| Persistent vector store | Векторы теряются при перезапуске | P1 |
| Foundation Models live | Только scaffold + error | P2 |
| MCP реальное подключение | Только placeholder | P2 |
| Real EventKit / Reminders | Demo stubs | P2 |

### Технический долг

- `ProviderRegistry` и providers на `@unchecked Sendable` — нужна чёткая MainActor граница для `SettingsStore`
- Gemini embedding — stub с throw
- OpenAI streaming — не парсит tool call deltas
- Сгенерированный `.xcodeproj` — лучше `xcodegen generate` на Mac
- Нет CI (build + tests на macOS runner)

---

## 4. План работы по фазам

### Phase 2 — «Работает на реальном устройстве» (следующий шаг)

**Цель:** открыть на iPhone, ввести API key, прогнать все модули, сделать скриншоты.

| # | Задача | Модуль | Результат |
|---|--------|--------|-----------|
| 2.1 | Сборка в Xcode, фикс compile errors | — | Проект билдится |
| 2.2 | E2E тест Chat streaming с OpenAI key | Chat | TTFT на экране |
| 2.3 | Tool calling streaming parse (OpenAI) | Tools | Видно tool call в Debug |
| 2.4 | PDFKit text extraction | Documents | Загрузка PDF → index |
| 2.5 | Скриншоты всех модулей | — | `docs/screenshots/` |
| 2.6 | Persistent vector store (sqlite-vec или JSON cache) | Documents, Memory | Переживает restart |

### Phase 3 — «Глубина для senior-интервью»

| # | Задача | Зачем |
|---|--------|-------|
| 3.1 | Anthropic + Gemini tool calling | Multi-provider depth |
| 3.2 | MCP transport (SSE) + Filesystem server | MCP на резюме |
| 3.3 | Rate limiting + retry middleware | Production thinking |
| 3.4 | Real pricing tables в Metrics | Cost awareness |
| 3.5 | Foundation Models integration | Cloud vs on-device demo |

### Phase 4 — «Портфолио упаковка»

| # | Задача |
|---|--------|
| 4.1 | GIF: Chat streaming + Tool calling |
| 4.2 | Blog post / interview prep sheet |
| 4.3 | GitHub README badges, demo video |
| 4.4 | CI: macOS build + unit tests |

---

## 5. Как мы работаем (процесс)

### Принцип: «Документация → Код → Демо → ADR если новое решение»

```
Идея / вопрос с интервью
    ↓
Нужно новое архитектурное решение?
    ├── Да → пишем ADR (context → decision → trade-offs)
    └── Нет → сразу в код
    ↓
Реализация в feature branch (cursor/<topic>-8aa9)
    ↓
Проверка на устройстве / симуляторе
    ↓
Обновить ROADMAP + README если нужно
    ↓
Commit (Conventional Commits) → Push → PR
```

### Порядок приоритетов

1. **Понимание** — ADR, архитектурные диаграммы (не скипать)
2. **Вертикальный срез** — один модуль end-to-end с реальным API
3. **Горизонталь** — polish, edge cases, persistence
4. **Упаковка** — скриншоты, GIF, blog

### Правила для коммитов

```
feat(chat): add OpenAI tool call delta parsing in stream
fix(tools): handle cancelled tool execution
docs(adr): add SSE vs WebSocket decision record
chore(ci): add macOS build workflow
```

Один коммит = одно логическое изменение.

### Ветки

- `main` — стабильная база
- `cursor/<descriptive-name>-8aa9` — рабочие ветки
- Один PR может накапливать несколько коммитов одной фазы

### Definition of Done для модуля

- [ ] Работает с реальным API key
- [ ] Есть метрики в Debug screen
- [ ] ViewModel не знает конкретный provider
- [ ] Можно объяснить за 2 минуты на whiteboard
- [ ] Скриншот в `docs/screenshots/`
- [ ] Если новое решение — ADR или обновление существующего

---

## 6. Чеклист готовности к интервью

### Могу нарисовать на доске

- [x] Слои: UI → VM → AI → Data
- [x] Request lifecycle (UI → stream → SSE → UI)
- [x] RAG pipeline (chunk → embed → search → generate)
- [x] Tool calling loop
- [ ] MCP protocol (после Phase 3)

### Могу объяснить с trade-offs

- [x] Provider abstraction (ADR-0001)
- [x] Streaming / SSE vs WebSocket (ADR-0002, ADR-0011)
- [x] RAG vs fine-tuning (ADR-0012)
- [x] SwiftData vs vectors separation (ADR-0003, ADR-0006)
- [x] Почему actors (ADR-0010)
- [ ] Почему tool calling сложнее в streaming (после 2.3)

### Могу показать вживую

- [ ] Chat streaming на симуляторе
- [ ] Tool call «Remind me tomorrow to call John»
- [ ] RAG с citation
- [ ] Debug screen с TTFT и tokens

---

## 7. Рекомендуемый следующий шаг

**Не новая фича. Не новый ADR.**

1. Открыть проект в Xcode на Mac
2. `xcodegen generate` (или поправить `.xcodeproj`)
3. Добавить OpenAI API key в Settings
4. Прогнать Chat → Tools → Documents → Debug
5. Зафиксировать compile/runtime issues
6. Скриншоты → Phase 2.5

После первой успешной сборки — **Phase 2.3** (tool calling в streaming) как самый сильный interview demo.

---

## 8. Карта документов

```
README.md              ← входная точка, диаграммы, resume bullets
docs/
├── ARCHITECTURE.md    ← слои, flows, scaling
├── ROADMAP.md         ← фазы и чеклисты
├── PROJECT_AUDIT.md   ← этот файл (статус + процесс)
├── adr/               ← почему приняли решения
│   ├── README.md      ← индекс + interview tips
│   └── 0001–0012      ← отдельные решения
└── screenshots/       ← визуальные доказательства (пока пусто)
```

---

## 9. Резюме одной строкой

> **Фундамент и 12 ADR готовы. Следующий рывок — собрать на Mac, прогнать с реальными ключами, снять скриншоты, допилить tool calling в streaming. Документация опережает runtime-проверку — это главный риск.**
