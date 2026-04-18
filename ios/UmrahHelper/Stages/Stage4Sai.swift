import SwiftUI

private let roundLabels = [
    "Safa → Marwa", "Marwa → Safa", "Safa → Marwa", "Marwa → Safa",
    "Safa → Marwa", "Marwa → Safa", "Safa → Marwa",
]

private let endpointLabels = [
    "You have reached Marwa.",
    "You have returned to Safa.",
    "You have reached Marwa.",
    "You have returned to Safa.",
    "You have reached Marwa.",
    "You have returned to Safa.",
    "You have reached Marwa — Saʿi is complete.",
]

struct Stage4Sai: View {
    let state: UmrahState

    private var showEndpointDhikr: Bool {
        let c = state.roundTimes.count
        return state.saiStarted && !state.saiComplete && c > 0 && c < 7
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            StageHeader(number: "Stage 4", title: "Saʿi",
                        subtitle: "Seven rounds between Safa and Marwa. One round = one direction. Begin at Safa.")

            if !state.saiStarted {
                atSafaSection
            } else if !state.saiComplete {
                activeSection
            } else {
                completeSection
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .padding(.bottom, 16)
    }

    // MARK: — At Safa

    @ViewBuilder
    private var atSafaSection: some View {
        Text("At Safa")
            .font(.system(size: 15, weight: .semibold, design: .serif))
            .foregroundColor(.ink)
            .padding(.bottom, 10)

        DuaBlock(arabic: safaAyah.arabic, transliteration: safaAyah.transliteration,
                 meaning: safaAyah.meaning, source: safaAyah.source)
            .padding(.bottom, 20)

        (Text("Face the Ka'bah. Raise your hands. Say ") +
         Text("الحمد لله").font(.system(size: 14)) +
         Text(". Make personal dua. Then recite this ") +
         Text("three times").bold().foregroundColor(.ink) + Text(":"))
            .font(.system(size: 13))
            .foregroundColor(.muted)
            .lineSpacing(3)
            .padding(.bottom, 12)

        DuaBlock(arabic: safaDhikr.arabic, transliteration: safaDhikr.transliteration,
                 meaning: safaDhikr.meaning)
            .padding(.bottom, 20)

        Button("BEGIN SAʿI") { state.startSai() }
            .primaryButton()
    }

    // MARK: — Active

    @ViewBuilder
    private var activeSection: some View {
        VStack(spacing: 8) {
            Text("Round")
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.muted)
                .tracking(2)
                .textCase(.uppercase)

            HStack(alignment: .lastTextBaseline, spacing: 8) {
                Text("\(state.currentRound)")
                    .font(.system(size: 72, weight: .light, design: .serif))
                    .foregroundColor(.ink)
                Text("/ 7")
                    .font(.system(size: 22, weight: .light, design: .serif))
                    .foregroundColor(.muted)
            }

            Text(roundLabels[state.currentRound - 1])
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.inkLight)

            roundDots
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
        .padding(.bottom, 20)

        if showEndpointDhikr {
            HStack(alignment: .top, spacing: 0) {
                Rectangle().fill(Color.gold).frame(width: 2)
                VStack(alignment: .leading, spacing: 6) {
                    Text("AT YOUR CURRENT ENDPOINT")
                        .font(.system(size: 9))
                        .foregroundColor(.muted)
                        .tracking(2)
                    Text("\(endpointLabels[state.roundTimes.count - 1]) Face the Ka'bah and recite (×3):")
                        .font(.system(size: 12))
                        .foregroundColor(.inkLight)
                        .lineSpacing(3)
                    DuaBlock(arabic: safaDhikr.arabic, transliteration: safaDhikr.transliteration,
                             meaning: safaDhikr.meaning, compact: true)
                }
                .padding(.leading, 12)
            }
            .padding(.bottom, 20)
        }

        Rectangle().fill(Color.parchmentDark).frame(height: 1).padding(.bottom, 16)

        Button("COMPLETE ROUND \(state.currentRound)") { state.completeRound() }
            .primaryButton()
    }

    private var roundDots: some View {
        HStack(spacing: 8) {
            ForEach(0..<7) { i in
                Circle()
                    .fill(
                        i < state.currentRound - 1 ? Color.gold :
                        i == state.currentRound - 1 ? Color.ink :
                        Color.parchmentDark
                    )
                    .frame(width: 8, height: 8)
            }
        }
    }

    // MARK: — Complete

    @ViewBuilder
    private var completeSection: some View {
        VStack(spacing: 6) {
            Text("الله يتقبل")
                .font(.system(size: 26))
                .foregroundColor(.ink)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .environment(\.layoutDirection, .rightToLeft)
            Text("Saʿi complete — may Allah accept it.")
                .font(.system(size: 13))
                .foregroundColor(.muted)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
        .padding(.bottom, 24)

        MetricsCard(title: "Saʿi times", metrics: state.saiMetrics(),
                    rowLabel: { "Round \($0 + 1)" })
            .padding(.bottom, 24)

        Button("PROCEED TO TAHLEEL →") { state.goToStage(5) }
            .primaryButton()
    }
}
