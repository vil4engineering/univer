import Foundation
import os

enum AppLog {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.vil4max.groundhogday"

    static let storage = Logger(subsystem: subsystem, category: "storage")
    static let sharing = Logger(subsystem: subsystem, category: "sharing")
}
