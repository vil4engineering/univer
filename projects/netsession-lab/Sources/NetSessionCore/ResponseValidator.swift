import Foundation

// Stage 6: Response — validate HTTP status before JSONDecoder sees the body.

public struct ResponseValidator: Sendable {
    public var acceptableStatusCodes: Set<Int>

    public init(acceptableStatusCodes: Set<Int> = Set(200 ... 299)) {
        self.acceptableStatusCodes = acceptableStatusCodes
    }

    public func validate(data: Data, response: URLResponse) throws -> Data {
        // Step 6.1 — require HTTPURLResponse; plain URLResponse is a transport shape mismatch.
        guard let http = response as? HTTPURLResponse else {
            throw NetSessionError.transport(.badServerResponse)
        }

        // Step 6.2 — map non-2xx to httpStatus with body preserved for error parsing upstream.
        guard acceptableStatusCodes.contains(http.statusCode) else {
            throw NetSessionError.httpStatus(http.statusCode, data)
        }

        // Step 6.3 — success: return raw data for decoding (Stage 7 decode path in HTTPClient).
        return data
    }
}
