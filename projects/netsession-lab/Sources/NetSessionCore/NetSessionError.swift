import Foundation

// Stage 7: Complete — domain error vocabulary for callers (not raw URLError).

public enum NetSessionError: Error, Equatable, Sendable {
    case invalidURL
    case transport(URLError.Code)
    case httpStatus(Int, Data)
    case decoding(Error)
    case cancelled
}

public extension NetSessionError {
    // Step 7.E1 — collapse Swift Concurrency and URLSession cancel into one domain case.
    static func mapTransport(_ error: Error) -> NetSessionError {
        if error is CancellationError {
            return .cancelled
        }
        if let urlError = error as? URLError {
            if urlError.code == .cancelled {
                return .cancelled
            }
            return .transport(urlError.code)
        }
        return .transport(.unknown)
    }
}

extension NetSessionError {
    public static func == (lhs: NetSessionError, rhs: NetSessionError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case let (.transport(left), .transport(right)):
            return left == right
        case let (.httpStatus(leftCode, leftData), .httpStatus(rightCode, rightData)):
            return leftCode == rightCode && leftData == rightData
        case (.cancelled, .cancelled):
            return true
        case let (.decoding(left), .decoding(right)):
            return left.localizedDescription == right.localizedDescription
        default:
            return false
        }
    }
}
