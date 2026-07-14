import SwiftUI
import Observation

@Observable
@MainActor
final class DebugViewModel {
  var traces: [DebugTrace] = []
  var metrics: [RequestMetrics] = []
  var summary: MetricsSummary?

  private let logger: AILogger
  private let metricsCollector: MetricsCollector

  init(logger: AILogger, metricsCollector: MetricsCollector) {
    self.logger = logger
    self.metricsCollector = metricsCollector
  }

  func refresh() {
    Task {
      traces = await logger.recentTraces(limit: 20)
      metrics = await metricsCollector.recentMetrics(limit: 20)
      summary = await metricsCollector.aggregate()
    }
  }
}

struct DebugView: View {
  @Bindable var viewModel: DebugViewModel

  var body: some View {
    List {
      if let summary = viewModel.summary {
        Section("Aggregate Metrics") {
          MetricsBadge(label: "Requests", value: "\(summary.totalRequests)")
          MetricsBadge(label: "Avg TTFT", value: String(format: "%.2fs", summary.averageTTFT))
          MetricsBadge(label: "Avg Total", value: String(format: "%.2fs", summary.averageFullResponse))
          MetricsBadge(label: "Prompt Tokens", value: "\(summary.totalPromptTokens)")
          MetricsBadge(label: "Completion Tokens", value: "\(summary.totalCompletionTokens)")
          MetricsBadge(label: "Est. Cost", value: String(format: "$%.4f", summary.totalEstimatedCostUSD))
        }
      }

      Section("Recent Traces") {
        if viewModel.traces.isEmpty {
          Text("No traces yet. Run any AI module first.")
            .foregroundStyle(.secondary)
        }
        ForEach(viewModel.traces) { trace in
          DisclosureGroup("\(trace.module) — \(trace.timestamp.formatted(date: .omitted, time: .shortened))") {
            if let system = trace.systemPrompt {
              LabeledContent("System Prompt", value: system)
            }
            LabeledContent("Prompt", value: trace.prompt)
            if let raw = trace.rawResponse {
              LabeledContent("Raw Response", value: raw)
            }
            if let json = trace.jsonPayload {
              LabeledContent("JSON", value: json)
            }
            if let error = trace.error {
              LabeledContent("Error", value: error)
            }
          }
        }
      }

      Section("Recent Metrics") {
        ForEach(viewModel.metrics) { metric in
          VStack(alignment: .leading, spacing: 4) {
            Text("\(metric.module) · \(metric.model)")
              .font(.headline)
            Text("TTFT: \(String(format: "%.2fs", metric.timeToFirstToken ?? 0)) · Total: \(String(format: "%.2fs", metric.fullResponseTime))")
              .font(.caption)
            Text("Tokens: \(metric.promptTokens + metric.completionTokens) · Cost: \(String(format: "$%.4f", metric.estimatedCostUSD))")
              .font(.caption2)
              .foregroundStyle(.secondary)
          }
        }
      }
    }
    .navigationTitle("Debug")
    .toolbar {
      Button("Refresh", action: viewModel.refresh)
    }
    .onAppear(perform: viewModel.refresh)
  }
}
