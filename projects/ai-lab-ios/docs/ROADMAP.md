# Roadmap

Phased implementation plan for AI Workspace portfolio.

## Phase 1 — Foundation (current)

- [x] Project structure & architecture
- [x] Provider abstraction (OpenAI, Anthropic, Gemini, Foundation Models scaffold)
- [x] DI container (`AppContainer`)
- [x] All feature module scaffolds
- [x] Chat with streaming
- [x] Structured Output
- [x] Tool Registry + Orchestrator
- [x] RAG pipeline
- [x] Memory service
- [x] Metrics & Debug screen
- [x] SwiftData persistence models
- [x] README & architecture docs
- [x] Architecture Decision Records (12 ADRs)
- [x] Project audit & working process (`docs/PROJECT_AUDIT.md`)

## Phase 2 — Polish & Real Integrations

- [ ] Full OpenAI tool call parsing in streaming
- [ ] Anthropic tool_use block handling
- [ ] Gemini function calling
- [ ] PDF text extraction (PDFKit)
- [ ] Persistent vector store (SQLite)
- [ ] Real Reminders / Calendar / Contacts integration
- [ ] Foundation Models live integration (iOS 26+)
- [ ] App icon & screenshots for GitHub

## Phase 3 — MCP & Advanced

- [ ] MCP transport client (stdio / SSE)
- [ ] Connect public MCP server (Filesystem, GitHub, or Notion)
- [ ] Wire MCP tools into `ToolOrchestrator`
- [ ] Background embedding refresh
- [ ] Rate limiting per provider
- [ ] Cost tracking with real pricing tables

## Phase 4 — Portfolio Assets

- [ ] Screenshots of each module
- [ ] Demo GIF (Chat streaming + Tool calling)
- [ ] Technical blog post / interview prep notes
- [ ] App Store-style demo video (optional)
