import SwiftUI
import Observation

@Observable
@MainActor
final class MemoryViewModel {
  var newMemory = "I prefer British English."
  var query = "What language do I prefer?"
  var injectedContext = ""
  var storedMemories: [String] = []
  var isLoading = false
  var errorMessage: String?

  private let memoryService: MemoryService
  private let providerRegistry: ProviderRegistry
  private let logger: AILogger

  init(memoryService: MemoryService, providerRegistry: ProviderRegistry, logger: AILogger) {
    self.memoryService = memoryService
    self.providerRegistry = providerRegistry
    self.logger = logger
  }

  func saveMemory() {
    guard !newMemory.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
    isLoading = true
    errorMessage = nil

    Task {
      defer { isLoading = false }
      do {
        try await memoryService.storeMemory(content: newMemory)
        storedMemories.append(newMemory)
        newMemory = ""
      } catch {
        errorMessage = error.localizedDescription
      }
    }
  }

  func retrieveContext() {
    isLoading = true
    errorMessage = nil
    injectedContext = ""

    Task {
      defer { isLoading = false }
      do {
        injectedContext = try await memoryService.buildMemoryContext(for: query) ?? "No relevant memories found."
      } catch {
        errorMessage = error.localizedDescription
      }
    }
  }

  func askWithMemory() {
    retrieveContext()
    Task {
      try? await Task.sleep(for: .milliseconds(300))
      guard !injectedContext.isEmpty else { return }
      do {
        let provider = try providerRegistry.activeProvider()
        let model = providerRegistry.defaultModel()
        let prompt = """
        \(injectedContext)

        User question: \(query)
        """
        let result = try await provider.complete(
          ChatRequest(
            messages: [ChatMessagePayload(role: .user, content: prompt)],
            systemPrompt: "Use the provided memories to personalize your answer.",
            model: model,
            temperature: 0.3,
            tools: [],
            responseFormat: .text,
            stream: false
          )
        )
        injectedContext += "\n\nAssistant:\n" + result.message.content
      } catch {
        errorMessage = error.localizedDescription
      }
    }
  }
}

struct MemoryView: View {
  @Bindable var viewModel: MemoryViewModel

  var body: some View {
    Form {
      Section("Store Memory") {
        TextField("Memory to remember", text: $viewModel.newMemory, axis: .vertical)
        Button("Save to Vector Memory") { viewModel.saveMemory() }
      }

      if !viewModel.storedMemories.isEmpty {
        Section("Stored") {
          ForEach(viewModel.storedMemories, id: \.self) { memory in
            Text(memory)
          }
        }
      }

      Section("Retrieve") {
        TextField("Query", text: $viewModel.query, axis: .vertical)
        Button("Retrieve Relevant Context") { viewModel.retrieveContext() }
        Button("Ask with Memory Injection") { viewModel.askWithMemory() }
      }

      if !viewModel.injectedContext.isEmpty {
        Section("Injected Context") {
          Text(viewModel.injectedContext)
            .font(.caption)
            .textSelection(.enabled)
        }
      }

      if let error = viewModel.errorMessage {
        Section {
          Text(error).foregroundStyle(.red)
        }
      }
    }
    .navigationTitle("Memory")
  }
}
