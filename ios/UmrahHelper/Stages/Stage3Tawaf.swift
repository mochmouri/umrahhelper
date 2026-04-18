import SwiftUI

struct Stage3Tawaf: View {
    let state: UmrahState

    private var lapDuas: [Dua] {
        guard state.tawafStarted, state.currentLap >= 1, state.currentLap <= 7 else { return [] }
        return getDuasForLap(state.currentLap)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            StageHeader(number: "Stage 3", title: "Tawaf",
                        subtitle: "Seven anti-clockwise circuits around the Ka'bah, beginning and ending at the Black Stone.")

            if !state.tawafStarted {
                preChecklistSection
            } else if !state.tawafComplete {
                activeTawafSection
            } else {
                tawafCompleteSection
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .padding(.bottom, 16)
    }

    // MARK: — Pre-checklist

    @ViewBuilder
    private var preChecklistSection: some View {
        Text("Before You Begin")
            .font(.system(size: 15, weight: .semibold, design: .serif))
            .foregroundColor(.ink)
            .padding(.bottom, 16)

        VStack(spacing: 16) {
            ChecklistItem(label: "I am in a state of Wudu'",
                          checked: state.wudu) { state.setWudu($0) }
            ChecklistItem(label: "I have located the Black Stone corner (there should be green lights to your right)",
                          checked: state.locatedBlackStone) { state.setLocatedBlackStone($0) }
            ChecklistItem(label: "I have kissed the Black Stone (if possible) or raised my right hand towards it",
                          checked: state.raisedHand) { state.setRaisedHand($0) }
        }
        .padding(.bottom, 16)

        if state.allTawafChecked {
            VStack(alignment: .leading, spacing: 0) {
                Text("Dua at the Black Stone")
                    .font(.system(size: 15, weight: .semibold, design: .serif))
                    .foregroundColor(.ink)
                    .padding(.bottom, 8)
                Text("Say this when you reach or raise your right hand towards the Black Stone to begin each lap.")
                    .font(.system(size: 13))
                    .foregroundColor(.muted)
                    .lineSpacing(3)
                    .padding(.bottom, 12)
                DuaBlock(arabic: blackStoneDua.arabic, transliteration: blackStoneDua.transliteration,
                         meaning: blackStoneDua.meaning)
                    .padding(.bottom, 20)

                Button("BEGIN TAWAF") { state.startTawaf() }
                    .primaryButton()
            }
        }
    }

    // MARK: — Active Tawaf

    @ViewBuilder
    private var activeTawafSection: some View {
        // Lap counter
        VStack(spacing: 8) {
            Text("Current lap")
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.muted)
                .tracking(2)
                .textCase(.uppercase)

            HStack(alignment: .lastTextBaseline, spacing: 8) {
                Text("\(state.currentLap)")
                    .font(.system(size: 72, weight: .light, design: .serif))
                    .foregroundColor(.ink)
                Text("/ 7")
                    .font(.system(size: 22, weight: .light, design: .serif))
                    .foregroundColor(.muted)
            }

            lapDots
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
        .padding(.bottom, 20)

        // Yemeni corner
        HStack(alignment: .top, spacing: 0) {
            Rectangle().fill(Color.gold).frame(width: 2)
            VStack(alignment: .leading, spacing: 6) {
                Text("YEMENI CORNER REMINDER")
                    .font(.system(size: 9, weight: .regular))
                    .foregroundColor(.muted)
                    .tracking(2)
                Text("When you pass the Yemeni corner (the one before the Black Stone), begin reciting:")
                    .font(.system(size: 12))
                    .foregroundColor(.inkLight)
                    .lineSpacing(3)
                DuaBlock(arabic: yemeniCornerDua.arabic, transliteration: yemeniCornerDua.transliteration,
                         meaning: yemeniCornerDua.meaning, source: yemeniCornerDua.source, compact: true)
            }
            .padding(.leading, 12)
        }
        .padding(.bottom, 20)

        // Rotating adhkar
        if !lapDuas.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text("RECOMMENDED DHIKR — LAP \(state.currentLap)")
                    .font(.system(size: 9, weight: .regular))
                    .foregroundColor(.muted)
                    .tracking(2)
                ForEach(Array(lapDuas.enumerated()), id: \.offset) { _, dua in
                    DuaBlock(arabic: dua.arabic, transliteration: dua.transliteration,
                             meaning: dua.meaning, source: dua.source, compact: true)
                }
            }
            .padding(.bottom, 20)
        }

        // Complete lap
        Rectangle().fill(Color.parchmentDark).frame(height: 1).padding(.bottom, 16)

        VStack(spacing: 10) {
            (Text("At the Black Stone, raise your hand and say ") +
             Text("الله أكبر").font(.system(size: 14)) +
             Text(", then tap when you have completed the circuit."))
                .font(.system(size: 12))
                .foregroundColor(.muted)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)

            Button("COMPLETE LAP \(state.currentLap)") { state.completeLap() }
                .primaryButton()
        }
    }

    private var lapDots: some View {
        HStack(spacing: 8) {
            ForEach(0..<7) { i in
                Circle()
                    .fill(
                        i < state.currentLap - 1 ? Color.gold :
                        i == state.currentLap - 1 ? Color.ink :
                        Color.parchmentDark
                    )
                    .frame(width: 8, height: 8)
            }
        }
    }

    // MARK: — Tawaf complete

    @ViewBuilder
    private var tawafCompleteSection: some View {
        VStack(spacing: 6) {
            Text("الله يتقبل")
                .font(.system(size: 26))
                .foregroundColor(.ink)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .environment(\.layoutDirection, .rightToLeft)
            Text("Tawaf complete — may Allah accept it.")
                .font(.system(size: 13))
                .foregroundColor(.muted)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
        .padding(.bottom, 24)

        MetricsCard(title: "Tawaf times", metrics: state.tawafMetrics(),
                    rowLabel: { "Lap \($0 + 1)" })
            .padding(.bottom, 24)

        // Maqam Ibrahim
        Text("Maqam Ibrahim")
            .font(.system(size: 15, weight: .semibold, design: .serif))
            .foregroundColor(.ink)
            .padding(.bottom, 10)

        DuaBlock(arabic: maqamIbrahimAyah.arabic, transliteration: maqamIbrahimAyah.transliteration,
                 meaning: maqamIbrahimAyah.meaning, source: maqamIbrahimAyah.source)
            .padding(.bottom, 12)

        Text("Pray two raka'ah behind Maqam Ibrahim — or anywhere behind it if it is crowded.")
            .font(.system(size: 13))
            .foregroundColor(.inkLight)
            .lineSpacing(3)
            .padding(.bottom, 10)

        VStack(alignment: .leading, spacing: 6) {
            raka_row("First raka'ah: Al-Fatiha, then", surah: "Al-Kafirun (109)")
            raka_row("Second raka'ah: Al-Fatiha, then", surah: "Al-Ikhlas (112)")
        }
        .padding(.bottom, 12)

        Text("Then drink from Zamzam. Face the Ka'bah and make dua. This is Sunnah.")
            .font(.system(size: 13))
            .foregroundColor(.inkLight)
            .lineSpacing(3)
            .padding(.bottom, 24)

        Button("PROCEED TO SAʿI →") { state.goToStage(4) }
            .primaryButton()
    }

    private func raka_row(_ prefix: String, surah: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("·").foregroundColor(.gold).font(.system(size: 14))
            (Text(prefix + " ").font(.system(size: 13)).foregroundColor(.inkLight) +
             Text(surah).font(.system(size: 13, weight: .medium)).foregroundColor(.ink))
        }
    }
}
