import Foundation

// Stage 5 (tests only): MockURLProtocol fakes network I/O for URLSession.

final class MockURLProtocol: URLProtocol, @unchecked Sendable {
    nonisolated(unsafe) static var requestHandler: (@Sendable (URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        // Step 5.M1 — URLSession asks: can this protocol handle the request? Tests: always yes.
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        // Step 5.M2 — URLSession resumed the task; we simulate network bytes (no real socket).
        guard let handler = Self.requestHandler else {
            client?.urlProtocol(self, didFailWithError: URLError(.unsupportedURL))
            return
        }

        do {
            let (response, data) = try handler(request)
            // Step 5.M3 — feed synthetic response headers to URLSession (Stage 6 input).
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            // Step 5.M4 — feed body chunks (one shot in tests).
            client?.urlProtocol(self, didLoad: data)
            // Step 5.M5 — signal completion; HTTPClient's await resumes.
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
        // Step 5.M6 — URLSession called cancel; in-flight task ends with .cancelled.
    }
}
