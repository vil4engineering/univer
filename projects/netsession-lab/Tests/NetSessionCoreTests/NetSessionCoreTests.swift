import Foundation
import NetSessionCore
import Testing

@Test func validateAcceptsSuccessStatus() throws {
    let validator = ResponseValidator()
    let response = HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!
    let data = Data("{}".utf8)
    let validated = try validator.validate(data: data, response: response)
    #expect(validated == data)
}

@Test func validateRejectsServerErrorBeforeDecoding() {
    let validator = ResponseValidator()
    let response = HTTPURLResponse(
        url: URL(string: "https://example.com")!,
        statusCode: 502,
        httpVersion: nil,
        headerFields: nil
    )!
    let body = Data("bad gateway".utf8)

    do {
        _ = try validator.validate(data: body, response: response)
        Issue.record("Expected httpStatus error")
    } catch let error as NetSessionError {
        guard case let .httpStatus(code, data) = error else {
            Issue.record("Wrong error type: \(error)")
            return
        }
        #expect(code == 502)
        #expect(data == body)
    } catch {
        Issue.record("Unexpected error: \(error)")
    }
}

@Test func retryPolicySkipsClientErrors() {
    let policy = RetryPolicy(maxAttempts: 3)
    let error = NetSessionError.httpStatus(404, Data())
    #expect(policy.shouldRetry(error: error, attempt: 1) == false)
}

@Test func retryPolicyAllowsTransientServerError() {
    let policy = RetryPolicy(maxAttempts: 3)
    let error = NetSessionError.httpStatus(503, Data())
    #expect(policy.shouldRetry(error: error, attempt: 1) == true)
    #expect(policy.shouldRetry(error: error, attempt: 3) == false)
}

@Test func retryPolicyAllowsTimedOutTransport() {
    let policy = RetryPolicy(maxAttempts: 3)
    let error = NetSessionError.transport(.timedOut)
    #expect(policy.shouldRetry(error: error, attempt: 1) == true)
    #expect(policy.shouldRetry(error: error, attempt: 3) == false)
}

@Test func endpointBuilderEncodesQueryItems() throws {
    let base = URL(string: "https://api.example.com/v3/")!
    let endpoint = AnyEndpoint(
        baseURL: base,
        path: "search",
        queryItems: [URLQueryItem(name: "q", value: "hello world")]
    )
    let request = try EndpointBuilder.makeRequest(baseURL: base, endpoint: endpoint)
    #expect(request.url?.absoluteString.contains("q=hello%20world") == true)
}

private struct Greeting: Decodable, Equatable {
    let message: String
}

@Suite(.serialized)
struct HTTPClientMockTests {
    @Test func taskCancelSurfacesCancelledError() async {
        let baseURL = URL(string: "https://api.example.com")!
        MockURLProtocol.requestHandler = { _ in
            Thread.sleep(forTimeInterval: 5)
            let response = HTTPURLResponse(
                url: baseURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data("{}".utf8))
        }
        defer { MockURLProtocol.requestHandler = nil }

        let configuration = SessionConfigurationFactory.makeForTesting(protocolClasses: [MockURLProtocol.self])
        let session = URLSession(configuration: configuration)
        let client = HTTPClient(baseURL: baseURL, session: session, retryPolicy: RetryPolicy(maxAttempts: 1))

        let task = Task {
            try await client.data(for: AnyEndpoint(baseURL: baseURL, path: "slow"))
        }
        task.cancel()

        do {
            _ = try await task.value
            Issue.record("Expected cancellation")
        } catch let error as NetSessionError {
            #expect(error == .cancelled)
        } catch is CancellationError {
            #expect(Bool(true))
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func retriesAfter503AndReturns200() async throws {
        let baseURL = URL(string: "https://api.example.com")!
        final class FailureBudget: @unchecked Sendable {
            var remaining = 1
        }
        let budget = FailureBudget()
        MockURLProtocol.requestHandler = { request in
            if budget.remaining > 0 {
                budget.remaining -= 1
                let response = HTTPURLResponse(
                    url: request.url!,
                    statusCode: 503,
                    httpVersion: nil,
                    headerFields: nil
                )!
                return (response, Data("unavailable".utf8))
            }
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, Data("{\"message\":\"ok\"}".utf8))
        }
        defer { MockURLProtocol.requestHandler = nil }

        let configuration = SessionConfigurationFactory.makeForTesting(protocolClasses: [MockURLProtocol.self])
        let session = URLSession(configuration: configuration)
        let client = HTTPClient(
            baseURL: baseURL,
            session: session,
            retryPolicy: RetryPolicy(maxAttempts: 2, baseDelaySeconds: 0, jitterRange: 0 ... 0)
        )

        let greeting: Greeting = try await client.send(
            AnyEndpoint(baseURL: baseURL, path: "flaky"),
            as: Greeting.self
        )
        #expect(greeting.message == "ok")
        #expect(budget.remaining == 0)
    }

    @Test func decodesJSONThroughMockProtocol() async throws {
        let baseURL = URL(string: "https://api.example.com")!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            let data = Data("{\"message\":\"ok\"}".utf8)
            return (response, data)
        }
        defer { MockURLProtocol.requestHandler = nil }

        let configuration = SessionConfigurationFactory.makeForTesting(protocolClasses: [MockURLProtocol.self])
        let session = URLSession(configuration: configuration)
        let client = HTTPClient(baseURL: baseURL, session: session, retryPolicy: RetryPolicy(maxAttempts: 1))

        let greeting: Greeting = try await client.send(
            AnyEndpoint(baseURL: baseURL, path: "greeting"),
            as: Greeting.self
        )
        #expect(greeting.message == "ok")
    }

