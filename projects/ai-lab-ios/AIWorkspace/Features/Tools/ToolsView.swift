import SwiftUI
import Observation

@Observable
@MainActor
final class ToolsViewModel {
  var inputText = "Remind me tomorrow to call John."
  var response = ""
  var toolResults: [ToolCallResult] = []
  var isLoading = false
  var errorMessage: String?

  private let providerRegistry: ProviderRegistry
  private let toolRegistry: ToolRegistry
  private let logger: AILogger
  private let metricsCollector: MetricsCollector

  init(
    providerRegistry: ProviderRegistry,
    toolRegistry: ToolRegistry,
    logger: AILogger,
    metricsCollector: MetricsCollector
  ) {
    self.providerRegistry = providerRegistry
    self.toolRegistry = toolRegistry
    self.logger = logger
    self.metricsCollector = metricsCollector
  }

  var availableTools: [ToolDefinition] {
    get async { await toolRegistry.definitions }
  }

  func run() {
    isLoading = true
    errorMessage = nil
    response = ""
    toolResults = []

    Task {
      defer { isLoading = false }
      do {
        let provider = try providerRegistry.activeProvider()
        let model = providerRegistry.defaultModel()
        let orchestrator = ToolOrchestrator(registry: toolRegistry, provider: provider)
        let start = Date()

        let (message, results) = try await orchestrator.run(
          userMessage: inputText,
          systemPrompt: """
          You are an assistant with access to local tools.
          When the user asks to create reminders, notes, calendar events, or search — call the appropriate tool.
          """,
          model: model,
          temperature: 0.2
        )

        response = message.content
        toolResults = results

        await metricsCollector.record(
          RequestMetrics(
            id: UUID(),
            module: "Tools",
            provider: model.provider,
            model: model.id,
            timeToFirstToken: nil,
            fullResponseTime: Date().timeIntervalSince(start),
            promptTokens: 0,
            completionTokens: 0,
            estimatedCostUSD: 0,
            timestamp: .now
          )
        )
      } catch {
        errorMessage = error.localizedDescription
      }
    }
  }
}

struct ToolsView: View {
  @Bindable var viewModel: ToolsViewModel
  @State private var tools: [ToolDefinition] = []

  var body: some View {
    Form {
      Section("Tool Registry") {
        ForEach(tools) { tool in
          VStack(alignment: .leading, spacing: 4) {
            Text(tool.name).font(.headline.monospaced())
            Text(tool.description).font(.caption).foregroundStyle(.secondary)
          }
        }
      }

      Section("Prompt") {
        TextField("Ask the assistant", text: $viewModel.inputText, axis: .vertical)
        Button(viewModel.isLoading ? "Running..." : "Run Tool Calling") {
          viewModel.run()
        }
        .disabled(viewModel.isLoading)
      }

      if !viewModel.toolResults.isEmpty {
        Section("Tool Results") {
          ForEach(viewModel.toolResults) { result in
            VStack(alignment: .leading, spacing: 4) {
              Text(result.name).font(.headline.monospaced())
              Text(result.output)
                .font(.caption)
                .foregroundStyle(result.isError ? .red : .primary)
            }
          }
        }
      }

      if !viewModel.response.isEmpty {
        Section("Assistant Response") {
          MarkdownText(text: viewModel.response)
        }
      }

      if let error = viewModel.errorMessage {
        Section {
          Text(error).foregroundStyle(.red)
        }
      }
    }
    .navigationTitle("Tool Calling")
    .task {
      tools = await viewModel.availableTools
    }
  }
}
