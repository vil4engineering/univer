import Foundation

// Stage 7: Complete — retry policy (sleep + loop in HTTPClient.send).

public struct RetryPolicy: Sendable {
    public var maxAttempts: Int
    public var baseDelaySeconds: Double
    public var jitterRange: ClosedRange<Double>

    public init(
        maxAttempts: Int = 3,
        baseDelaySeconds: Double = 0.5,
        jitterRange: ClosedRange<Double> = 0 ... 0.3
    ) {
        self.maxAttempts = max(1, maxAttempts)
        self.baseDelaySeconds = baseDelaySeconds
        self.jitterRange = jitterRange
    }

    public func shouldRetry(error: Error, attempt: Int) -> Bool {
        // Step 7.R1 — hard cap: no more attempts after maxAttempts.
        guard attempt < maxAttempts else { return false }

        // Step 7.R2 — never retry user/system cancel.
        if case .cancelled = error as? NetSessionError {
            return false
        }
        if error is CancellationError {
            return false
        }

        if let sessionError = error as? NetSessionError {
            switch sessionError {
            case .cancelled:
                return false
            // Step 7.R3 — transient transport (timeout, no network, DNS).
            case let .transport(code):
                return Self.retryableTransportCodes.contains(code)
            // Step 7.R4 — retry 408, 429, 5xx; not 401/404/422.
            case let .httpStatus(status, _):
                return status == 408 || status == 429 || (500 ... 599).contains(status)
            // Step 7.R5 — client mistakes and decode errors are final.
            case .invalidURL, .decoding:
                return false
            }
        }

        if let urlError = error as? URLError {
            if urlError.code == .cancelled { return false }
            return Self.retryableTransportCodes.contains(urlError.code)
        }

        return false
    }

    public func delayBeforeNextAttempt(attempt: Int) -> Duration {
        // Step 7.R6 — exponential backoff + jitter before the next loop iteration.
        let exponential = baseDelaySeconds * pow(2.0, Double(max(0, attempt - 1)))
        let jitter = Double.random(in: jitterRange)
        return .seconds(exponential + jitter)
    }

    private static let retryableTransportCodes: Set<URLError.Code> = [
        .timedOut,
        .networkConnectionLost,
        .notConnectedToInternet,
        .cannotConnectToHost,
        .cannotFindHost,
        .dnsLookupFailed,
    ]
}
