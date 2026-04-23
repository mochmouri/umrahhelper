import SwiftUI

struct Stage4Sai: View {
    let state: UmrahState

    private var showEndpointDhikr: Bool {
        let c = state.roundTimes.count
        return state.saiStarted && !state.saiComplete && c > 0 && c < 7
    }

    var body: some View {
        let S = state.strings
        VStack(alignment: .leading, spacing: 0) {
            StageHeader(number: S.stage4Number, title: S.stage4Title, subtitle: S.stage4Subtitle)

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
        let S = state.strings
        Text(S.atSafaTitle)
            .font(.system(size: 15, weight: .semibold, design: .serif))
            .foregroundColor(.ink)
            .padding(.bottom, 10)

        DuaBlock(arabic: safaAyah.arabic, transliteration: safaAyah.transliteration,
                 meaning: safaAyah.meaning, source: safaAyah.source)
            .padding(.bottom, 20)

        (Text(S.safaPre) +
         Text("الحمد لله").font(.system(size: 14)) +
         Text(S.safaPost) +
         Text(S.safaThreeTimes).bold().foregroundColor(.ink) + Text(":"))
            .font(.system(size: 13))
            .foregroundColor(.muted)
            .lineSpacing(3)
            .padding(.bottom, 12)

        DuaBlock(arabic: safaDhikr.arabic, transliteration: safaDhikr.transliteration,
                 meaning: safaDhikr.meaning)
            .padding(.bottom, 20)

        Button(S.beginSai) { state.startSai() }
            .primaryButton()
    }

    // MARK: — Active

    @ViewBuilder
    private var activeSection: some View {
        let S = state.strings
        VStack(spacing: 8) {
            Text(S.roundCounterLabel)
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.muted)
                .tracking(2)
                .textCase(.uppercase)

            HStack(alignment: .lastTextBaseline, spacing: 8) {
                Text(S.numeral(state.currentRound))
                    .font(.system(size: 72, weight: .light, design: .serif))
                    .foregroundColor(.ink)
                Text("/ \(S.numeral(7))")
                    .font(.system(size: 22, weight: .light, design: .serif))
                    .foregroundColor(.muted)
            }
            .environment(\.layoutDirection, .leftToRight)

            Text(S.roundLabels[state.currentRound - 1])
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
                    Text(S.atCurrentEndpoint)
                        .font(.system(size: 9))
                        .foregroundColor(.muted)
                        .tracking(2)
                    Text("\(S.endpointLabels[state.roundTimes.count - 1])\(S.endpointDhikrBody)")
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

        Button(S.completeRoundButton(state.currentRound)) { state.completeRound() }
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
        let S = state.strings
        VStack(spacing: 6) {
            Text("الله يتقبل")
                .font(.system(size: 26))
                .foregroundColor(.ink)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .environment(\.layoutDirection, .rightToLeft)
            Text(S.saiCompleteMessage)
                .font(.system(size: 13))
                .foregroundColor(.muted)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
        .padding(.bottom, 24)

        MetricsCard(title: S.saiTimesTitle, metrics: state.saiMetrics(),
                    rowLabel: { S.roundLabel($0) })
            .padding(.bottom, 24)

        Button(S.proceedToTahleel) { state.goToStage(5) }
            .primaryButton()
    }
}
