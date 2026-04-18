import SwiftUI
import SwiftData

struct Stage5Tahleel: View {
    let state: UmrahState
    @Environment(\.modelContext) private var modelContext
    @State private var showResetConfirm = false

    private var tawafTotal: TimeInterval? { state.tawafMetrics()?.total }
    private var saiTotal: TimeInterval? { state.saiMetrics()?.total }
    private var umrahTotal: TimeInterval? { state.umrahTotal() }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            StageHeader(number: "Stage 5", title: "Tahleel",
                        subtitle: "The final act — cutting the hair — marks the end of Ihram.")

            // Hair cutting
            Text("Hair cutting")
                .font(.system(size: 15, weight: .semibold, design: .serif))
                .foregroundColor(.ink)
                .padding(.bottom, 16)

            VStack(alignment: .leading, spacing: 16) {
                genderRow(symbol: "♂", label: "Men",
                    text: "The minimum is to cut a fingertip's length of hair from all parts of the head. The preferable act is to shave all the hair off (Halq). This is more virtuous than trimming (Taqseer).")
                genderRow(symbol: "♀", label: "Women",
                    text: "Gather a lock of hair and cut a fingertip's length from its end. Do not shave.")
            }
            .padding(.bottom, 16)

            HStack(alignment: .top, spacing: 0) {
                Rectangle().fill(Color.gold).frame(width: 2)
                Text("After cutting, Ihram is lifted. All restrictions are now removed.")
                    .font(.system(size: 13))
                    .foregroundColor(.inkLight)
                    .lineSpacing(3)
                    .padding(.leading, 12)
            }
            .padding(.bottom, 28)

            SectionDivider().padding(.bottom, 28)

            // Congratulations
            VStack(spacing: 12) {
                Text("الله يتقبل")
                    .font(.system(size: 40))
                    .foregroundColor(.ink)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .environment(\.layoutDirection, .rightToLeft)
                Text("May Allah accept your Umrah.")
                    .font(.system(size: 15, weight: .regular, design: .serif))
                    .italic()
                    .foregroundColor(.inkLight)
                Text("You have completed your Umrah. May it be a source of forgiveness, mercy, and nearness to Allah.")
                    .font(.system(size: 13))
                    .foregroundColor(.muted)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 28)

            // Summary metrics
            if let total = umrahTotal {
                summarySection(total: total)
                    .padding(.bottom, 24)
            }

            Button("START OVER") { showResetConfirm = true }
                .ghostButton()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .padding(.bottom, 16)
        .onAppear { saveSessionIfNeeded() }
        .alert("Start over?", isPresented: $showResetConfirm) {
            Button("Reset", role: .destructive) {
                state.reset()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will clear all progress and timing data.")
        }
    }

    @ViewBuilder
    private func summarySection(total: TimeInterval) -> some View {
        Text("Summary")
            .font(.system(size: 15, weight: .semibold, design: .serif))
            .foregroundColor(.ink)
            .padding(.bottom, 12)

        VStack(spacing: 0) {
            if let t = tawafTotal, t > 0 {
                summaryRow(label: "Tawaf", value: state.formatDuration(t))
                Rectangle().fill(Color.parchmentDark).frame(height: 1)
            }
            if let t = saiTotal, t > 0 {
                summaryRow(label: "Saʿi", value: state.formatDuration(t))
                Rectangle().fill(Color.parchmentDark).frame(height: 1)
            }
            HStack {
                Text("Total Umrah")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.ink)
                Spacer()
                Text(state.formatDuration(total))
                    .font(.system(size: 13, weight: .semibold).monospacedDigit())
                    .foregroundColor(.ink)
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 16)
        .background(Color.parchmentDark.opacity(0.35))
        .padding(.bottom, 16)

        if state.lapTimes.count == 7 {
            MetricsCard(title: "Tawaf — lap breakdown", metrics: state.tawafMetrics(),
                        rowLabel: { "Lap \($0 + 1)" })
                .padding(.bottom, 12)
        }
        if state.roundTimes.count == 7 {
            MetricsCard(title: "Saʿi — round breakdown", metrics: state.saiMetrics(),
                        rowLabel: { "Round \($0 + 1)" })
        }
    }

    private func summaryRow(label: String, value: String) -> some View {
        HStack {
            Text(label).font(.system(size: 13)).foregroundColor(.muted)
            Spacer()
            Text(value).font(.system(size: 13).monospacedDigit()).foregroundColor(.inkLight)
        }
        .padding(.vertical, 8)
    }

    private func genderRow(symbol: String, label: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(symbol)
                .font(.system(size: 16, weight: .light, design: .serif))
                .foregroundColor(.gold)
                .frame(width: 20)
                .padding(.top, 1)
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.ink)
                Text(text)
                    .font(.system(size: 13))
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