    @Test func surfacesHTTPStatusWithoutDecoding() async {
        let baseURL = URL(string: "https://api.example.com")!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 401,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data("unauthorized".utf8))
        }
        defer { MockURLProtocol.requestHandler = nil }

        let configuration = SessionConfigurationFactory.makeForTesting(protocolClasses: [MockURLProtocol.self])
        let session = URLSession(configuration: configuration)
        let client = HTTPClient(baseURL: baseURL, session: session, retryPolicy: RetryPolicy(maxAttempts: 1))

        do {
            _ = try await client.data(for: AnyEndpoint(baseURL: baseURL, path: "secure"))
            Issue.record("Expected unauthorized error")
        } catch let error as NetSessionError {
            guard case let .httpStatus(code, _) = error else {
                Issue.record("Wrong error: \(error)")
                return
            }
            #expect(code == 401)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func retriesAfter429AndReturns200() async throws {
        let baseURL = URL(string: "https://api.example.com")!
        final class FailureBudget: @unchecked Sendable {
            var remaining = 1
            var hits = 0
        }
        let budget = FailureBudget()
        MockURLProtocol.requestHandler = { request in
            budget.hits += 1
            if budget.remaining > 0 {
                budget.remaining -= 1
                let response = HTTPURLResponse(
                    url: request.url!,
                    statusCode: 429,
                    httpVersion: nil,
                    headerFields: nil
                )!
                return (response, Data("rate limited".utf8))
            }
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, Data("{\"message\":\"ok\"}".utf8))
        }
        defer { MockURLProtocol.requestHandler = nil }

        let configuration = SessionConfigurationFactory.makeForTesting(protocolClasses: [MockURLProtocol.self])
        let session = URLSession(configuration: configuration)
        let client = HTTPClient(
            baseURL: baseURL,
            session: session,
            retryPolicy: RetryPolicy(maxAttempts: 2, baseDelaySeconds: 0, jitterRange: 0 ... 0)
        )

        let greeting: Greeting = try await client.send(
            AnyEndpoint(baseURL: baseURL, path: "limited"),
            as: Greeting.self
        )
        #expect(greeting.message == "ok")
        #expect(budget.remaining == 0)
        #expect(budget.hits == 2)
    }

    @Test func decodingFailureAfter200DoesNotRetry() async {
        let baseURL = URL(string: "https://api.example.com")!
        final class HitCounter: @unchecked Sendable {
            var hits = 0
        }
        let counter = HitCounter()
        MockURLProtocol.requestHandler = { request in
            counter.hits += 1
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, Data("not-json".utf8))
        }
        defer { MockURLProtocol.requestHandler = nil }

        let configuration = SessionConfigurationFactory.makeForTesting(protocolClasses: [MockURLProtocol.self])
        let session = URLSession(configuration: configuration)
        let client = HTTPClient(
            baseURL: baseURL,
            session: session,
            retryPolicy: RetryPolicy(maxAttempts: 3, baseDelaySeconds: 0, jitterRange: 0 ... 0)
        )

        do {
            _ = try await client.send(
                AnyEndpoint(baseURL: baseURL, path: "broken"),
                as: Greeting.self
            )
            Issue.record("Expected decoding error")
        } catch let error as NetSessionError {
            guard case .decoding = error else {
                Issue.record("Wrong error: \(error)")
                return
            }
            #expect(counter.hits == 1)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }
}
