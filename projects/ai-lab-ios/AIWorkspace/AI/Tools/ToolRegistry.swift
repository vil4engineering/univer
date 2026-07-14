import Foundation

actor ToolRegistry {
  private var executors: [String: any ToolExecutor] = [:]

  init() {
    registerDefaultTools()
  }

  var definitions: [ToolDefinition] {
    executors.values.map(\.definition).sorted { $0.name < $1.name }
  }

  func definition(named name: String) -> ToolDefinition? {
    executors[name]?.definition
  }

  func register(_ executor: any ToolExecutor) {
    executors[executor.definition.name] = executor
  }

  func execute(call: ToolCallRequest) async throws -> ToolCallResult {
    guard let executor = executors[call.name] else {
      throw AIError.toolNotFound(call.name)
    }
    do {
      let output = try await executor.execute(argumentsJSON: call.argumentsJSON)
      return ToolCallResult(id: call.id, name: call.name, output: output, isError: false)
    } catch {
      return ToolCallResult(
        id: call.id,
        name: call.name,
        output: error.localizedDescription,
        isError: true
      )
    }
  }

  private func registerDefaultTools() {
    register(WeatherTool())
    register(CalendarTool())
    register(RemindersTool())
    register(ContactsTool())
    register(NotesTool())
    register(ClipboardTool())
    register(SearchTool())
  }
}

struct ToolOrchestrator {
  let registry: ToolRegistry
  let provider: any LLMProvider
  let maxSteps: Int

  init(registry: ToolRegistry, provider: any LLMProvider, maxSteps: Int = 5) {
    self.registry = registry
    self.provider = provider
    self.maxSteps = maxSteps
  }

  func run(
    userMessage: String,
    systemPrompt: String,
    model: AIModelDescriptor,
    temperature: Double
  ) async throws -> (ChatMessagePayload, [ToolCallResult]) {
    var messages = [ChatMessagePayload(role: .user, content: userMessage)]
    var allResults: [ToolCallResult] = []
    let tools = await registry.definitions

    for _ in 0..<maxSteps {
      let request = ChatRequest(
        messages: messages,
        systemPrompt: systemPrompt,
        model: model,
        temperature: temperature,
        tools: tools,
        responseFormat: .text,
        stream: false
      )

      let completion = try await provider.complete(request)
      var assistant = completion.message

      guard !assistant.toolCalls.isEmpty else {
        return (assistant, allResults)
      }

      for call in assistant.toolCalls {
        let result = try await registry.execute(call: call)
        allResults.append(result)
        messages.append(assistant)
        messages.append(
          ChatMessagePayload(
            role: .tool,
            content: result.output,
            toolResults: [result]
          )
        )
      }
    }

    throw AIError.toolExecutionFailed("Exceeded maximum tool execution steps")
  }
}

private struct WeatherTool: ToolExecutor {
  let definition = ToolDefinition(
    id: "weather",
    name: "getWeather",
    description: "Get current weather for a city.",
    parameters: ToolParameters(
      properties: [
        "city": ToolProperty(type: "string", description: "City name", enumValues: nil)
      ],
      required: ["city"]
    )
  )

  func execute(argumentsJSON: String) async throws -> String {
    let args = try decodeArgs(argumentsJSON)
    let city = args["city"] as? String ?? "Unknown"
    return "Weather in \(city): 18°C, partly cloudy (demo data)."
  }
}

private struct CalendarTool: ToolExecutor {
  let definition = ToolDefinition(
    id: "calendar",
    name: "createCalendarEvent",
    description: "Create a calendar event.",
    parameters: ToolParameters(
      properties: [
        "title": ToolProperty(type: "string", description: "Event title", enumValues: nil),
        "date": ToolProperty(type: "string", description: "ISO date", enumValues: nil)
      ],
      required: ["title", "date"]
    )
  )

  func execute(argumentsJSON: String) async throws -> String {
    let args = try decodeArgs(argumentsJSON)
    let title = args["title"] as? String ?? "Event"
  return "Created calendar event '\(title)' (demo)."
  }
}

private struct RemindersTool: ToolExecutor {
  let definition = ToolDefinition(
    id: "reminders",
    name: "createReminder",
    description: "Create a reminder with title and optional due date.",
    parameters: ToolParameters(
      properties: [
        "title": ToolProperty(type: "string", description: "Reminder title", enumValues: nil),
        "dueDate": ToolProperty(type: "string", description: "Due date in natural language or ISO format", enumValues: nil)
      ],
      required: ["title"]
    )
  )

  func execute(argumentsJSON: String) async throws -> String {
    let args = try decodeArgs(argumentsJSON)
    let title = args["title"] as? String ?? "Reminder"
    let dueDate = args["dueDate"] as? String ?? "unspecified"
    return "Created reminder '\(title)' due \(dueDate) (demo)."
  }
}

private struct ContactsTool: ToolExecutor {
  let definition = ToolDefinition(
    id: "contacts",
    name: "findContact",
    description: "Find a contact by name.",
    parameters: ToolParameters(
      properties: [
        "name": ToolProperty(type: "string", description: "Contact name", enumValues: nil)
      ],
      required: ["name"]
    )
  )

  func execute(argumentsJSON: String) async throws -> String {
    let args = try decodeArgs(argumentsJSON)
    let name = args["name"] as? String ?? "Unknown"
    return "Found contact \(name) — phone: +1 555-0100 (demo)."
  }
}

private struct NotesTool: ToolExecutor {
  let definition = ToolDefinition(
    id: "notes",
    name: "createNote",
    description: "Create a note with title and body.",
    parameters: ToolParameters(
      properties: [
        "title": ToolProperty(type: "string", description: "Note title", enumValues: nil),
        "body": ToolProperty(type: "string", description: "Note content", enumValues: nil)
      ],
      required: ["title", "body"]
    )
  )

  func execute(argumentsJSON: String) async throws -> String {
    let args = try decodeArgs(argumentsJSON)
    let title = args["title"] as? String ?? "Note"
    return "Saved note '\(title)' (demo)."
  }
}

private struct ClipboardTool: ToolExecutor {
  let definition = ToolDefinition(
    id: "clipboard",
    name: "copyToClipboard",
    description: "Copy text to the system clipboard.",
    parameters: ToolParameters(
      properties: [
        "text": ToolProperty(type: "string", description: "Text to copy", enumValues: nil)
      ],
      required: ["text"]
    )
  )

  func execute(argumentsJSON: String) async throws -> String {
    let args = try decodeArgs(argumentsJSON)
    let text = args["text"] as? String ?? ""
    return "Copied \(text.count) characters to clipboard (demo)."
  }
}

private struct SearchTool: ToolExecutor {
  let definition = ToolDefinition(
    id: "search",
    name: "searchWeb",
    description: "Search the web for information.",
    parameters: ToolParameters(
      properties: [
        "query": ToolProperty(type: "string", description: "Search query", enumValues: nil)
      ],
      required: ["query"]
    )
  )

  func execute(argumentsJSON: String) async throws -> String {
    let args = try decodeArgs(argumentsJSON)
    let query = args["query"] as? String ?? ""
    return "Top result for '\(query)': AI Workspace demo search result."
  }
}

private func decodeArgs(_ json: String) throws -> [String: Any] {
  guard let data = json.data(using: .utf8),
        let object = try JSONSerialization.jsonObject(with: data) as? [String: Any]
  else {
    throw AIError.validationFailed("Invalid tool arguments JSON")
  }
  return object
}
