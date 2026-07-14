import SwiftUI
import Observation

@Observable
@MainActor
final class HomeViewModel {
  let modules: [DemoModule] = [
    .chat,
    .structuredOutput,
    .tools,
    .voice,
    .vision,
    .documents,
    .memory,
    .models,
    .foundationModels,
    .mcp,
    .settings,
    .debug
  ]
}

struct HomeView: View {
  @Bindable var viewModel: HomeViewModel
  @Environment(AppContainer.self) private var container

  private let columns = [GridItem(.adaptive(minimum: 160), spacing: 16)]

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading, spacing: 20) {
          header
          LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.modules) { module in
              NavigationLink(value: module) {
                ModuleCard(module: module)
              }
              .buttonStyle(.plain)
            }
          }
        }
        .padding()
      }
      .navigationTitle("AI Workspace")
      .navigationDestination(for: DemoModule.self) { module in
        destination(for: module)
      }
    }
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("AI Portfolio Demo")
        .font(.largeTitle.bold())
      Text("Explore modern AI technologies — each module is an independent learning lab.")
        .foregroundStyle(.secondary)
    }
  }

  @ViewBuilder
  private func destination(for module: DemoModule) -> some View {
    switch module {
    case .chat:
      ChatView(viewModel: container.makeChatViewModel())
    case .structuredOutput:
      StructuredOutputView(viewModel: container.makeStructuredOutputViewModel())
    case .tools:
      ToolsView(viewModel: container.makeToolsViewModel())
    case .voice:
      VoiceView(viewModel: container.makeVoiceViewModel())
    case .vision:
      VisionView(viewModel: container.makeVisionViewModel())
    case .documents:
      DocumentsView(viewModel: container.makeDocumentsViewModel())
    case .memory:
      MemoryView(viewModel: container.makeMemoryViewModel())
    case .models, .foundationModels:
      ModelsView(viewModel: container.makeModelsViewModel(), highlightOnDevice: module == .foundationModels)
    case .mcp:
      MCPView(viewModel: container.makeMCPViewModel())
    case .settings:
      SettingsView(viewModel: container.makeSettingsViewModel())
    case .debug:
      DebugView(viewModel: container.makeDebugViewModel())
    }
  }
}
