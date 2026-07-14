import Foundation

enum DayNumberCalculator {
    static func dayNumber(
        startedAt: Date,
        now: Date = .now,
        calendar: Calendar = .current
    ) -> Int {
        return max(1, calendarDayOffset(from: startedAt, to: now, calendar: calendar) + 1)
    }

    private static func calendarDayOffset(
        from startedAt: Date,
        to now: Date,
        calendar: Calendar = .current
    ) -> Int {
        let startDay = calendar.startOfDay(for: startedAt)
        let currentDay = calendar.startOfDay(for: now)
        return calendar.dateComponents([.day], from: startDay, to: currentDay).day ?? 0
    }
}
