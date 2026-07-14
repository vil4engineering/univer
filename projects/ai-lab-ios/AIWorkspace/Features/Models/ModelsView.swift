import SwiftUI
import Observation

@Observable
@MainActor
final class ModelsViewModel {
  var selectedProvider: AIProviderKind
  var selectedModelID: String
  var testResponse = ""
  var isTesting = false

  private let providerRegistry: ProviderRegistry
  private let settingsStore: SettingsStore

  init(providerRegistry: ProviderRegistry, settingsStore: SettingsStore) {
    self.providerRegistry = providerRegistry
    self.settingsStore = settingsStore
    selectedProvider = settingsStore.defaultProvider
    selectedModelID = settingsStore.defaultModelID
  }

  var allModels: [AIModelDescriptor] {
    providerRegistry.allModels()
  }

  var capabilityMatrix: [(AIProviderKind, ProviderCapabilities)] {
    providerRegistry.capabilityMatrix()
  }

  func applySelection() {
    settingsStore.defaultProvider = selectedProvider
    settingsStore.defaultModelID = selectedModelID
    providerRegistry.rebuildProviders()
  }

  func testProvider() {
    isTesting = true
    testResponse = ""

    Task {
      defer { isTesting = false }
      do {
        guard let model = providerRegistry.model(by: selectedModelID) else { return }
        let provider = try providerRegistry.provider(for: model.provider)
        let result = try await provider.complete(
          ChatRequest(
            messages: [ChatMessagePayload(role: .user, content: "Reply with one sentence confirming your model identity.")],
            systemPrompt: nil,
            model: model,
            temperature: 0,
            tools: [],
            responseFormat: .text,
            stream: false
          )
        )
        testResponse = result.message.content
      } catch {
        testResponse = error.localizedDescription
      }
    }
  }
}

struct ModelsView: View {
  @Bindable var viewModel: ModelsViewModel
  var highlightOnDevice: Bool = false

  var body: some View {
    Form {
      if highlightOnDevice {
        Section("Cloud vs On-Device") {
          comparisonRow("Latency", cloud: "Network dependent", onDevice: "Low")
          comparisonRow("Privacy", cloud: "Data sent to API", onDevice: "On-device only")
          comparisonRow("Offline", cloud: "Requires network", onDevice: "Available offline")
          comparisonRow("Capabilities", cloud: "Full vision/tools", onDevice: "Limited context")
        }
      }

      Section("Provider") {
        Picker("Provider", selection: $viewModel.selectedProvider) {
          ForEach(AIProviderKind.allCases) { provider in
            Label(provider.displayName, systemImage: provider.iconName).tag(provider)
          }
        }
      }

      Section("Model") {
        Picker("Model", selection: $viewModel.selectedModelID) {
          ForEach(viewModel.allModels.filter { $0.provider == viewModel.selectedProvider }) { model in
            Text(model.name).tag(model.id)
          }
        }
        Button("Apply Selection") { viewModel.applySelection() }
        Button(viewModel.isTesting ? "Testing..." : "Test Provider") {
          viewModel.testProvider()
        }
      }

      Section("Capability Matrix") {
        ForEach(viewModel.capabilityMatrix, id: \.0) { provider, caps in
          VStack(alignment: .leading, spacing: 4) {
            Text(provider.displayName).font(.headline)
            HStack {
              capabilityBadge("Stream", caps.streaming)
              capabilityBadge("Vision", caps.vision)
              capabilityBadge("Tools", caps.tools)
              capabilityBadge("JSON", caps.structuredOutput)
              capabilityBadge("Embed", caps.embeddings)
              capabilityBadge("Local", caps.onDevice)
            }
          }
        }
      }

      if !viewModel.testResponse.isEmpty {
        Section("Test Response") {
          Text(viewModel.testResponse)
        }
      }
    }
    .navigationTitle(highlightOnDevice ? "Foundation Models" : "Models")
  }

  private func comparisonRow(_ title: String, cloud: String, onDevice: String) -> some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(title).font(.caption.bold())
      HStack {
        VStack(alignment: .leading) {
          Text("Cloud").font(.caption2).foregroundStyle(.secondary)
          Text(cloud).font(.caption)
        }
        Spacer()
        VStack(alignment: .leading) {
          Text("On-Device").font(.caption2).foregroundStyle(.secondary)
          Text(onDevice).font(.caption)
        }
      }
    }
  }

  private func capabilityBadge(_ title: String, _ enabled: Bool) -> some View {
    Text(title)
      .font(.caption2)
      .padding(.horizontal, 6)
      .padding(.vertical, 3)
      .background(enabled ? Color.green.opacity(0.2) : Color.red.opacity(0.15), in: Capsule())
  }
}
