# Groundhog Day

A tiny personal diary that counts forward. One day, one thought, then the next morning.

<!-- Hero screenshot: docs/screenshots/diary-day-0001.png -->

## The idea

This is a personal diary, not a countdown. There is no target date, no event to wait for, and no finish line.

On first launch the diary begins. The first local calendar day is DAY 0001. The next calendar day is DAY 0002. The counter keeps moving forward.

The app is intentionally small. You open it in the morning, see which day you are on, and leave a few lines for yourself. The draft is still there when you return.

The feeling behind the project is ordinary repetition with quiet movement: another morning, another day, another chance to notice what changed. Repetition is not treated as failure or stagnation.

## How it works

- First launch records when the diary started.
- DAY N advances by local calendar day, not elapsed seconds.
- The day is shown on a fixed four-position mechanical display (`0001` through `9999`).
- A working draft is restored after the app terminates.
- The app is dark-only.
- Launch and returning to the app show the current day immediately.
- If the app stays open across midnight, only the digit positions that changed may flip once.

## Implementation

- iOS 17+, Swift, SwiftUI
- Single-screen application
- `DiaryIdentity` — immutable diary start date
- `@AppStorage` — working draft persistence
- `DayNumberCalculator` — calendar-day calculation
- `DayClockDisplay` — maps real DAY N to four mechanical positions
- `FlipDigitView` — one mechanical digit position
- No ViewModel, no timer, no per-second tick loop
- Dark-only appearance
- English-only v1

The structure matches the size of the product: a few focused types rather than a large application framework.

## Status

The diary core is implemented and actively evolving.

The current build includes the fixed four-position DAY clock, forward calendar-day semantics, persistent working draft, changed-digit midnight flip behaviour, and dark-only appearance.

The current test suite contains 17 unit tests.

## License

Privacy Policy — see [docs/privacy.md](docs/privacy.md).

MIT — see [LICENSE](LICENSE).
