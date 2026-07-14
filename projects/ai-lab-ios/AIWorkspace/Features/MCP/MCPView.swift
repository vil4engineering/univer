import SwiftUI
import Observation

@Observable
@MainActor
final class MCPViewModel {
  var serverURL = "https://example.com/mcp"
  var connectionStatus = "Not connected"
  var discoveredTools: [String] = []
  var discoveredResources: [String] = []
  var log = ""
  var isConnecting = false

  private let logger: AILogger

  init(logger: AILogger) {
    self.logger = logger
  }

  func connect() {
    isConnecting = true
    connectionStatus = "Connecting..."
    log = ""

    Task {
      defer { isConnecting = false }
      // MCP integration scaffold — implement transport (stdio/SSE) when adding a real server.
      try? await Task.sleep(for: .seconds(1))
      connectionStatus = "Scaffold ready — connect a public MCP server"
      discoveredTools = [
        "filesystem/read_file",
        "filesystem/write_file",
        "github/search_repositories",
        "notion/search"
      ]
      discoveredResources = [
        "file:///README.md",
        "github://repos",
        "notion://pages"
      ]
      log = """
      MCP (Model Context Protocol) integration point.

      Next steps:
      1. Add MCP transport client (stdio or SSE)
      2. Implement initialize / tools/list / tools/call
      3. Wire tool results into ToolOrchestrator
      4. Expose resources via Documents module

      Recommended public servers: Filesystem, GitHub, Notion MCP.
      """
    }
  }
}

struct MCPView: View {
  @Bindable var viewModel: MCPViewModel

  var body: some View {
    Form {
      Section("MCP Server") {
        TextField("Server URL or command", text: $viewModel.serverURL)
        Button(viewModel.isConnecting ? "Connecting..." : "Connect") {
          viewModel.connect()
        }
        Text(viewModel.connectionStatus)
          .font(.caption)
          .foregroundStyle(.secondary)
      }

      Section("Discovered Tools") {
        ForEach(viewModel.discoveredTools, id: \.self) { tool in
          Text(tool).font(.caption.monospaced())
        }
      }

      Section("Resources") {
        ForEach(viewModel.discoveredResources, id: \.self) { resource in
          Text(resource).font(.caption.monospaced())
        }
      }

      if !viewModel.log.isEmpty {
        Section("Integration Notes") {
          Text(viewModel.log)
            .font(.caption)
        }
      }
    }
    .navigationTitle("MCP")
  }
}
