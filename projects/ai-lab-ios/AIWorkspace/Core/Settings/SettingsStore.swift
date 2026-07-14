import Foundation
import Observation

@Observable
@MainActor
final class SettingsStore {
  private enum Keys {
    static let openAIKey = "apiKey.openai"
    static let anthropicKey = "apiKey.anthropic"
    static let geminiKey = "apiKey.gemini"
    static let defaultProvider = "defaultProvider"
    static let defaultModel = "defaultModel"
    static let systemPrompt = "chat.systemPrompt"
    static let temperature = "chat.temperature"
    static let enableCaching = "features.enableCaching"
    static let enableLogging = "features.enableLogging"
  }

  var openAIAPIKey: String {
    get { UserDefaults.standard.string(forKey: Keys.openAIKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: Keys.openAIKey) }
  }

  var anthropicAPIKey: String {
    get { UserDefaults.standard.string(forKey: Keys.anthropicKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: Keys.anthropicKey) }
  }

  var geminiAPIKey: String {
    get { UserDefaults.standard.string(forKey: Keys.geminiKey) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: Keys.geminiKey) }
  }

  var defaultProvider: AIProviderKind {
    get {
      let raw = UserDefaults.standard.string(forKey: Keys.defaultProvider) ?? AIProviderKind.openAI.rawValue
      return AIProviderKind(rawValue: raw) ?? .openAI
    }
    set { UserDefaults.standard.set(newValue.rawValue, forKey: Keys.defaultProvider) }
  }

  var defaultModelID: String {
    get { UserDefaults.standard.string(forKey: Keys.defaultModel) ?? "gpt-4o-mini" }
    set { UserDefaults.standard.set(newValue, forKey: Keys.defaultModel) }
  }

  var defaultSystemPrompt: String {
    get {
      UserDefaults.standard.string(forKey: Keys.systemPrompt)
        ?? "You are a helpful AI assistant in the AI Workspace demo app."
    }
    set { UserDefaults.standard.set(newValue, forKey: Keys.systemPrompt) }
  }

  var defaultTemperature: Double {
    get {
      let value = UserDefaults.standard.object(forKey: Keys.temperature) as? Double
      return value ?? 0.7
    }
    set { UserDefaults.standard.set(newValue, forKey: Keys.temperature) }
  }

  var enableCaching: Bool {
    get { UserDefaults.standard.object(forKey: Keys.enableCaching) as? Bool ?? true }
    set { UserDefaults.standard.set(newValue, forKey: Keys.enableCaching) }
  }

  var enableLogging: Bool {
    get { UserDefaults.standard.object(forKey: Keys.enableLogging) as? Bool ?? true }
    set { UserDefaults.standard.set(newValue, forKey: Keys.enableLogging) }
  }

  func apiKey(for provider: AIProviderKind) -> String {
    switch provider {
    case .openAI: openAIAPIKey
    case .anthropic: anthropicAPIKey
    case .gemini: geminiAPIKey
    case .foundationModels: ""
    }
  }

  func setAPIKey(_ value: String, for provider: AIProviderKind) {
    switch provider {
    case .openAI: openAIAPIKey = value
    case .anthropic: anthropicAPIKey = value
    case .gemini: geminiAPIKey = value
    case .foundationModels: break
    }
  }
}
