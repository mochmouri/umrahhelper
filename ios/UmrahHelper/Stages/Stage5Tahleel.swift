import SwiftUI
import SwiftData

struct Stage5Tahleel: View {
    let state: UmrahState
    @Environment(\.modelContext) private var modelContext
    @Environment(\.appTextScale) private var ts
    @State private var showResetConfirm = false
    @State private var shareImage: UIImage? = nil
    @State private var showShare = false

    private var tawafTotal: TimeInterval? { state.tawafMetrics()?.total }
    private var saiTotal: TimeInterval? { state.saiMetrics()?.total }
    private var umrahTotal: TimeInterval? { state.umrahTotal() }

    var body: some View {
        let S = state.strings
        VStack(alignment: .leading, spacing: 0) {
            StageHeader(number: S.stage5Number, title: S.stage5Title, subtitle: S.stage5Subtitle)

            Text(S.hairCuttingTitle)
                .font(.system(size: 15, weight: .semibold, design: .serif))
                .foregroundColor(.ink)
                .padding(.bottom, 16)

            VStack(alignment: .leading, spacing: 16) {
                genderRow(symbol: "♂", label: S.menLabel, text: S.menText)
                genderRow(symbol: "♀", label: S.womenLabel, text: S.womenText)
            }
            .padding(.bottom, 16)

            HStack(alignment: .top, spacing: 0) {
                Rectangle().fill(Color.gold).frame(width: 2)
                Text(S.ihramLiftedNote)
                    .font(.system(size: 13))
                    .foregroundColor(.inkLight)
                    .lineSpacing(3)
                    .padding(.leading, 12)
            }
            .padding(.bottom, 28)

            SectionDivider().padding(.bottom, 28)

            VStack(spacing: 12) {
                Text("الله يتقبل")
                    .font(.system(size: 40 * CGFloat(ts)))
                    .foregroundColor(.ink)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .environment(\.layoutDirection, .rightToLeft)
                Text(S.congratsSubtitle)
                    .font(.system(size: 15 * CGFloat(ts), weight: .regular, design: .serif))
                    .italic()
                    .foregroundColor(.inkLight)
                Text(S.congratsBody)
                    .font(.system(size: 13 * CGFloat(ts)))
                    .foregroundColor(.muted)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 28)

            if let total = umrahTotal {
                summarySection(total: total)
                    .padding(.bottom, 24)
            }

            if umrahTotal != nil {
                Button(S.shareSummary) {
                    let tawaf = state.formatDuration(tawafTotal ?? 0)
                    let sai   = state.formatDuration(saiTotal ?? 0)
                    let total = state.formatDuration(umrahTotal ?? 0)
                    shareImage = renderSummaryCard(
                        date: Date(),
                        tawaf: tawaf, sai: sai, total: total,
                        isArabic: state.isArabic
                    )
                    showShare = shareImage != nil
                }
                .primaryButton()
                .padding(.bottom, 12)
            }

            Button(S.startOverButton) { showResetConfirm = true }
                .ghostButton()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .padding(.bottom, 16)
        .onAppear { saveSessionIfNeeded() }
        .sheet(isPresented: $showShare) {
            if let img = shareImage {
                ShareSheet(items: [img])
            }
        }
        .alert(state.strings.startOverTitle, isPresented: $showResetConfirm) {
            Button(state.strings.resetButton, role: .destructive) {
                state.reset()
            }
            Button(state.strings.cancelButton, role: .cancel) {}
        } message: {
            Text(state.strings.startOverMessage)
        }
    }

    @ViewBuilder
    private func summarySection(total: TimeInterval) -> some View {
        let S = state.strings
        Text(S.summaryTitle)
            .font(.system(size: 15 * CGFloat(ts), weight: .semibold, design: .serif))
            .foregroundColor(.ink)
            .padding(.bottom, 12)

        VStack(spacing: 0) {
            if let t = tawafTotal, t > 0 {
                summaryRow(label: S.tawafLabel, value: state.formatDuration(t))
                Rectangle().fill(Color.parchmentDark).frame(height: 1)
            }
            if let t = saiTotal, t > 0 {
                summaryRow(label: S.saiLabel, value: state.formatDuration(t))
                Rectangle().fill(Color.parchmentDark).frame(height: 1)
            }
            HStack {
                Text(S.totalUmrahLabel)
                    .font(.system(size: 13 * CGFloat(ts), weight: .semibold))
                    .foregroundColor(.ink)
                Spacer()
                Text(state.formatDuration(total))
                    .font(.system(size: 13 * CGFloat(ts), weight: .semibold).monospacedDigit())
                    .foregroundColor(.ink)
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 16)
        .background(Color.parchmentDark.opacity(0.35))
        .padding(.bottom, 16)

        if state.lapTimes.count == 7 {
            MetricsCard(title: S.tawafLapBreakdown, metrics: state.tawafMetrics(),
                        rowLabel: { S.lapLabel($0) })
                .padding(.bottom, 12)
        }
        if state.roundTimes.count == 7 {
            MetricsCard(title: S.saiRoundBreakdown, metrics: state.saiMetrics(),
                        rowLabel: { S.roundLabel($0) })
        }
    }

    private func summaryRow(label: String, value: String) -> some View {
        HStack {
            Text(label).font(.system(size: 13 * CGFloat(ts))).foregroundColor(.muted)
            Spacer()
            Text(value).font(.system(size: 13 * CGFloat(ts)).monospacedDigit()).foregroundColor(.inkLight)
        }
        .padding(.vertical, 8)
    }

    private func genderRow(symbol: String, label: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(symbol)
                .font(.system(size: 16 * CGFloat(ts), weight: .light, design: .serif))
                .foregroundColor(.gold)
                .frame(width: 20)
                .padding(.top, 1)
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.system(size: 13 * CGFloat(ts), weight: .medium))
                    .foregroundColor(.ink)
                Text(text)
                    .font(.system(size: 13 * CGFloat(ts)))
                    .foregroundColor(.inkLight)
                    .lineSpacing(3)
            }
        }
    }

    private func saveSessionIfNeeded() {
        guard !state.sessionSaved,
              let tawafM = state.tawafMetrics(),
              let saiM = state.saiMetrics(),
              let total = state.umrahTotal() else { return }
        let session = UmrahSession(
            date: Date(),
            lapDurations: tawafM.durations,
            roundDurations: saiM.durations,
            totalDuration: total
        )
        modelContext.insert(session)
        state.markSessionSaved()
    }
}
