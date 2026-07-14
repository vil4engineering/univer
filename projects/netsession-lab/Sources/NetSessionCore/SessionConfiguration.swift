import Foundation

// Stage 1: Configuration — URLSessionConfiguration is chosen once before URLSession exists.
// You cannot change these rules on a live session — create a new session instead.

public enum SessionConfigurationFactory {
    public static func makeDefault(
        memoryCacheMegabytes: Int = 20,
        diskCacheMegabytes: Int = 200,
        waitsForConnectivity: Bool = true
    ) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default

        // Step 1.1 — per-request idle timeout (resets while bytes trickle in).
        configuration.timeoutIntervalForRequest = 30

        // Step 1.2 — total budget for the whole task (all retries included).
        configuration.timeoutIntervalForResource = 120

        // Step 1.3 — wait for network instead of failing with .notConnectedToInternet immediately.
        configuration.waitsForConnectivity = waitsForConnectivity

        // Step 1.4 — default cache policy for requests that do not override cachePolicy.
        configuration.requestCachePolicy = .useProtocolCachePolicy

        // Step 1.5 — connection pool size per host (HTTP/2 multiplexes inside one connection).
        configuration.httpMaximumConnectionsPerHost = 4

        // Step 1.6 — disk + memory cache shared by all tasks on this session.
        let memoryBytes = memoryCacheMegabytes * 1024 * 1024
        let diskBytes = diskCacheMegabytes * 1024 * 1024
        configuration.urlCache = URLCache(
            memoryCapacity: memoryBytes,
            diskCapacity: diskBytes,
            directory: nil
        )

        // Step 1.7 — return read-only config; caller passes it to URLSession(configuration:).
        return configuration
    }

    public static func makeEphemeral() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.waitsForConnectivity = true
        return configuration
    }

    public static func makeForTesting(protocolClasses: [AnyClass]) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.ephemeral
        // Step 1.T — insert MockURLProtocol first so tests never hit the real network.
        configuration.protocolClasses = protocolClasses + (configuration.protocolClasses ?? [])
        configuration.urlCache = nil
        return configuration
    }
}
