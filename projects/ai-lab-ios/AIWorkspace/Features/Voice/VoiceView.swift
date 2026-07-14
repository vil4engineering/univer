import SwiftUI
import Observation
import AVFoundation
import Speech

@Observable
@MainActor
final class VoiceViewModel {
  enum PipelineState: String {
    case idle
    case listening
    case processing
    case speaking
  }

  var state: PipelineState = .idle
  var transcript = ""
  var assistantReply = ""
  var errorMessage: String?

  private let providerRegistry: ProviderRegistry
  private let logger: AILogger
  private let metricsCollector: MetricsCollector
  private let speechRecognizer = SFSpeechRecognizer()
  private let synthesizer = AVSpeechSynthesizer()
  private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  private var recognitionTask: SFSpeechRecognitionTask?
  private let audioEngine = AVAudioEngine()

  init(providerRegistry: ProviderRegistry, logger: AILogger, metricsCollector: MetricsCollector) {
    self.providerRegistry = providerRegistry
    self.logger = logger
    self.metricsCollector = metricsCollector
  }

  func requestPermissions() async {
    _ = await withCheckedContinuation { continuation in
      SFSpeechRecognizer.requestAuthorization { _ in
        continuation.resume()
      }
    }
    _ = await AVAudioApplication.requestRecordPermission()
  }

  func toggleListening() {
    switch state {
    case .idle:
      startListening()
    case .listening:
      stopListening()
      Task { await processTranscript() }
  case .speaking:
      synthesizer.stopSpeaking(at: .immediate)
      state = .idle
    default:
      break
    }
  }

  func interrupt() {
    synthesizer.stopSpeaking(at: .immediate)
    state = .idle
  }

  private func startListening() {
    transcript = ""
    assistantReply = ""
    errorMessage = nil

    do {
      let audioSession = AVAudioSession.sharedInstance()
      try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
      try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

      recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
      recognitionRequest?.shouldReportPartialResults = true

      let inputNode = audioEngine.inputNode
      guard let request = recognitionRequest else { return }

      recognitionTask = speechRecognizer?.recognitionTask(with: request) { [weak self] result, error in
        guard let self else { return }
        if let result {
          Task { @MainActor in
            self.transcript = result.bestTranscription.formattedString
          }
        }
        if error != nil {
          Task { @MainActor in self.stopListening() }
        }
      }

      let format = inputNode.outputFormat(forBus: 0)
      inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
        request.append(buffer)
      }

      audioEngine.prepare()
      try audioEngine.start()
      state = .listening
    } catch {
      errorMessage = error.localizedDescription
      state = .idle
    }
  }

  private func stopListening() {
    audioEngine.stop()
    audioEngine.inputNode.removeTap(onBus: 0)
    recognitionRequest?.endAudio()
    recognitionTask?.cancel()
    recognitionRequest = nil
    recognitionTask = nil
    state = .idle
  }

  private func processTranscript() async {
    guard !transcript.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
    state = .processing

    do {
      let provider = try providerRegistry.activeProvider()
      let model = providerRegistry.defaultModel()
      let start = Date()

      let result = try await provider.complete(
        ChatRequest(
          messages: [ChatMessagePayload(role: .user, content: transcript)],
          systemPrompt: "You are a concise voice assistant. Keep answers short for speech output.",
          model: model,
          temperature: 0.5,
          tools: [],
          responseFormat: .text,
          stream: false
        )
      )

      assistantReply = result.message.content
      await metricsCollector.record(
        RequestMetrics(
          id: UUID(),
          module: "Voice",
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
      speak(assistantReply)
    } catch {
      errorMessage = error.localizedDescription
      state = .idle
    }
  }

  private func speak(_ text: String) {
    let utterance = AVSpeechUtterance(string: text)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    utterance.rate = 0.5
    state = .speaking
    synthesizer.speak(utterance)
    Task {
      try? await Task.sleep(for: .seconds(Double(text.count) / 12.0 + 1))
      if state == .speaking { state = .idle }
    }
  }
}

struct VoiceView: View {
  @Bindable var viewModel: VoiceViewModel

  var body: some View {
    VStack(spacing: 24) {
      pipelineDiagram
      stateIndicator

      VStack(alignment: .leading, spacing: 12) {
        GroupBox("Transcript") {
          Text(viewModel.transcript.isEmpty ? "Tap the mic to start" : viewModel.transcript)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        GroupBox("Assistant") {
          Text(viewModel.assistantReply.isEmpty ? "—" : viewModel.assistantReply)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      .padding(.horizontal)

      HStack(spacing: 16) {
        Button {
          viewModel.toggleListening()
        } label: {
          Image(systemName: viewModel.state == .listening ? "stop.circle.fill" : "mic.circle.fill")
            .font(.system(size: 64))
        }
        .buttonStyle(.plain)

        if viewModel.state == .speaking {
          Button("Interrupt", role: .destructive, action: viewModel.interrupt)
        }
      }

      if let error = viewModel.errorMessage {
        Text(error).foregroundStyle(.red).font(.caption)
      }

      Spacer()
    }
    .padding(.top)
    .navigationTitle("Voice")
    .task { await viewModel.requestPermissions() }
  }

  private var pipelineDiagram: some View {
    HStack {
      pipelineStep("Speech", icon: "waveform")
      Image(systemName: "arrow.right")
      pipelineStep("Text", icon: "text.alignleft")
      Image(systemName: "arrow.right")
      pipelineStep("LLM", icon: "sparkles")
      Image(systemName: "arrow.right")
      pipelineStep("Speech", icon: "speaker.wave.2.fill")
    }
    .font(.caption)
    .foregroundStyle(.secondary)
    .padding()
  }

  private func pipelineStep(_ title: String, icon: String) -> some View {
    VStack {
      Image(systemName: icon)
      Text(title)
    }
  }

  private var stateIndicator: some View {
    Text(viewModel.state.rawValue.capitalized)
      .font(.headline)
      .padding(.horizontal, 16)
      .padding(.vertical, 8)
      .background(.quaternary, in: Capsule())
  }
}
