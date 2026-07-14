import SwiftUI
import SwiftData
import Observation
import UniformTypeIdentifiers

@Observable
@MainActor
final class DocumentsViewModel {
  var documentText = ""
  var documentName = ""
  var question = "What are the key points in this document?"
  var answer = ""
  var citations: [RAGCitation] = []
  var indexedChunkCount = 0
  var isIndexing = false
  var isQuerying = false
  var errorMessage: String?

  private let ragService: RAGService
  private let logger: AILogger
  private let metricsCollector: MetricsCollector
  private let modelContext: ModelContext

  init(
    ragService: RAGService,
    logger: AILogger,
    metricsCollector: MetricsCollector,
    modelContext: ModelContext
  ) {
    self.ragService = ragService
    self.logger = logger
    self.metricsCollector = metricsCollector
    self.modelContext = modelContext
  }

  func indexDocument() {
    guard !documentText.isEmpty else {
      errorMessage = "Load or paste document text first."
      return
    }

    isIndexing = true
    errorMessage = nil

    Task {
      defer { isIndexing = false }
      do {
        let name = documentName.isEmpty ? "Document-\(Date().formatted(date: .numeric, time: .omitted))" : documentName
        let count = try await ragService.index(documentName: name, text: documentText)
        indexedChunkCount = count
        documentName = name
      } catch {
        errorMessage = error.localizedDescription
      }
    }
  }

  func ask() {
    guard indexedChunkCount > 0 else {
      errorMessage = "Index a document first."
      return
    }

    isQuerying = true
    errorMessage = nil
    answer = ""
    citations = []

    Task {
      defer { isQuerying = false }
      do {
        let start = Date()
        let result = try await ragService.query(
          RAGQuery(question: question, topK: 4, minScore: 0.5)
        )
        answer = result.answer
        citations = result.citations

        await metricsCollector.record(
          RequestMetrics(
            id: UUID(),
            module: "Documents",
            provider: .openAI,
            model: "rag",
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

struct DocumentsView: View {
  @Bindable var viewModel: DocumentsViewModel

  var body: some View {
    Form {
      Section("Pipeline") {
        Label("PDF/Text → Chunking → Embeddings → Vector Search → LLM", systemImage: "arrow.right.circle")
          .font(.caption)
          .foregroundStyle(.secondary)
      }

      Section("Document") {
        TextField("Document name", text: $viewModel.documentName)
        TextEditor(text: $viewModel.documentText)
          .frame(minHeight: 120)
        Button(viewModel.isIndexing ? "Indexing..." : "Index Document") {
          viewModel.indexDocument()
        }
        .disabled(viewModel.isIndexing)

        if viewModel.indexedChunkCount > 0 {
          Text("\(viewModel.indexedChunkCount) chunks indexed")
            .font(.caption)
            .foregroundStyle(.secondary)
        }
      }

      Section("Question") {
        TextField("Ask about the document", text: $viewModel.question, axis: .vertical)
        Button(viewModel.isQuerying ? "Searching..." : "Ask with RAG") {
          viewModel.ask()
        }
        .disabled(viewModel.isQuerying)
      }

      if !viewModel.citations.isEmpty {
        Section("Citations") {
          ForEach(viewModel.citations) { citation in
            VStack(alignment: .leading, spacing: 4) {
              Text(citation.source).font(.caption.bold())
              Text(citation.text).font(.caption)
              Text(String(format: "Score: %.3f", citation.score))
                .font(.caption2)
                .foregroundStyle(.secondary)
            }
          }
        }
      }

      if !viewModel.answer.isEmpty {
        Section("Answer") {
          MarkdownText(text: viewModel.answer)
        }
      }

      if let error = viewModel.errorMessage {
        Section {
          Text(error).foregroundStyle(.red)
        }
      }
    }
    .navigationTitle("Documents (RAG)")
  }
}
