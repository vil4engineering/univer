import Foundation

enum DayClockDisplay {
    static let positionCount = 4
    static let maxMechanicalValue = 9999

    static func mechanicalDigits(for dayNumber: Int) -> [Int] {
        let value = min(max(1, dayNumber), maxMechanicalValue)
        let text = String(format: "%04d", value)
        return text.map { Int(String($0)) ?? 0 }
    }
}
