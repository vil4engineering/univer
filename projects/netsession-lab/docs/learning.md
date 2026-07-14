# Learning sources

## Primary article (theory)

**[URLSession lifecycle — iOS IQ](https://iosiq.ru/urlsession-lifecycle.html)**

Use this article as the **main reference** while studying NetSessionLab. The repo implements **Phase 1** of that material; Phases 2–4 in the article are roadmap only (see `architecture.md` STOP).

### How to study

| You want… | Where to go |
|-----------|-------------|
| Full narrative, animations, edge cases | Read the [article](https://iosiq.ru/urlsession-lifecycle.html) yourself |
| Quick map question → this codebase | `cheatsheet.md` |
| Who waits for whom in Phase 1 | `README.md` diagrams |
| Ask in chat | Agent answers from **this repo + article**; can quote article sections on request |

You can read the article end-to-end, or ask here step-by-step — both are fine.

### Article section → repo file

| iOS IQ topic (article) | NetSessionLab (Phase 1) |
|------------------------|-------------------------|
| Stage 1 Configuration | `SessionConfiguration.swift` (steps 1.1–1.7) |
| Stage 2 URLRequest | `Endpoint.swift` (2.1–2.6) |
| Stages 3–4 Task / resume | `HTTPClient.swift` (Step D) |
| Stage 5 Network I/O | system; tests: `MockURLProtocol.swift` (5.M1–5.M6) |
| Stage 6 Response / cache | `ResponseValidator.swift` (6.1–6.3) |
| Stage 7 Complete / retry / cancel | `HTTPClient`, `RetryPolicy`, `NetSessionError` |
| Unit tests without network | `MockURLProtocol` + `SessionConfiguration.makeForTesting` |
| Not in Phase 1 | background session, WebSocket, metrics, streaming — article only for now |

### Offline copy (Career repo)

Full text snapshot (if the site is down):

`~/Developer/GitHub/Career/_import/urlsession-lifecycle-iosiq-full.md`

Shorter notes:

`~/Developer/GitHub/Career/V. Данные и сеть/20 Networking …/notes/URLSession-Lifecycle-iOS-IQ.md`

## This repo (practice)

```bash
swift test
```

Read step comments in `Sources/NetSessionCore/` — labels match the article’s seven stages.
