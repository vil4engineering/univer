import SwiftUI
import Observation

@Observable
@MainActor
final class SettingsViewModel {
  private let settingsStore: SettingsStore

  init(settingsStore: SettingsStore) {
    self.settingsStore = settingsStore
  }

  var openAIKey: String {
    get { settingsStore.openAIAPIKey }
    set { settingsStore.openAIAPIKey = newValue }
  }

  var anthropicKey: String {
    get { settingsStore.anthropicAPIKey }
    set { settingsStore.anthropicAPIKey = newValue }
  }

  var geminiKey: String {
    get { settingsStore.geminiAPIKey }
    set { settingsStore.geminiAPIKey = newValue }
  }

  var systemPrompt: String {
    get { settingsStore.defaultSystemPrompt }
    set { settingsStore.defaultSystemPrompt = newValue }
  }

  var temperature: Double {
    get { settingsStore.defaultTemperature }
    set { settingsStore.defaultTemperature = newValue }
  }

  var enableCaching: Bool {
    get { settingsStore.enableCaching }
    set { settingsStore.enableCaching = newValue }
  }

  var enableLogging: Bool {
    get { settingsStore.enableLogging }
    set { settingsStore.enableLogging = newValue }
  }
}

struct SettingsView: View {
  @Bindable var viewModel: SettingsViewModel

  var body: some View {
    Form {
      Section("API Keys") {
        SecureField("OpenAI API Key", text: $viewModel.openAIKey)
        SecureField("Anthropic API Key", text: $viewModel.anthropicKey)
        SecureField("Gemini API Key", text: $viewModel.geminiKey)
      }

      Section("Defaults") {
        TextField("System Prompt", text: $viewModel.systemPrompt, axis: .vertical)
        HStack {
          Text("Temperature")
          Slider(value: $viewModel.temperature, in: 0...1)
          Text(String(format: "%.1f", viewModel.temperature)).monospacedDigit()
        }
      }

      Section("Features") {
        Toggle("Enable Caching", isOn: $viewModel.enableCaching)
        Toggle("Enable Logging", isOn: $viewModel.enableLogging)
      }
    }
    .navigationTitle("Settings")
  }
}
