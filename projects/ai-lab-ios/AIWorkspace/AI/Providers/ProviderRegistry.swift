import Foundation

final class ProviderRegistry: @unchecked Sendable {
  let settings: SettingsStore
  private var providers: [AIProviderKind: any LLMProvider] = [:]

  init(settings: SettingsStore) {
    self.settings = settings
    rebuildProviders()
  }

  @MainActor
  func rebuildProviders() {
    providers = [
      .openAI: OpenAIProvider(settings: settings),
      .anthropic: AnthropicProvider(settings: settings),
      .gemini: GeminiProvider(settings: settings),
      .foundationModels: FoundationModelsProvider()
    ]
  }

  func provider(for kind: AIProviderKind) throws -> any LLMProvider {
    guard let provider = providers[kind] else {
      throw AIError.providerUnavailable(kind)
    }
    return provider
  }

  func activeProvider() throws -> any LLMProvider {
    try provider(for: settings.defaultProvider)
  }

  @MainActor
  func allModels() -> [AIModelDescriptor] {
    providers.values.flatMap(\.availableModels)
  }

  @MainActor
  func model(by id: String) -> AIModelDescriptor? {
    allModels().first { $0.id == id }
  }

  @MainActor
  func defaultModel() -> AIModelDescriptor {
    model(by: settings.defaultModelID) ?? allModels().first!
  }

  @MainActor
  func capabilityMatrix() -> [(AIProviderKind, ProviderCapabilities)] {
    AIProviderKind.allCases.compactMap { kind in
      guard let provider = providers[kind] else { return nil }
      return (kind, provider.capabilities)
    }
  }
}
