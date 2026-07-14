import SwiftUI

@main
struct GroundhogDayApp: App {
    private let identity = DiaryIdentity()

    var body: some Scene {
        WindowGroup {
            DiaryView(identity: identity)
                .tint(FlipClockTheme.accent)
                .preferredColorScheme(.dark)
        }
    }
}
