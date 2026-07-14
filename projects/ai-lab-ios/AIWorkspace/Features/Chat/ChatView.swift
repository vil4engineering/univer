import SwiftUI
import SwiftData
import Observation

@Observable
@MainActor
final class ChatViewModel {
  var messages: [ChatMessagePayload] = []
  var inputText = ""
  var systemPrompt: String
  var temperature: Double
  var selectedModel: AIModelDescriptor
  var isGenerating = false
  var streamingText = ""
  var errorMessage: String?
  var lastMetrics: RequestMetrics?

  private let providerRegistry: ProviderRegistry
  private let logger: AILogger
  private let metricsCollector: MetricsCollector
  private let cacheStore: CacheStore
  private let modelContext: ModelContext
  private var streamTask: Task<Void, Never>?
  private var currentSession: ChatSession?

  init(
    providerRegistry: ProviderRegistry,
    logger: AILogger,
    metricsCollector: MetricsCollector,
    cacheStore: CacheStore,
    modelContext: ModelContext
  ) {
    self.providerRegistry = providerRegistry
    self.logger = logger
    self.metricsCollector = metricsCollector
    self.cacheStore = cacheStore
    self.modelContext = modelContext
    systemPrompt = providerRegistry.settings.defaultSystemPrompt
    temperature = providerRegistry.settings.defaultTemperature
    selectedModel = providerRegistry.defaultModel()
  }

  func send() {
    let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !text.isEmpty else { return }

    let userMessage = ChatMessagePayload(role: .user, content: text)
    messages.append(userMessage)
    inputText = ""
    persist(userMessage)
    startStreaming()
  }

  func cancel() {
    streamTask?.cancel()
    streamTask = nil
    isGenerating = false
    if !streamingText.isEmpty {
      messages.append(ChatMessagePayload(role: .assistant, content: streamingText))
      streamingText = ""
    }
  }

  func retry() {
    guard let lastUser = messages.last(where: { $0.role == .user }) else { return }
    if messages.last?.role == .assistant {
      messages.removeLast()
    }
    inputText = lastUser.content
    messages.removeAll { $0.id == lastUser.id }
    send()
  }

  func regenerate() {
    guard messages.last?.role == .assistant else { return }
    messages.removeLast()
    startStreaming()
  }

  func selectModel(_ model: AIModelDescriptor) {
    selectedModel = model
    providerRegistry.settings.defaultModelID = model.id
    providerRegistry.settings.defaultProvider = model.provider
  }

  private func startStreaming() {
    streamTask?.cancel()
    isGenerating = true
    streamingText = ""
    errorMessage = nil

    streamTask = Task {
      let start = Date()
      var firstToken: Date?
      do {
        let provider = try providerRegistry.provider(for: selectedModel.provider)
        let request = ChatRequest(
          messages: messages,
          systemPrompt: systemPrompt,
          model: selectedModel,
          temperature: temperature,
          tools: [],
          responseFormat: .text,
          stream: true
        )

        await logger.logRequest(
          module: "Chat",
          provider: selectedModel.provider,
          model: selectedModel.id,
          systemPrompt: systemPrompt,
          prompt: messages.last?.content ?? "",
          tools: []
        )

        for try await event in provider.stream(request) {
          switch event.kind {
          case .textDelta(let delta):
            if firstToken == nil { firstToken = .now }
            streamingText += delta
          case .completed(let result):
            let assistant = result.message
            messages.append(ChatMessagePayload(role: .assistant, content: assistant.content))
            streamingText = ""
            persist(assistant)

            let metrics = RequestMetrics(
              id: UUID(),
              module: "Chat",
              provider: selectedModel.provider,
              model: selectedModel.id,
              timeToFirstToken: firstToken.map { $0.timeIntervalSince(start) },
              fullResponseTime: Date().timeIntervalSince(start),
              promptTokens: result.usage?.promptTokens ?? 0,
              completionTokens: result.usage?.completionTokens ?? 0,
              estimatedCostUSD: result.usage?.estimatedCostUSD ?? 0,
              timestamp: .now
            )
            lastMetrics = metrics
            await metricsCollector.record(metrics)
          case .error(let error):
            errorMessage = error.localizedDescription
          }
        }
      } catch {
        errorMessage = error.localizedDescription
      }
      isGenerating = false
    }
  }

