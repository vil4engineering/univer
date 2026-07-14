import Foundation

enum VectorMath {
  static func cosineSimilarity(_ a: [Float], _ b: [Float]) -> Float {
    guard a.count == b.count, !a.isEmpty else { return 0 }
    var dot: Float = 0
    var normA: Float = 0
    var normB: Float = 0
    for index in a.indices {
      dot += a[index] * b[index]
      normA += a[index] * a[index]
      normB += b[index] * b[index]
    }
    let denominator = sqrt(normA) * sqrt(normB)
    guard denominator > 0 else { return 0 }
    return dot / denominator
  }
}

actor InMemoryVectorStore: VectorStore {
  private var collections: [String: [VectorDocument]] = [:]

  func upsert(_ documents: [VectorDocument]) async {
    for document in documents {
      let collection = document.metadata["collection"] ?? "default"
      var items = collections[collection, default: []]
      items.removeAll { $0.id == document.id }
      items.append(document)
      collections[collection] = items
    }
  }

  func search(query: [Float], topK: Int, minScore: Float) async -> [VectorDocument] {
    let allDocuments = collections.values.flatMap { $0 }
    let scored = allDocuments.map { document in
      (document, VectorMath.cosineSimilarity(query, document.vector))
    }
    return scored
      .filter { $0.1 >= minScore }
      .sorted { $0.1 > $1.1 }
      .prefix(topK)
      .map(\.0)
  }

  func removeAll(in collection: String) async {
    collections[collection] = []
  }

  func count(in collection: String) async -> Int {
    collections[collection, default: []].count
  }
}

struct DocumentChunker {
  let chunkSize: Int
  let overlap: Int

  init(chunkSize: Int = 800, overlap: Int = 120) {
    self.chunkSize = chunkSize
    self.overlap = overlap
  }

  func chunk(text: String) -> [String] {
    let normalized = text
      .replacingOccurrences(of: "\r\n", with: "\n")
      .trimmingCharacters(in: .whitespacesAndNewlines)
    guard !normalized.isEmpty else { return [] }

    var chunks: [String] = []
    var start = normalized.startIndex

    while start < normalized.endIndex {
      let end = normalized.index(
        start,
        offsetBy: chunkSize,
        limitedBy: normalized.endIndex
      ) ?? normalized.endIndex
      let slice = String(normalized[start..<end]).trimmingCharacters(in: .whitespacesAndNewlines)
      if !slice.isEmpty {
        chunks.append(slice)
      }
      if end == normalized.endIndex { break }
      let overlapStart = normalized.index(end, offsetBy: -overlap, limitedBy: normalized.startIndex) ?? start
      start = overlapStart
    }

    return chunks
  }
}
