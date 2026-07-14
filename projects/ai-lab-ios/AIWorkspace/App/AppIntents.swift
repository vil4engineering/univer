import AppIntents

struct StartChatIntent: AppIntent {
  static var title: LocalizedStringResource = "Start AI Chat"
  static var description = IntentDescription("Open AI Workspace chat module.")

  static var openAppWhenRun = true

  func perform() async throws -> some IntentResult {
    .result()
  }
}

struct AIWorkspaceShortcuts: AppShortcutsProvider {
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: StartChatIntent(),
      phrases: [
        "Start chat in \(.applicationName)",
        "Open AI chat in \(.applicationName)"
      ],
      shortTitle: "AI Chat",
      systemImageName: "bubble.left.and.bubble.right.fill"
    )
  }
}
