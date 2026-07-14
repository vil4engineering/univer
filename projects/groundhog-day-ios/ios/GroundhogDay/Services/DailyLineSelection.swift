enum DailyLineSelection {
    static func resolveIndex(
        dayNumber: Int,
        persistedDay: Int,
        persistedIndex: Int,
        lineCount: Int,
        randomIndex: (Range<Int>) -> Int
    ) -> Int {
        guard lineCount > 0 else { return 0 }

        let validRange = 0 ..< lineCount

        if persistedDay == dayNumber, validRange.contains(persistedIndex) {
            return persistedIndex
        }

        if lineCount == 1 {
            return 0
        }

        if persistedDay != dayNumber, validRange.contains(persistedIndex) {
            let candidates = Array(validRange).filter { $0 != persistedIndex }
            let pick = randomIndex(0 ..< candidates.count)
            return candidates[pick]
        }

        return randomIndex(validRange)
    }
}
