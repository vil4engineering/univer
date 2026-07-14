import XCTest
@testable import AIWorkspace

final class VectorMathTests: XCTestCase {
  func testCosineSimilarityIdenticalVectors() {
    let vector: [Float] = [1, 0, 0]
    let score = VectorMath.cosineSimilarity(vector, vector)
    XCTAssertEqual(score, 1.0, accuracy: 0.001)
  }

  func testCosineSimilarityOrthogonalVectors() {
    let a: [Float] = [1, 0, 0]
    let b: [Float] = [0, 1, 0]
    let score = VectorMath.cosineSimilarity(a, b)
    XCTAssertEqual(score, 0.0, accuracy: 0.001)
  }
}

final class DocumentChunkerTests: XCTestCase {
  func testChunkingProducesMultipleChunks() {
    let chunker = DocumentChunker(chunkSize: 50, overlap: 10)
    let text = String(repeating: "word ", count: 100)
    let chunks = chunker.chunk(text: text)
    XCTAssertGreaterThan(chunks.count, 1)
  }
}

final class StructuredOutputParserTests: XCTestCase {
  func testParseTasksJSON() throws {
    let json = """
    {"tasks":[{"title":"Call John","priority":"high","due_date":"2026-07-02"}]}
    """
    let tasks = try StructuredOutputParser.parseTasks(from: json)
    XCTAssertEqual(tasks.count, 1)
    XCTAssertEqual(tasks.first?.title, "Call John")
  }
}
