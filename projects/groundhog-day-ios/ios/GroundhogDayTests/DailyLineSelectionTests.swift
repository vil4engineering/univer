import Foundation
@testable import GroundhogDay
import XCTest

final class DailyLineSelectionTests: XCTestCase {
    func testSameDayValidIndexReusesWithoutRandom() {
        var randomCalls = 0
        let index = DailyLineSelection.resolveIndex(
            dayNumber: 3,
            persistedDay: 3,
            persistedIndex: 5,
            lineCount: 20,
            randomIndex: { range in
                randomCalls += 1
                return range.lowerBound
            }
        )
        XCTAssertEqual(index, 5)
        XCTAssertEqual(randomCalls, 0)
    }

    func testNewDaySelectsValidIndex() {
        let index = DailyLineSelection.resolveIndex(
            dayNumber: 4,
            persistedDay: 3,
            persistedIndex: 5,
            lineCount: 20,
            randomIndex: { _ in 2 }
        )
        XCTAssertEqual(index, 2)
        XCTAssertTrue((0 ..< 20).contains(index))
    }

    func testNewDayExcludesPreviousIndexWhenMultipleLines() {
        let index = DailyLineSelection.resolveIndex(
            dayNumber: 4,
            persistedDay: 3,
            persistedIndex: 5,
            lineCount: 6,
            randomIndex: { _ in 0 }
        )
        XCTAssertNotEqual(index, 5)
        XCTAssertEqual(index, 0)
    }

    func testInvalidPersistedIndexSelectsValidIndex() {
        let index = DailyLineSelection.resolveIndex(
            dayNumber: 2,
            persistedDay: 2,
            persistedIndex: -1,
            lineCount: 10,
            randomIndex: { _ in 7 }
        )
        XCTAssertEqual(index, 7)
    }

    func testSingleLineCatalogRemainsValid() {
        let index = DailyLineSelection.resolveIndex(
            dayNumber: 9,
            persistedDay: 8,
            persistedIndex: 0,
            lineCount: 1,
            randomIndex: { _ in
                XCTFail("Random should not be required for a one-line catalog")
                return 0
            }
        )
        XCTAssertEqual(index, 0)
    }
}
