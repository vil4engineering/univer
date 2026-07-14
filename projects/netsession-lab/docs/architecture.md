# Architecture

## Current layout (Phase 1)

```
netsession-lab/
├── Package.swift
├── Sources/NetSessionCore/
├── Tests/NetSessionCoreTests/
├── docs/
│   ├── architecture.md
│   └── cheatsheet.md
└── README.md
```

`Demo/`, `ImageLoading`, `TMDBKit` — **not implemented**. Do not add until Phase 2 is explicitly started.

## Design principles

- Seven-stage URLSession lifecycle drives structure and comments
- Unit tests never hit the real network
- Domain errors at the boundary, not raw `URLError` in UI
- iOS 18+, Swift 6, strict concurrency

## Phase 1 — Core + tests ✅

- `Endpoint` protocol and `EndpointBuilder`
- `HTTPClient` with explicit `URLSessionConfiguration` (not `shared`)
- `ResponseValidator` — transport vs HTTP vs decoding errors
- `RetryPolicy` — exponential backoff + jitter; no retry on cancel
- `MockURLProtocol` in test target
- Swift Testing: validate, retry policy, mock client, **cancel**, **503→200 retry**

---

## 🛑 STOP — Phase 1 is enough for interview prep

**Do not implement below** until you finish interview prep or consciously start Phase 2.

Out of scope for now:

- Interceptors, `URLSessionTaskMetrics`, offline cache
- Streaming (`bytes(for:)`), WebSocket, background downloads
- TMDB module, `ImageLoader`, SwiftUI demo
- GraphQL, multipart upload, download resume

If tempted to add these “just one small thing” — read `docs/cheatsheet.md` and run `swift test` instead.

---

## Future roadmap (reference only)

### Phase 2 — TMDB demo

- Trending, search, detail, images
- SwiftUI + `@Observable`

### Phase 3 — Production patterns

- Interceptor chain, metrics, offline fixtures, download progress

### Phase 4 — Platform lab

- Background session, streaming, WebSocket, GraphQL target

## Related learning material

- **Primary article:** [iOS IQ — URLSession lifecycle](https://iosiq.ru/urlsession-lifecycle.html) — see `docs/learning.md`
- Career (local): `~/Developer/GitHub/Career/V. Данные и сеть/20 Networking …/notes/URLSession-Lifecycle-iOS-IQ.md`
- Offline snapshot: `~/Developer/GitHub/Career/_import/urlsession-lifecycle-iosiq-full.md`
