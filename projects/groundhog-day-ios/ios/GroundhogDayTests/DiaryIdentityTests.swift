import Foundation
@testable import GroundhogDay
import XCTest

final class DiaryIdentityTests: XCTestCase {
    private let startedAtKey = "diary.startedAt.development.v1"

    func testFirstLaunchCreatesStartedAt() {
        let defaults = makeDefaults()
        let now = date(2026, 1, 1, 9, 30, 0)
        let identity = DiaryIdentity(defaults: defaults, now: now)
        XCTAssertEqual(identity.startedAt, now)
        XCTAssertEqual(defaults.object(forKey: startedAtKey) as? Date, now)
    }

    func testSecondInitPreservesStartedAt() {
        let defaults = makeDefaults()
        let now = date(2026, 1, 1, 9, 30, 0)
        let first = DiaryIdentity(defaults: defaults, now: now)
        let second = DiaryIdentity(defaults: defaults, now: date(2026, 6, 1, 12, 0, 0))
        XCTAssertEqual(second.startedAt, first.startedAt)
    }

    private func makeDefaults() -> UserDefaults {
        let suiteName = "DiaryIdentityTests.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        return defaults
    }

    private func date(
        _ year: Int,
        _ month: Int,
        _ day: Int,
        _ hour: Int = 0,
        _ minute: Int = 0,
        _ second: Int = 0
    ) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar.date(from: DateComponents(
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second
        ))!
    }
}
