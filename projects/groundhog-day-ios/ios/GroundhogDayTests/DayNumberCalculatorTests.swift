import Foundation
@testable import GroundhogDay
import XCTest

final class DayNumberCalculatorTests: XCTestCase {
    func testStartDayIsDayOne() {
        let calendar = makeCalendar(timeZoneIdentifier: "UTC")
        let startedAt = date(2026, 1, 1, 6, 0, 0, calendar: calendar)
        let now = date(2026, 1, 1, 23, 59, 59, calendar: calendar)
        XCTAssertEqual(DayNumberCalculator.dayNumber(startedAt: startedAt, now: now, calendar: calendar), 1)
    }

    func testSameCalendarDayIsDayOne() {
        let calendar = makeCalendar(timeZoneIdentifier: "UTC")
        let startedAt = date(2026, 1, 1, 8, 15, 0, calendar: calendar)
        let now = date(2026, 1, 1, 20, 45, 0, calendar: calendar)
        XCTAssertEqual(DayNumberCalculator.dayNumber(startedAt: startedAt, now: now, calendar: calendar), 1)
    }

    func testNextCalendarDayIsDayTwo() {
        let calendar = makeCalendar(timeZoneIdentifier: "UTC")
        let startedAt = date(2026, 1, 1, 12, 0, 0, calendar: calendar)
        let now = date(2026, 1, 2, 0, 0, 1, calendar: calendar)
        XCTAssertEqual(DayNumberCalculator.dayNumber(startedAt: startedAt, now: now, calendar: calendar), 2)
    }

    func testSevenCalendarDayBoundariesIsDayEight() {
        let calendar = makeCalendar(timeZoneIdentifier: "UTC")
        let startedAt = date(2026, 1, 1, 12, 0, 0, calendar: calendar)
        let now = date(2026, 1, 8, 12, 0, 0, calendar: calendar)
        XCTAssertEqual(DayNumberCalculator.dayNumber(startedAt: startedAt, now: now, calendar: calendar), 8)
    }

    func testLeapDayBoundary() {
        let calendar = makeCalendar(timeZoneIdentifier: "UTC")
        let startedAt = date(2024, 2, 28, 10, 0, 0, calendar: calendar)
        let now = date(2024, 3, 1, 10, 0, 0, calendar: calendar)
        XCTAssertEqual(DayNumberCalculator.dayNumber(startedAt: startedAt, now: now, calendar: calendar), 3)
    }

    func testDSTSpringForwardBoundary() {
        let calendar = makeCalendar(timeZoneIdentifier: "America/New_York")
        let startedAt = date(2024, 3, 9, 18, 0, 0, calendar: calendar)
        let now = date(2024, 3, 10, 7, 0, 0, calendar: calendar)
        XCTAssertEqual(DayNumberCalculator.dayNumber(startedAt: startedAt, now: now, calendar: calendar), 2)
    }

    func testDSTFallBackSameCalendarDayRemainsDayOne() {
        let calendar = makeCalendar(timeZoneIdentifier: "America/New_York")
        let startedAt = date(2024, 11, 3, 1, 15, 0, calendar: calendar)
        let now = date(2024, 11, 3, 1, 45, 0, calendar: calendar)
        XCTAssertEqual(DayNumberCalculator.dayNumber(startedAt: startedAt, now: now, calendar: calendar), 1)
    }

    func testTimezoneChangeUsesCurrentCalendarLocalDay() {
        let utc = makeCalendar(timeZoneIdentifier: "UTC")
        let losAngeles = makeCalendar(timeZoneIdentifier: "America/Los_Angeles")
        let startedAt = date(2026, 1, 1, 2, 0, 0, calendar: utc)
        let now = date(2026, 1, 1, 10, 0, 0, calendar: utc)
        XCTAssertEqual(DayNumberCalculator.dayNumber(startedAt: startedAt, now: now, calendar: utc), 1)
        XCTAssertEqual(DayNumberCalculator.dayNumber(startedAt: startedAt, now: now, calendar: losAngeles), 2)
    }

    func testDateBeforeStartedAtClampsToDayOne() {
        let calendar = makeCalendar(timeZoneIdentifier: "UTC")
        let startedAt = date(2026, 1, 10, 12, 0, 0, calendar: calendar)
        let now = date(2026, 1, 5, 12, 0, 0, calendar: calendar)
        XCTAssertEqual(DayNumberCalculator.dayNumber(startedAt: startedAt, now: now, calendar: calendar), 1)
    }

    private func makeCalendar(timeZoneIdentifier: String) -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: timeZoneIdentifier)!
        return calendar
    }

    private func date(
        _ year: Int,
        _ month: Int,
        _ day: Int,
        _ hour: Int,
        _ minute: Int,
        _ second: Int,
        calendar: Calendar
    ) -> Date {
        calendar.date(from: DateComponents(
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second
        ))!
    }
}
