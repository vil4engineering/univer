import SwiftUI
import PhotosUI
import Observation

@Observable
@MainActor
final class VisionViewModel {
  var selectedImageData: Data?
  var prompt = "Describe this image in detail. If there is text, extract it."
  var response = ""
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

  func analyze() {
    guard let imageData = selectedImageData else {
      errorMessage = "Select an image first."
      return
    }

    isLoading = true
    errorMessage = nil
    response = ""

    Task {
      defer { isLoading = false }
      do {
        let provider = try providerRegistry.provider(for: .openAI)
        guard let vision = provider as? VisionCapable else {
          throw AIError.unsupportedCapability("Vision")
        }

        let model = providerRegistry.allModels().first { $0.supportsVision }!
        let start = Date()
        let result = try await vision.analyzeImage(
          data: imageData,
          mimeType: "image/jpeg",
          prompt: prompt,
          model: model
        )
        response = result.message.content

        await metricsCollector.record(
          RequestMetrics(
            id: UUID(),
            module: "Vision",
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

struct VisionView: View {
  @Bindable var viewModel: VisionViewModel
  @State private var selectedItem: PhotosPickerItem?

  var body: some View {
    Form {
      Section("Image") {
        PhotosPicker(selection: $selectedItem, matching: .images) {
          if let data = viewModel.selectedImageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
              .resizable()
              .scaledToFit()
              .frame(maxHeight: 240)
          } else {
            Label("Select Photo or Screenshot", systemImage: "photo.on.rectangle")
          }
        }
        .onChange(of: selectedItem) { _, item in
          Task {
            if let data = try? await item?.loadTransferable(type: Data.self) {
              viewModel.selectedImageData = data
            }
          }
        }
      }

      Section("Prompt") {
        TextField("What should the model analyze?", text: $viewModel.prompt, axis: .vertical)
        Button(viewModel.isLoading ? "Analyzing..." : "Analyze") {
          viewModel.analyze()
        }
        .disabled(viewModel.isLoading)
      }

      if !viewModel.response.isEmpty {
        Section("Analysis") {
          MarkdownText(text: viewModel.response)
        }
      }

      if let error = viewModel.errorMessage {
        Section {
          Text(error).foregroundStyle(.red)
        }
      }
    }
    .navigationTitle("Vision")
  }
}
