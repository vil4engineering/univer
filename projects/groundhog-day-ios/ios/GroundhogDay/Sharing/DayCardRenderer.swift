import SwiftUI
import UIKit

enum DayCardRenderer {
    @MainActor
    static func image(dayNumber: Int, dailyLine: String) -> UIImage? {
        AppLog.sharing.debug("Day card render started day=\(dayNumber, privacy: .public) width=1200 height=1200")

        let card = DayCardView(dayNumber: dayNumber, dailyLine: dailyLine)
        let renderer = ImageRenderer(content: card)
        renderer.proposedSize = ProposedViewSize(width: 1200, height: 1200)
        renderer.scale = 1

        guard let image = renderer.uiImage else {
            AppLog.sharing.error("Day card render failed day=\(dayNumber, privacy: .public)")
            return nil
        }

        AppLog.sharing.debug(
            "Day card render succeeded day=\(dayNumber, privacy: .public) width=\(Int(image.size.width), privacy: .public) height=\(Int(image.size.height), privacy: .public) scale=\(image.scale, privacy: .public)"
        )
        return image
    }
}
