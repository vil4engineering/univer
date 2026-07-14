import SwiftUI
import UIKit

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    var onComplete: ((ShareCompletion) -> Void)?

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        controller.completionWithItemsHandler = { activityType, completed, _, error in
            onComplete?(
                ShareCompletion(
                    activityType: activityType,
                    completed: completed,
                    error: error
                )
            )
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        uiViewController.completionWithItemsHandler = { activityType, completed, _, error in
            onComplete?(
                ShareCompletion(
                    activityType: activityType,
                    completed: completed,
                    error: error
                )
            )
        }
    }
}