  private func persist(_ message: ChatMessagePayload) {
    if currentSession == nil {
      currentSession = ChatSession(
        providerRaw: selectedModel.provider.rawValue,
        modelID: selectedModel.id
      )
      modelContext.insert(currentSession!)
    }
    let stored = ChatMessage(
      id: message.id,
      roleRaw: message.role.rawValue,
      content: message.content
    )
    stored.session = currentSession
    currentSession?.messages.append(stored)
    currentSession?.updatedAt = .now
    try? modelContext.save()
  }
}

struct ChatView: View {
  @Bindable var viewModel: ChatViewModel
  @Environment(AppContainer.self) private var container

  var body: some View {
    VStack(spacing: 0) {
      chatSettingsBar
      ScrollViewReader { proxy in
        ScrollView {
          LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(viewModel.messages) { message in
              ChatBubble(message: message)
                .id(message.id)
            }
            if viewModel.isGenerating, !viewModel.streamingText.isEmpty {
              ChatBubble(message: ChatMessagePayload(role: .assistant, content: viewModel.streamingText))
                .id("streaming")
            } else if viewModel.isGenerating {
              LoadingDots().padding()
            }
          }
          .padding()
        }
        .onChange(of: viewModel.messages.count) { _, _ in
          scrollToBottom(proxy: proxy)
        }
        .onChange(of: viewModel.streamingText) { _, _ in
          scrollToBottom(proxy: proxy)
        }
      }
      if let metrics = viewModel.lastMetrics {
        metricsBar(metrics)
      }
      inputBar
    }
    .navigationTitle("Chat")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItemGroup(placement: .topBarTrailing) {
        Button("Retry", action: viewModel.retry)
        Button("Regenerate", action: viewModel.regenerate)
      }
    }
    .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
      Button("OK") { viewModel.errorMessage = nil }
    } message: {
      Text(viewModel.errorMessage ?? "")
    }
  }

  private var chatSettingsBar: some View {
    VStack(spacing: 8) {
      Picker("Model", selection: $viewModel.selectedModel) {
        ForEach(container.providerRegistry.allModels()) { model in
          Text(model.name).tag(model)
        }
      }
      HStack {
        Text("Temperature")
        Slider(value: $viewModel.temperature, in: 0...1)
        Text(String(format: "%.1f", viewModel.temperature))
          .monospacedDigit()
      }
      .font(.caption)
    }
    .padding(.horizontal)
    .padding(.vertical, 8)
    .background(.bar)
  }

  private var inputBar: some View {
    HStack {
      TextField("Message", text: $viewModel.inputText, axis: .vertical)
        .textFieldStyle(.roundedBorder)
        .lineLimit(1...4)
      if viewModel.isGenerating {
        Button("Stop", role: .destructive, action: viewModel.cancel)
      } else {
        Button("Send", action: viewModel.send)
          .buttonStyle(.borderedProminent)
          .disabled(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
      }
    }
    .padding()
    .background(.bar)
  }

  private func metricsBar(_ metrics: RequestMetrics) -> some View {
    HStack {
      MetricsBadge(label: "TTFT", value: String(format: "%.2fs", metrics.timeToFirstToken ?? 0))
      MetricsBadge(label: "Total", value: String(format: "%.2fs", metrics.fullResponseTime))
      MetricsBadge(label: "Tokens", value: "\(metrics.promptTokens + metrics.completionTokens)")
      MetricsBadge(label: "Cost", value: String(format: "$%.4f", metrics.estimatedCostUSD))
    }
    .padding(.horizontal)
  }

  private func scrollToBottom(proxy: ScrollViewProxy) {
    if let last = viewModel.messages.last {
      withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
    } else if viewModel.isGenerating {
      withAnimation { proxy.scrollTo("streaming", anchor: .bottom) }
    }
  }
}

struct ChatBubble: View {
  let message: ChatMessagePayload

  var body: some View {
    HStack {
      if message.role == .user { Spacer(minLength: 40) }
      VStack(alignment: .leading, spacing: 4) {
        Text(message.role.rawValue.capitalized)
          .font(.caption2)
          .foregroundStyle(.secondary)
        MarkdownText(text: message.content)
      }
      .padding(12)
      .background(message.role == .user ? Color.accentColor.opacity(0.15) : Color(.secondarySystemBackground))
      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
      if message.role != .user { Spacer(minLength: 40) }
    }
  }
}

