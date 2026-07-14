import Foundation
@testable import GroundhogDay
import XCTest

final class DayClockDisplayTests: XCTestCase {
    func testDayOneFormatsAsFourLeadingZeroes() {
        XCTAssertEqual(DayClockDisplay.mechanicalDigits(for: 1), [0, 0, 0, 1])
    }

    func testDayNineFormatsWithLeadingZeroes() {
        XCTAssertEqual(DayClockDisplay.mechanicalDigits(for: 9), [0, 0, 0, 9])
    }

    func testDayTenFormatsWithLeadingZeroes() {
        XCTAssertEqual(DayClockDisplay.mechanicalDigits(for: 10), [0, 0, 1, 0])
    }

    func testDay128FormatsWithLeadingZero() {
        XCTAssertEqual(DayClockDisplay.mechanicalDigits(for: 128), [0, 1, 2, 8])
    }

    func testDay9999FormatsAsAllNines() {
        XCTAssertEqual(DayClockDisplay.mechanicalDigits(for: 9999), [9, 9, 9, 9])
    }

    func testValuesAbove9999ClampMechanicalDisplay() {
        XCTAssertEqual(DayClockDisplay.mechanicalDigits(for: 10023), [9, 9, 9, 9])
    }
}
