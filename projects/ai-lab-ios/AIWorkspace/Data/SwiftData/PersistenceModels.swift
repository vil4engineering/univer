import Foundation
import SwiftData

@Model
final class ChatSession {
  @Attribute(.unique) var id: UUID
  var title: String
  var providerRaw: String
  var modelID: String
  var createdAt: Date
  var updatedAt: Date
  @Relationship(deleteRule: .cascade, inverse: \ChatMessage.session)
  var messages: [ChatMessage]

  init(
    id: UUID = UUID(),
    title: String = "New Chat",
    providerRaw: String,
    modelID: String,
    createdAt: Date = .now,
    updatedAt: Date = .now,
    messages: [ChatMessage] = []
  ) {
    self.id = id
    self.title = title
    self.providerRaw = providerRaw
    self.modelID = modelID
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.messages = messages
  }
}

@Model
final class ChatMessage {
  @Attribute(.unique) var id: UUID
  var roleRaw: String
  var content: String
  var createdAt: Date
  var session: ChatSession?

  init(id: UUID = UUID(), roleRaw: String, content: String, createdAt: Date = .now) {
    self.id = id
    self.roleRaw = roleRaw
    self.content = content
    self.createdAt = createdAt
  }
}

@Model
final class DocumentChunk {
  @Attribute(.unique) var id: UUID
  var documentName: String
  var chunkIndex: Int
  var text: String
  var embeddingBlob: Data?
  var createdAt: Date

  init(
    id: UUID = UUID(),
    documentName: String,
    chunkIndex: Int,
    text: String,
    embeddingBlob: Data? = nil,
    createdAt: Date = .now
  ) {
    self.id = id
    self.documentName = documentName
    self.chunkIndex = chunkIndex
    self.text = text
    self.embeddingBlob = embeddingBlob
    self.createdAt = createdAt
  }
}

@Model
final class MemoryEntry {
  @Attribute(.unique) var id: UUID
  var content: String
  var category: String
  var embeddingBlob: Data?
  var createdAt: Date

  init(
    id: UUID = UUID(),
    content: String,
    category: String = "preference",
    embeddingBlob: Data? = nil,
    createdAt: Date = .now
  ) {
    self.id = id
    self.content = content
    self.category = category
    self.embeddingBlob = embeddingBlob
    self.createdAt = createdAt
  }
}

@Model
final class AILogEntry {
  @Attribute(.unique) var id: UUID
  var module: String
  var providerRaw: String
  var model: String
  var systemPrompt: String?
  var prompt: String
  var toolsJSON: String?
  var rawResponse: String?
  var jsonPayload: String?
  var errorMessage: String?
  var promptTokens: Int
  var completionTokens: Int
  var timestamp: Date

  init(
    id: UUID = UUID(),
    module: String,
    providerRaw: String,
    model: String,
    systemPrompt: String? = nil,
    prompt: String,
    toolsJSON: String? = nil,
    rawResponse: String? = nil,
    jsonPayload: String? = nil,
    errorMessage: String? = nil,
    promptTokens: Int = 0,
    completionTokens: Int = 0,
    timestamp: Date = .now
  ) {
    self.id = id
    self.module = module
    self.providerRaw = providerRaw
    self.model = model
    self.systemPrompt = systemPrompt
    self.prompt = prompt
    self.toolsJSON = toolsJSON
    self.rawResponse = rawResponse
    self.jsonPayload = jsonPayload
    self.errorMessage = errorMessage
    self.promptTokens = promptTokens
    self.completionTokens = completionTokens
    self.timestamp = timestamp
  }
}

@Model
final class CachedResponse {
  @Attribute(.unique) var id: UUID
  var cacheKey: String
  var response: String
  var createdAt: Date

  init(id: UUID = UUID(), cacheKey: String, response: String, createdAt: Date = .now) {
    self.id = id
    self.cacheKey = cacheKey
    self.response = response
    self.createdAt = createdAt
  }
}
