import SwiftUI

enum FlipClockTheme {
    static let surface = color(red: 0.141, green: 0.141, blue: 0.141)
    static let displayPanel = color(red: 0.165, green: 0.165, blue: 0.165)
    static let tileBorder = color(red: 0.220, green: 0.220, blue: 0.220)
    static let tileSplit = color(red: 0.090, green: 0.090, blue: 0.090)
    static let digit = color(red: 0.769, green: 0.749, blue: 0.725)
    static let primaryText = color(red: 0.820, green: 0.800, blue: 0.776)
    static let accent = color(red: 0.788, green: 0.584, blue: 0.384)

    static let quoteBodyFont = Font.system(.title3, design: .serif).italic()
    static let quoteTitleFont = Font.system(.title2, design: .serif).weight(.bold).italic()

    static func fourPositionClockMetrics(containerWidth width: CGFloat) -> FlipTileMetrics {
        let rowWidth = min(max(width, 320) * 0.82, 300)
        let digitGap: CGFloat = 5
        let tileWidth = floor((rowWidth - digitGap * 3) / 4)
        let verticalAspectRatio: CGFloat = 1.30
        let tileHeight = tileWidth * verticalAspectRatio
        let fontSize = tileWidth * 0.72
        return FlipTileMetrics(
            tileSize: CGSize(width: tileWidth, height: tileHeight),
            digitFont: .system(size: fontSize, weight: .bold, design: .rounded),
            cornerRadius: max(6, tileWidth * 0.11),
            digitSpacing: digitGap,
            rowSpacing: 12,
            unitFont: .footnote
        )
    }

    static func dayCardClockMetrics() -> FlipTileMetrics {
        let tileWidth: CGFloat = 148
        let digitGap: CGFloat = 14
        let tileHeight = tileWidth * 1.30
        let fontSize = tileWidth * 0.72
        return FlipTileMetrics(
            tileSize: CGSize(width: tileWidth, height: tileHeight),
            digitFont: .system(size: fontSize, weight: .bold, design: .rounded),
            cornerRadius: max(10, tileWidth * 0.11),
            digitSpacing: digitGap,
            rowSpacing: 16,
            unitFont: .footnote
        )
    }

    static func tileMetrics(forContainerWidth width: CGFloat) -> FlipTileMetrics {
        let contentWidth = max(width, 320)
        let digitGap: CGFloat = 12
        let tileWidth = min(72, max(50, floor((contentWidth * 0.42 - digitGap) / 2)))
        let tileHeight = tileWidth * 1.15
        let fontSize = tileWidth * 0.68
        return FlipTileMetrics(
            tileSize: CGSize(width: tileWidth, height: tileHeight),
            digitFont: .system(size: fontSize, weight: .bold, design: .rounded),
            cornerRadius: max(8, tileWidth * 0.13),
            digitSpacing: digitGap,
            rowSpacing: max(12, tileHeight * 0.2),
            unitFont: .footnote
        )
    }

    private static func color(red: CGFloat, green: CGFloat, blue: CGFloat) -> Color {
        Color(red: red, green: green, blue: blue)
    }
}

struct FlipTileMetrics {
    let tileSize: CGSize
    let digitFont: Font
    let cornerRadius: CGFloat
    let digitSpacing: CGFloat
    let rowSpacing: CGFloat
    let unitFont: Font

    static let `default` = FlipClockTheme.tileMetrics(forContainerWidth: 390)
}

private struct FlipTileMetricsKey: EnvironmentKey {
    static let defaultValue = FlipTileMetrics.default
}

extension EnvironmentValues {
    var flipTileMetrics: FlipTileMetrics {
        get { self[FlipTileMetricsKey.self] }
        set { self[FlipTileMetricsKey.self] = newValue }
    }
}
