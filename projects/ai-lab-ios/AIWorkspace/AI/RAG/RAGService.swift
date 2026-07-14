import Foundation
import SwiftData

actor EmbeddingService {
  private let providerRegistry: ProviderRegistry
  private let cacheStore: CacheStore

  init(providerRegistry: ProviderRegistry, cacheStore: CacheStore) {
    self.providerRegistry = providerRegistry
    self.cacheStore = cacheStore
  }

  func embed(texts: [String], model: String = "text-embedding-3-small") async throws -> [[Float]] {
    var results: [[Float]] = []
    var uncached: [String] = []

    for text in texts {
      if let cached = await cacheStore.embedding(for: text) {
        results.append(cached)
      } else {
        uncached.append(text)
        results.append([])
      }
    }

    guard !uncached.isEmpty else { return results }

    let provider = try await MainActor.run {
      try providerRegistry.provider(for: .openAI) as? OpenAIProvider
    }
    guard let openAI = provider else {
      throw AIError.embeddingFailed("OpenAI provider required for embeddings in this demo")
    }

    let response = try await openAI.embed(
      EmbeddingRequest(texts: uncached, model: model)
    )

    var uncachedIndex = 0
    for index in results.indices where results[index].isEmpty {
      let vector = response.vectors[uncachedIndex]
      results[index] = vector
      await cacheStore.store(embedding: vector, for: texts[index])
      uncachedIndex += 1
    }

    return results
  }

  func embed(text: String) async throws -> [Float] {
    try await embed(texts: [text]).first ?? []
  }
}

actor RAGService {
  private let embeddingService: EmbeddingService
  private let vectorStore: InMemoryVectorStore
  private let providerRegistry: ProviderRegistry
  private let chunker = DocumentChunker()

  init(
    embeddingService: EmbeddingService,
    vectorStore: InMemoryVectorStore,
    providerRegistry: ProviderRegistry
  ) {
    self.embeddingService = embeddingService
    self.vectorStore = vectorStore
    self.providerRegistry = providerRegistry
  }

  func index(documentName: String, text: String) async throws -> Int {
    let chunks = chunker.chunk(text: text)
    let vectors = try await embeddingService.embed(texts: chunks)
    let documents = zip(chunks, vectors).enumerated().map { index, pair in
      VectorDocument(
        id: UUID(),
        text: pair.0,
        vector: pair.1,
        metadata: [
          "collection": "documents",
          "source": documentName,
          "chunk": "\(index)"
        ]
      )
    }
    await vectorStore.upsert(documents)
    return documents.count
  }

  func query(_ query: RAGQuery) async throws -> RAGResult {
    let queryVector = try await embeddingService.embed(text: query.question)
    let matches = await vectorStore.search(
      query: queryVector,
      topK: query.topK,
      minScore: query.minScore
    )

    let citations = matches.map { match in
      RAGCitation(
        id: match.id,
        text: match.text,
        score: VectorMath.cosineSimilarity(queryVector, match.vector),
        source: match.metadata["source"] ?? "unknown"
      )
    }

    let context = citations.map { "[\($0.source)] \($0.text)" }.joined(separator: "\n\n")
    let provider = try await MainActor.run { try providerRegistry.activeProvider() }
    let model = await MainActor.run { providerRegistry.defaultModel() }

    let prompt = """
    Answer the question using only the context below. Cite sources in brackets.

    Context:
    \(context)

    Question:
    \(query.question)
    """

    let completion = try await provider.complete(
      ChatRequest(
        messages: [ChatMessagePayload(role: .user, content: prompt)],
        systemPrompt: "You are a helpful document assistant. Always cite your sources.",
        model: model,
        temperature: 0.2,
        tools: [],
        responseFormat: .text,
        stream: false
      )
    )

    return RAGResult(
      answer: completion.message.content,
      citations: citations,
      usage: completion.usage
    )
  }
}

actor MemoryService {
  private let embeddingService: EmbeddingService
  private let vectorStore: InMemoryVectorStore
  private let modelContext: ModelContext

  init(
    embeddingService: EmbeddingService,
    vectorStore: InMemoryVectorStore,
    modelContext: ModelContext
  ) {
    self.embeddingService = embeddingService
    self.vectorStore = vectorStore
    self.modelContext = modelContext
  }

  func storeMemory(content: String, category: String = "preference") async throws {
    let vector = try await embeddingService.embed(text: content)
    let entry = MemoryEntry(content: content, category: category, embeddingBlob: vector.data)
    modelContext.insert(entry)

    await vectorStore.upsert([
      VectorDocument(
        id: entry.id,
        text: content,
        vector: vector,
        metadata: ["collection": "memory", "category": category]
      )
    ])
    try? modelContext.save()
  }

  func relevantMemories(for query: String, topK: Int = 3) async throws -> [String] {
    let vector = try await embeddingService.embed(text: query)
    let matches = await vectorStore.search(query: vector, topK: topK, minScore: 0.65)
    return matches.map(\.text)
  }

  func buildMemoryContext(for query: String) async throws -> String? {
    let memories = try await relevantMemories(for: query)
    guard !memories.isEmpty else { return nil }
    return "Relevant user memories:\n" + memories.map { "- \($0)" }.joined(separator: "\n")
  }
}

private extension Array where Element == Float {
  var data: Data {
    withUnsafeBufferPointer { buffer in
      Data(buffer: buffer)
    }
  }
}
