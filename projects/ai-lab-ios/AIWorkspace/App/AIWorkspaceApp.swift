import SwiftUI
import SwiftData

@main
struct AIWorkspaceApp: App {
    @State private var container = AppContainer()

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: container.makeHomeViewModel())
                .environment(container)
                .modelContainer(container.modelContainer)
        }
    }
}
