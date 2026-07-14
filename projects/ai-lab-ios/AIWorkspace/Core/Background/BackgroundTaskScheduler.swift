import BackgroundTasks
import Foundation

enum BackgroundTaskScheduler {
  static let embeddingRefreshID = "com.aiworkspace.embedding-refresh"

  static func register() {
    BGTaskScheduler.shared.register(
      forTaskWithIdentifier: embeddingRefreshID,
      using: nil
    ) { task in
      handleEmbeddingRefresh(task: task as! BGAppRefreshTask)
    }
  }

  static func scheduleEmbeddingRefresh() {
    let request = BGAppRefreshTaskRequest(identifier: embeddingRefreshID)
    request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 60)
    try? BGTaskScheduler.shared.submit(request)
  }

  private static func handleEmbeddingRefresh(task: BGAppRefreshTask) {
    scheduleEmbeddingRefresh()
    task.setTaskCompleted(success: true)
  }
}
