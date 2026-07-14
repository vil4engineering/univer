import Foundation

// Stage 2: URLRequest — Endpoint describes one call; EndpointBuilder builds URLRequest.

public protocol Endpoint: Sendable {
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension Endpoint {
    public var method: String { "GET" }
    public var queryItems: [URLQueryItem]? { nil }
    public var headers: [String: String] { [:] }
    public var body: Data? { nil }
    public var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
}

public struct AnyEndpoint: Endpoint, Sendable {
    public let baseURL: URL
    public let path: String
    public let method: String
    public let queryItems: [URLQueryItem]?
    public let headers: [String: String]
    public let body: Data?
    public let cachePolicy: URLRequest.CachePolicy

    public init(
        baseURL: URL,
        path: String,
        method: String = "GET",
        queryItems: [URLQueryItem]? = nil,
        headers: [String: String] = [:],
        body: Data? = nil,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
        self.cachePolicy = cachePolicy
    }
}

public enum EndpointBuilder {
    public static func makeRequest(baseURL: URL, endpoint: some Endpoint) throws -> URLRequest {
        // Step 2.1 — normalize path (no leading slash duplication with baseURL).
        let trimmedPath = endpoint.path.hasPrefix("/") ? String(endpoint.path.dropFirst()) : endpoint.path

        // Step 2.2 — append path segments to base URL.
        var url = baseURL
        if !trimmedPath.isEmpty {
            url = url.appending(path: trimmedPath)
        }

        // Step 2.3 — attach query items with proper percent-encoding via URLComponents.
        if let queryItems = endpoint.queryItems, !queryItems.isEmpty {
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                throw NetSessionError.invalidURL
            }
            components.queryItems = queryItems
            guard let composed = components.url else {
                throw NetSessionError.invalidURL
            }
            url = composed
        }

        // Step 2.4 — build URLRequest: method, body, per-request cache policy.
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        request.cachePolicy = endpoint.cachePolicy

        // Step 2.5 — merge headers (auth, accept, etc.) onto the request.
        for (name, value) in endpoint.headers {
            request.setValue(value, forHTTPHeaderField: name)
        }

        // Step 2.6 — hand off to HTTPClient.send; no network yet.
        return request
    }
}
