import Foundation

struct DiaryIdentity {
    private enum Keys {
        static let startedAtDevelopment = "diary.startedAt.development.v1"
    }

    let startedAt: Date

    init(defaults: UserDefaults = .standard, now: Date = .now) {
        if let stored = defaults.object(forKey: Keys.startedAtDevelopment) as? Date {
            startedAt = stored
        } else {
            startedAt = now
            defaults.set(now, forKey: Keys.startedAtDevelopment)
            AppLog.storage.info("Created development diary startedAt")
        }
    }
}
