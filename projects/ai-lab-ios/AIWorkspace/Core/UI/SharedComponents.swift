import SwiftUI

struct ModuleCard: View {
  let module: DemoModule

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Image(systemName: module.iconName)
          .font(.title2)
          .foregroundStyle(.tint)
        Spacer()
        Image(systemName: "chevron.right")
          .font(.caption)
          .foregroundStyle(.secondary)
      }

      Text(module.title)
        .font(.headline)

      Text(module.subtitle)
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .lineLimit(2)

      FlowLayout(spacing: 6) {
        ForEach(module.topics.prefix(3), id: \.self) { topic in
          Text(topic)
            .font(.caption2)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.quaternary, in: Capsule())
        }
      }
    }
    .padding()
    .background(.background, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    .overlay(
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .strokeBorder(.quaternary, lineWidth: 1)
    )
  }
}

struct FlowLayout: Layout {
  var spacing: CGFloat = 8

  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    let result = arrange(proposal: proposal, subviews: subviews)
    return result.size
  }

  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    let result = arrange(proposal: proposal, subviews: subviews)
    for (index, frame) in result.frames.enumerated() {
      subviews[index].place(
        at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY),
        proposal: ProposedViewSize(frame.size)
      )
    }
  }

  private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, frames: [CGRect]) {
    let maxWidth = proposal.width ?? .infinity
    var x: CGFloat = 0
    var y: CGFloat = 0
    var rowHeight: CGFloat = 0
    var frames: [CGRect] = []

    for subview in subviews {
      let size = subview.sizeThatFits(.unspecified)
      if x + size.width > maxWidth, x > 0 {
        x = 0
        y += rowHeight + spacing
        rowHeight = 0
      }
      frames.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
      rowHeight = max(rowHeight, size.height)
      x += size.width + spacing
    }

    return (CGSize(width: maxWidth, height: y + rowHeight), frames)
  }
}

struct MetricsBadge: View {
  let label: String
  let value: String

  var body: some View {
    VStack(alignment: .leading, spacing: 2) {
      Text(label)
        .font(.caption2)
        .foregroundStyle(.secondary)
      Text(value)
        .font(.caption.monospacedDigit())
    }
    .padding(8)
    .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
  }
}

struct LoadingDots: View {
  @State private var phase = 0.0

  var body: some View {
    HStack(spacing: 4) {
      ForEach(0..<3, id: \.self) { index in
        Circle()
          .fill(.secondary)
          .frame(width: 6, height: 6)
          .opacity(opacity(for: index))
      }
    }
    .onAppear {
      withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
        phase = 1
      }
    }
  }

  private func opacity(for index: Int) -> Double {
    let offset = Double(index) * 0.2
    return 0.3 + 0.7 * abs(sin((phase + offset) * .pi))
  }
}

struct MarkdownText: View {
  let text: String

  var body: some View {
    Text(attributed)
      .textSelection(.enabled)
  }

  private var attributed: AttributedString {
    (try? AttributedString(markdown: text)) ?? AttributedString(text)
  }
}
