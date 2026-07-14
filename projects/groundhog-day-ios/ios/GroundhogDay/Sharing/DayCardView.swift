import SwiftUI

struct DayCardView: View {
    let dayNumber: Int
    let dailyLine: String

    private let cardSize: CGFloat = 1200

    var body: some View {
        let digits = DayClockDisplay.mechanicalDigits(for: dayNumber)
        let tileMetrics = FlipClockTheme.dayCardClockMetrics()

        ZStack {
            BlurredHeroBackground(imageName: "LaunchClock")

            VStack(spacing: 0) {
                Spacer(minLength: 180)

                Text(dailyLine)
                    .font(.system(size: 42, weight: .regular, design: .serif).italic())
                    .foregroundStyle(FlipClockTheme.primaryText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 96)

                Spacer(minLength: 72)

                Text("DAY")
                    .font(.system(size: 48, weight: .bold, design: .serif).italic())
                    .foregroundStyle(FlipClockTheme.primaryText)

                HStack(spacing: tileMetrics.digitSpacing) {
                    ForEach(Array(digits.enumerated()), id: \.offset) { _, digit in
                        FlipDigitView(
                            digit: digit,
                            shouldAnimate: false,
                            reduceMotion: true
                        )
                    }
                }
                .environment(\.flipTileMetrics, tileMetrics)
                .padding(.top, 28)

                Spacer(minLength: 220)
            }
            .frame(width: cardSize, height: cardSize)
        }
        .frame(width: cardSize, height: cardSize)
        .preferredColorScheme(.dark)
    }
}
