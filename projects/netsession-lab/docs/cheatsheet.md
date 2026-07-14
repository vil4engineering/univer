# NetSessionLab — interview cheatsheet (Phase 1)

One page before an interview. **Theory:** [iOS IQ — URLSession lifecycle](https://iosiq.ru/urlsession-lifecycle.html) (`docs/learning.md`). **Flow diagrams:** `README.md`. Run `swift test`.

## 7 stages → files

| Stage | What happens | File |
|-------|----------------|------|
| **1 Configuration** | Timeouts, cache, `waitsForConnectivity`, one session per client | `SessionConfiguration.swift` |
| **2 URLRequest** | `Endpoint` + `EndpointBuilder.makeRequest` | `Endpoint.swift` |
| **3 Create task** | `session.data(for:)` creates task in `.suspended` | `HTTPClient.swift` |
| **4 resume()** | Async API calls `resume()` internally | `HTTPClient.swift` |
| **5 Network I/O** | DNS / TLS / HTTP — system; we inject via `MockURLProtocol` in tests | `Tests/.../MockURLProtocol.swift` |
| **6 Response** | `ResponseValidator` checks `HTTPURLResponse` **before** `Decodable` | `ResponseValidator.swift` |
| **7 Complete** | Retry, cancel, domain errors | `HTTPClient.swift`, `RetryPolicy.swift`, `NetSessionError.swift` |

---

## Questions

### Why not `URLSession.shared` in a real client?

**File:** `SessionConfiguration.swift`, `HTTPClient.swift`

`shared` has no explicit timeouts, cache policy, or test doubles. One `URLSession` per `HTTPClient` keeps a connection pool and DI for `URLProtocol` mocks.

---

### Does URLSession treat HTTP 500 as an error?

**File:** `ResponseValidator.swift`

No. Any response with headers is “success” for URLSession. We throw `NetSessionError.httpStatus` in `ResponseValidator` before JSON decoding.

---

### Where do you validate status vs decode JSON?

**File:** `HTTPClient.swift`

`send(_:)` → `validator.validate` → then `decoder.decode`. Order: transport → HTTP status → body → `Decodable`.

---

### What errors cross the network boundary?

**File:** `NetSessionError.swift`

`invalidURL`, `transport(URLError.Code)`, `httpStatus(Int, Data)`, `decoding(Error)`, `cancelled`. UI should not match raw `URLError`.

---

### When do you retry? When not?

**File:** `RetryPolicy.swift`

Retry: 408, 429, 5xx, transient `URLError` (timeout, no network). **No** retry: 4xx (except 408/429), cancel, decode errors, 404.

---

### How do unit tests avoid the real network?

**File:** `MockURLProtocol.swift`, `SessionConfiguration.swift`

`makeForTesting(protocolClasses: [MockURLProtocol.self])` + handler returning `(HTTPURLResponse, Data)`. Never mutate `URLSession.shared`.

---

### What happens on `Task.cancel()`?

**File:** `HTTPClient.swift`, `NetSessionError.swift`

`session.data(for:)` throws `CancellationError` → `mapTransport` → `NetSessionError.cancelled`. `RetryPolicy` does not retry cancel.

---

### `timeoutIntervalForRequest` vs `timeoutIntervalForResource`?

**File:** `SessionConfiguration.swift`

Request = idle between network events (resets while bytes trickle). Resource = total budget for the whole task.

---

### Why typed `Endpoint` instead of raw `URLRequest` everywhere?

**File:** `Endpoint.swift`

One place for path, query, headers, method. Tests and API surface stay small; no scattered URL string concatenation.

---

### What is Phase 1 **not** doing?

**File:** `docs/architecture.md`

No interceptors, metrics, offline cache, streaming, WebSocket, background downloads, TMDB demo, `ImageLoader`. **STOP** after Phase 1 until you deliberately continue.
