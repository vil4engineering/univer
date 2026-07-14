import Foundation
import SwiftData

actor AILogger: AIRequestLogger {
  private let modelContext: ModelContext
  private var pendingTraces: [DebugTrace] = []

  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }

  func logRequest(
    module: String,
    provider: AIProviderKind,
    model: String,
    systemPrompt: String?,
    prompt: String,
    tools: [ToolDefinition]
  ) async {
    let toolsJSON = tools.isEmpty ? nil : encodeTools(tools)
    let entry = AILogEntry(
      module: module,
      providerRaw: provider.rawValue,
      model: model,
      systemPrompt: systemPrompt,
      prompt: prompt,
      toolsJSON: toolsJSON
    )
    modelContext.insert(entry)
    try? modelContext.save()

    pendingTraces.append(
      DebugTrace(
        id: entry.id,
        module: module,
        systemPrompt: systemPrompt,
        prompt: prompt,
        tools: tools,
        rawResponse: nil,
        jsonPayload: nil,
        error: nil,
        timestamp: .now
      )
    )
  }

  func logResponse(
    module: String,
    rawResponse: String?,
    jsonPayload: String?,
    usage: TokenUsage?,
    error: AIError?
  ) async {
  }

  func recentTraces(limit: Int) async -> [DebugTrace] {
    let descriptor = FetchDescriptor<AILogEntry>(
      sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
    )
    let entries = (try? modelContext.fetch(descriptor)) ?? []
    return entries.prefix(limit).map { entry in
      DebugTrace(
        id: entry.id,
        module: entry.module,
        systemPrompt: entry.systemPrompt,
        prompt: entry.prompt,
        tools: [],
        rawResponse: entry.rawResponse,
        jsonPayload: entry.jsonPayload,
        error: entry.errorMessage,
        timestamp: entry.timestamp
      )
    }
  }

  private func encodeTools(_ tools: [ToolDefinition]) -> String? {
    let payload = tools.map { ["name": $0.name, "description": $0.description] }
    guard let data = try? JSONSerialization.data(withJSONObject: payload) else { return nil }
    return String(data: data, encoding: .utf8)
  }
}

actor MetricsCollector: MetricsTracking {
  private var metrics: [RequestMetrics] = []

  func record(_ metrics: RequestMetrics) async {
    self.metrics.insert(metrics, at: 0)
    if self.metrics.count > 200 {
      self.metrics.removeLast()
    }
  }

  func recentMetrics(limit: Int) async -> [RequestMetrics] {
    Array(metrics.prefix(limit))
  }

  func aggregate() async -> MetricsSummary {
    guard !metrics.isEmpty else {
      return MetricsSummary(
        totalRequests: 0,
        averageTTFT: 0,
        averageFullResponse: 0,
        totalPromptTokens: 0,
        totalCompletionTokens: 0,
        totalEstimatedCostUSD: 0
      )
    }

    let ttftValues = metrics.compactMap(\.timeToFirstToken)
    let avgTTFT = ttftValues.isEmpty ? 0 : ttftValues.reduce(0, +) / Double(ttftValues.count)
    let avgFull = metrics.map(\.fullResponseTime).reduce(0, +) / Double(metrics.count)

    return MetricsSummary(
      totalRequests: metrics.count,
      averageTTFT: avgTTFT,
      averageFullResponse: avgFull,
      totalPromptTokens: metrics.map(\.promptTokens).reduce(0, +),
      totalCompletionTokens: metrics.map(\.completionTokens).reduce(0, +),
      totalEstimatedCostUSD: metrics.map(\.estimatedCostUSD).reduce(0, +)
    )
  }
}

actor CacheStore: AICacheStore {
  private let modelContext: ModelContext
  private var embeddingCache: [String: [Float]] = [:]

  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }

  func response(for key: String) async -> String? {
    var descriptor = FetchDescriptor<CachedResponse>(
      predicate: #Predicate { $0.cacheKey == key }
    )
    descriptor.fetchLimit = 1
    return try? modelContext.fetch(descriptor).first?.response
  }

  func store(response: String, for key: String) async {
    let cached = CachedResponse(cacheKey: key, response: response)
    modelContext.insert(cached)
    try? modelContext.save()
  }

  func embedding(for text: String) async -> [Float]? {
    embeddingCache[text]
  }

  func store(embedding: [Float], for text: String) async {
    embeddingCache[text] = embedding
  }
}
