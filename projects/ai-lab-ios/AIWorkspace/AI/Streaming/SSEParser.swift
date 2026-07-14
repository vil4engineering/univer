import Foundation

enum SSEParser {
  static func parseLines(from data: Data) -> [String] {
    guard let text = String(data: data, encoding: .utf8) else { return [] }
    return text
      .components(separatedBy: "\n")
      .map { $0.trimmingCharacters(in: .whitespaces) }
      .filter { !$0.isEmpty }
  }

  static func payload(from line: String) -> String? {
    guard line.hasPrefix("data:") else { return nil }
    let value = line.dropFirst(5).trimmingCharacters(in: .whitespaces)
    if value == "[DONE]" { return nil }
    return value
  }
}

struct HTTPClient: Sendable {
  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    try await URLSession.shared.data(for: request)
  }

  func bytes(for request: URLRequest) async throws -> URLSession.AsyncBytes {
    try await URLSession.shared.bytes(for: request)
  }
}

enum ProviderRequestBuilder {
  static func authorizedRequest(
    url: URL,
    method: String = "POST",
    apiKey: String,
    headerName: String = "Authorization",
    headerValuePrefix: String = "Bearer "
  ) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.setValue("\(headerValuePrefix)\(apiKey)", forHTTPHeaderField: headerName)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
  }
}

struct StreamingAccumulator {
  var text = ""
  var toolCalls: [String: ToolCallRequest] = [:]

  mutating func appendText(_ delta: String) {
    text += delta
  }
}
