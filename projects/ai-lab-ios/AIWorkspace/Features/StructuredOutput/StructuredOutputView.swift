import SwiftUI
import Observation

@Observable
@MainActor
final class StructuredOutputViewModel {
  var inputText = "Buy milk tomorrow, finish the SwiftUI module, call John on Friday"
  var rawJSON = ""
  var tasks: [ExtractedTask] = []
  var isLoading = false
  var errorMessage: String?

  private let providerRegistry: ProviderRegistry
  private let logger: AILogger
  private let metricsCollector: MetricsCollector

  init(providerRegistry: ProviderRegistry, logger: AILogger, metricsCollector: MetricsCollector) {
    self.providerRegistry = providerRegistry
    self.logger = logger
    self.metricsCollector = metricsCollector
  }

  func extract() {
    isLoading = true
    errorMessage = nil
    tasks = []
    rawJSON = ""

    Task {
      defer { isLoading = false }
      do {
        let provider = try providerRegistry.activeProvider()
        let model = providerRegistry.defaultModel()
        let systemPrompt = """
        Extract actionable tasks from user text.
        Return ONLY JSON with this schema:
        {"tasks":[{"title":"string","priority":"low|medium|high","due_date":"optional ISO date or null"}]}
        """

        let request = ChatRequest(
          messages: [ChatMessagePayload(role: .user, content: inputText)],
          systemPrompt: systemPrompt,
          model: model,
          temperature: 0,
          tools: [],
          responseFormat: .json(schema: nil),
          stream: false
        )

        let start = Date()
        let result = try await provider.complete(request)
        rawJSON = result.message.content

        do {
          tasks = try StructuredOutputParser.parseTasks(from: rawJSON)
        } catch {
          let recovery = StructuredOutputParser.recoveryPrompt(original: rawJSON, error: error.localizedDescription)
          let retry = try await provider.complete(
            ChatRequest(
              messages: [ChatMessagePayload(role: .user, content: recovery)],
              systemPrompt: systemPrompt,
              model: model,
              temperature: 0,
              tools: [],
              responseFormat: .json(schema: nil),
              stream: false
            )
          )
          rawJSON = retry.message.content
          tasks = try StructuredOutputParser.parseTasks(from: rawJSON)
        }

        await metricsCollector.record(
          RequestMetrics(
            id: UUID(),
            module: "StructuredOutput",
            provider: model.provider,
            model: model.id,
            timeToFirstToken: nil,
            fullResponseTime: Date().timeIntervalSince(start),
            promptTokens: result.usage?.promptTokens ?? 0,
            completionTokens: result.usage?.completionTokens ?? 0,
            estimatedCostUSD: result.usage?.estimatedCostUSD ?? 0,
            timestamp: .now
          )
        )
      } catch {
        errorMessage = error.localizedDescription
      }
    }
  }
}

struct StructuredOutputView: View {
  @Bindable var viewModel: StructuredOutputViewModel

  var body: some View {
    Form {
      Section("Input") {
        TextEditor(text: $viewModel.inputText)
          .frame(minHeight: 100)
        Button(viewModel.isLoading ? "Extracting..." : "Extract Tasks") {
          viewModel.extract()
        }
        .disabled(viewModel.isLoading)
      }

      if !viewModel.rawJSON.isEmpty {
        Section("Raw JSON") {
          Text(viewModel.rawJSON)
            .font(.caption.monospaced())
            .textSelection(.enabled)
        }
      }

      if !viewModel.tasks.isEmpty {
        Section("Swift Codable Models") {
          ForEach(viewModel.tasks) { task in
            VStack(alignment: .leading, spacing: 4) {
              Text(task.title).font(.headline)
              Text("Priority: \(task.priority)")
                .font(.caption)
                .foregroundStyle(.secondary)
              if let due = task.dueDate {
                Text("Due: \(due)")
                  .font(.caption)
                  .foregroundStyle(.secondary)
              }
            }
          }
        }
      }

      if let error = viewModel.errorMessage {
        Section {
          Text(error).foregroundStyle(.red)
        }
      }
    }
    .navigationTitle("Structured Output")
  }
}
