import Foundation

// Stages 3–7: HTTPClient orchestrates task, I/O await, validate, retry, decode.

public struct HTTPClient: Sendable {
    public let baseURL: URL
    public let session: URLSession
    public let validator: ResponseValidator
    public let retryPolicy: RetryPolicy
    public let decoder: JSONDecoder

    public init(
        baseURL: URL,
        session: URLSession,
        validator: ResponseValidator = ResponseValidator(),
        retryPolicy: RetryPolicy = RetryPolicy(),
        decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
    ) {
        self.baseURL = baseURL
        self.session = session
        self.validator = validator
        self.retryPolicy = retryPolicy
        self.decoder = decoder
    }

    public func data(for endpoint: some Endpoint) async throws -> Data {
        // Step A — Stage 2: Endpoint → URLRequest (still no network).
        let request = try EndpointBuilder.makeRequest(baseURL: baseURL, endpoint: endpoint)
        return try await send(request)
    }

    public func send<Response: Decodable>(
        _ endpoint: some Endpoint,
        as type: Response.Type = Response.self
    ) async throws -> Response {
        // Step B — fetch bytes first (Stages 2–7 in send(request:)).
        let data = try await data(for: endpoint)
        do {
            // Step C — Stage 7 decode: only after HTTP status validated.
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw NetSessionError.decoding(error)
        }
    }

    public func send(_ request: URLRequest) async throws -> Data {
        var attempt = 0

        while true {
            attempt += 1

            do {
                // Step D — Stages 3–4: session.data(for:) creates a data task in .suspended,
                // then resumes it. Caller awaits here until the task completes or is cancelled.
                let (data, response) = try await session.data(for: request)

                // Step E — Stage 5 happened inside URLSession (DNS → TLS → HTTP).
                // In tests MockURLProtocol intercepts and returns synthetic bytes.

                // Step F — Stage 6: status check before returning data to the caller.
                return try validator.validate(data: data, response: response)

            } catch {
                // Step G — Stage 7: normalize to NetSessionError / keep domain errors.
                let mapped = Self.normalize(error)

                // Step H — Stage 7: ask RetryPolicy; throw if no retry or cap reached.
                guard retryPolicy.shouldRetry(error: mapped, attempt: attempt) else {
                    throw mapped
                }

                // Step I — Stage 7: cooperative sleep; Task.cancel() aborts this wait too.
                try await Task.sleep(for: retryPolicy.delayBeforeNextAttempt(attempt: attempt))

                // Step J — loop: same URLRequest, new task (Stages 3–4 again).
            }
        }
    }

    private static func normalize(_ error: Error) -> Error {
        if let sessionError = error as? NetSessionError {
            return sessionError
        }
        if error is DecodingError {
            return NetSessionError.decoding(error)
        }
        return NetSessionError.mapTransport(error)
    }
}
