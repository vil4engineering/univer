import Foundation

struct ExtractedTask: Codable, Identifiable, Hashable {
  let id: UUID
  let title: String
  let priority: String
  let dueDate: String?

  enum CodingKeys: String, CodingKey {
    case title, priority
    case dueDate = "due_date"
  }

  init(id: UUID = UUID(), title: String, priority: String, dueDate: String?) {
    self.id = id
    self.title = title
    self.priority = priority
    self.dueDate = dueDate
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = UUID()
    title = try container.decode(String.self, forKey: .title)
    priority = try container.decode(String.self, forKey: .priority)
    dueDate = try container.decodeIfPresent(String.self, forKey: .dueDate)
  }
}

struct ExtractedTasksResponse: Codable {
  let tasks: [ExtractedTask]
}

enum StructuredOutputParser {
  static func parseTasks(from json: String) throws -> [ExtractedTask] {
    let data = Data(json.utf8)
    do {
      let response = try JSONDecoder().decode(ExtractedTasksResponse.self, from: data)
      return response.tasks
    } catch {
      if let single = try? JSONDecoder().decode(ExtractedTask.self, from: data) {
        return [single]
      }
      throw AIError.validationFailed("Could not decode tasks: \(error.localizedDescription)")
    }
  }

  static func recoveryPrompt(original: String, error: String) -> String {
    """
    The previous JSON response was invalid.
    Error: \(error)
    Return ONLY valid JSON matching this schema:
    {"tasks":[{"title":"string","priority":"low|medium|high","due_date":"optional ISO date"}]}
    Original content to fix:
    \(original)
    """
  }
}
