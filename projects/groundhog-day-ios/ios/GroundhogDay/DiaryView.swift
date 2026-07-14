import SwiftUI

struct DiaryView: View {
    let identity: DiaryIdentity
    @AppStorage("diary.draft.v1") private var draft = ""
    @AppStorage("diary.dailyLine.day.v1") private var dailyLineDay = 0
    @AppStorage("diary.dailyLine.index.v1") private var dailyLineIndex = -1
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var dayNumber = 1
    @State private var digitSlots: [DayDigitSlot] = []
    @State private var selectedDailyLine = ""
    @State private var didRequestInitialFocus = false
    @State private var isSharePresented = false
    @State private var shareItems: [Any] = []
    @State private var showSharePreparationFailure = false
    @FocusState private var isDraftFocused: Bool

    #if DEBUG
    @State private var showDebugPayloadPicker = false
    @State private var temporarySharePNGURL: URL?
    #endif

    private var canPost: Bool {
        !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        GeometryReader { proxy in
            let activeSlots = resolvedDigitSlots
            let tileMetrics = FlipClockTheme.fourPositionClockMetrics(containerWidth: proxy.size.width)

            VStack(spacing: 0) {
                dailyLineBand(screenHeight: proxy.size.height)
                dayCounter(tileMetrics: tileMetrics, slots: activeSlots, width: proxy.size.width)
                    .padding(.top, 20)
                draftSection
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 16)
            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .top)
        }
        .background {
            BlurredHeroBackground(imageName: "LaunchClock")
                .ignoresSafeArea()
        }
        .onAppear {
            syncDayNumber()
            requestInitialDraftFocusIfNeeded()
        }
        .onChange(of: scenePhase) { _, phase in
            guard phase == .active else { return }
            syncDayNumber()
        }
        .onReceive(NotificationCenter.default.publisher(for: .NSCalendarDayChanged)) { _ in
            handleCalendarDayChanged()
        }
        .sheet(isPresented: $isSharePresented, onDismiss: handleShareSheetDismissed) {
            ActivityView(activityItems: shareItems, onComplete: handleShareCompletion)
        }
        .alert("Couldn't prepare the day card.", isPresented: $showSharePreparationFailure) {
            Button("OK", role: .cancel) {}
        }
        #if DEBUG
        .confirmationDialog("Share Payload Diagnostic", isPresented: $showDebugPayloadPicker, titleVisibility: .visible) {
            ForEach(SharePayloadVariant.allCases) { variant in
                Button(variant.title) {
                    presentShare(variant: variant)
                }
            }
            Button("Cancel", role: .cancel) {}
        }
        #endif
    }

    private var draftSection: some View {
        VStack(spacing: 16) {
            draftEditor
            postButton
        }
    }

    private var draftEditor: some View {
        TextEditor(text: $draft)
            .font(.body)
            .foregroundStyle(FlipClockTheme.primaryText)
            .scrollContentBackground(.hidden)
            .focused($isDraftFocused)
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(FlipClockTheme.tileBorder.opacity(0.55), lineWidth: 0.5)
                    }
            )
            .accessibilityLabel("Diary draft")
    }

    private var postButton: some View {
        Button("POST", action: presentShare)
            .font(.headline.weight(.semibold))
            .foregroundStyle(canPost ? FlipClockTheme.accent : FlipClockTheme.primaryText.opacity(0.35))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(FlipClockTheme.displayPanel)
                    .overlay {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .strokeBorder(FlipClockTheme.tileBorder.opacity(0.55), lineWidth: 0.5)
                    }
            )
            .disabled(!canPost)
            .accessibilityLabel("Share day")
            #if DEBUG
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.6).onEnded { _ in
                    guard canPost else { return }
                    showDebugPayloadPicker = true
                }
            )
            #endif
    }

    private func dailyLineBand(screenHeight: CGFloat) -> some View {
        Text(selectedDailyLine)
            .font(FlipClockTheme.quoteBodyFont)
            .foregroundStyle(FlipClockTheme.primaryText)
            .multilineTextAlignment(.center)
            .lineSpacing(5)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 28)
            .frame(height: screenHeight * 0.22)
            .frame(maxWidth: .infinity)
            .accessibilityAddTraits(.isHeader)
    }

    private var resolvedDigitSlots: [DayDigitSlot] {
        if digitSlots.isEmpty {
            return dayDigitSlots(for: dayNumber, previousDay: nil, animateChanges: false)
        }
        return digitSlots
    }

    private func dayCounter(tileMetrics: FlipTileMetrics, slots: [DayDigitSlot], width: CGFloat) -> some View {
        VStack(spacing: 12) {
            Text("DAY")
                .font(FlipClockTheme.quoteTitleFont)
                .foregroundStyle(FlipClockTheme.primaryText)
                .accessibilityHidden(true)

            HStack(spacing: tileMetrics.digitSpacing) {
                ForEach(slots) { slot in
                    FlipDigitView(
                        digit: slot.digit,
                        shouldAnimate: slot.shouldAnimate,
                        reduceMotion: reduceMotion
                    )
                }
            }
            .environment(\.flipTileMetrics, tileMetrics)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Day \(dayNumber)")
        }
        .frame(maxWidth: width)
    }

    private func presentShare() {
        #if DEBUG
        presentShare(variant: .imageAndText)
        #else
        presentProductionShare()
        #endif
    }

    #if DEBUG
    private func presentShare(variant: SharePayloadVariant) {
        guard canPost else { return }

        AppLog.sharing.debug(
            "POST tapped day=\(dayNumber, privacy: .public) draftCharacters=\(draft.count, privacy: .public) dailyLineIndex=\(dailyLineIndex, privacy: .public) variant=\(variant.rawValue, privacy: .public)"
        )

        let draftSnapshot = draft
        let daySnapshot = dayNumber
        let lineSnapshot = selectedDailyLine
        AppLog.sharing.debug("Share snapshot captured day=\(daySnapshot, privacy: .public) draftCharacters=\(draftSnapshot.count, privacy: .public)")

        isDraftFocused = false
        ShareTemporaryPNG.remove(temporarySharePNGURL)
        temporarySharePNGURL = nil

        guard let image = DayCardRenderer.image(dayNumber: daySnapshot, dailyLine: lineSnapshot) else {
            showSharePreparationFailure = true
            return
        }

        var temporaryURL: URL?
        if variant == .pngFileAndText || variant == .pngFileOnly {
            do {
                temporaryURL = try ShareTemporaryPNG.write(image: image, dayNumber: daySnapshot)
                temporarySharePNGURL = temporaryURL
            } catch {
                showSharePreparationFailure = true
                return
            }
        }

        let items = SharePayloadBuilder.items(
            variant: variant,
            image: image,
            draft: draftSnapshot,
            temporaryPNGURL: temporaryURL
        )

        guard !items.isEmpty else {
            AppLog.sharing.error("Share payload prepared itemCount=0")
            showSharePreparationFailure = true
            ShareTemporaryPNG.remove(temporaryURL)
            temporarySharePNGURL = nil
            return
        }

        let typeDescription = SharePayloadBuilder.runtimeTypeDescription(for: items)
        AppLog.sharing.debug(
            "Share payload prepared variant=\(variant.rawValue, privacy: .public) itemCount=\(items.count, privacy: .public) itemTypes=\(typeDescription, privacy: .public)"
        )

        shareItems = items
        AppLog.sharing.debug("Share sheet presentation requested")
        isSharePresented = true
    }
    #else
    private func presentProductionShare() {
        guard canPost else { return }

        AppLog.sharing.debug(
            "POST tapped day=\(dayNumber, privacy: .public) draftCharacters=\(draft.count, privacy: .public) dailyLineIndex=\(dailyLineIndex, privacy: .public)"
        )

        let draftSnapshot = draft
        let daySnapshot = dayNumber
        let lineSnapshot = selectedDailyLine
        AppLog.sharing.debug("Share snapshot captured day=\(daySnapshot, privacy: .public) draftCharacters=\(draftSnapshot.count, privacy: .public)")

        isDraftFocused = false

        guard let image = DayCardRenderer.image(dayNumber: daySnapshot, dailyLine: lineSnapshot) else {
            showSharePreparationFailure = true
            return
        }

        let items: [Any] = [image, draftSnapshot]
        let typeDescription = items.map { String(describing: type(of: $0)) }.joined(separator: ",")
        AppLog.sharing.debug(
            "Share payload prepared variant=imageAndText itemCount=\(items.count, privacy: .public) itemTypes=\(typeDescription, privacy: .public)"
        )

        shareItems = items
        AppLog.sharing.debug("Share sheet presentation requested")
        isSharePresented = true
    }
    #endif

    private func handleShareCompletion(_ completion: ShareCompletion) {
        let activity = completion.activityType?.rawValue ?? "none"
        let domain = (completion.error as NSError?)?.domain ?? "none"
        let code = (completion.error as NSError?)?.code ?? 0

        AppLog.sharing.debug(
            "Share activity finished activity=\(activity, privacy: .public) completed=\(completion.completed, privacy: .public) errorDomain=\(domain, privacy: .public) errorCode=\(code, privacy: .public)"
        )
    }

    private func handleShareSheetDismissed() {
        AppLog.sharing.debug("Share sheet dismissed")
        #if DEBUG
        ShareTemporaryPNG.remove(temporarySharePNGURL)
        temporarySharePNGURL = nil
        #endif
        shareItems = []
    }

    private func syncDayNumber(now: Date = .now) {
        let current = DayNumberCalculator.dayNumber(startedAt: identity.startedAt, now: now)
        dayNumber = current
        digitSlots = dayDigitSlots(for: current, previousDay: nil, animateChanges: false)
        resolveDailyLine(for: current)
    }

    private func resolveDailyLine(for day: Int) {
        let resolvedIndex = DailyLineSelection.resolveIndex(
            dayNumber: day,
            persistedDay: dailyLineDay,
            persistedIndex: dailyLineIndex,
            lineCount: DailyLines.all.count,
            randomIndex: { Int.random(in: $0) }
        )

        dailyLineDay = day
        dailyLineIndex = resolvedIndex
        selectedDailyLine = DailyLines.all[resolvedIndex]
    }

    private func requestInitialDraftFocusIfNeeded() {
        guard !didRequestInitialFocus else { return }
        didRequestInitialFocus = true
        Task { @MainActor in
            await Task.yield()
            isDraftFocused = true
        }
    }

    private func handleCalendarDayChanged(now: Date = .now) {
        let current = DayNumberCalculator.dayNumber(startedAt: identity.startedAt, now: now)
        guard current != dayNumber else { return }

        guard scenePhase == .active else {
            syncDayNumber(now: now)
            return
        }

        let previousDay = dayNumber
        digitSlots = dayDigitSlots(for: current, previousDay: previousDay, animateChanges: true)
        dayNumber = current
        resolveDailyLine(for: current)
    }

    private func dayDigitSlots(
        for day: Int,
        previousDay: Int?,
        animateChanges: Bool
    ) -> [DayDigitSlot] {
        let newDigits = DayClockDisplay.mechanicalDigits(for: day)

        guard animateChanges, let previousDay else {
            return (0 ..< DayClockDisplay.positionCount).map { index in
                DayDigitSlot(id: index, digit: newDigits[index], shouldAnimate: false)
            }
        }

        let oldDigits = DayClockDisplay.mechanicalDigits(for: previousDay)

        return (0 ..< DayClockDisplay.positionCount).map { index in
            DayDigitSlot(
                id: index,
                digit: newDigits[index],
                shouldAnimate: oldDigits[index] != newDigits[index]
            )
        }
    }
}

private struct DayDigitSlot: Identifiable {
    let id: Int
    let digit: Int
    let shouldAnimate: Bool
}
