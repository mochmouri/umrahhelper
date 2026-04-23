import SwiftUI

struct Stage3Tawaf: View {
    let state: UmrahState
    @Environment(\.appTextScale) private var ts
    @State private var maqamChecked = false
    @State private var showLapDhikr = false

    private var lapDuas: [Dua] {
        guard state.tawafStarted, state.currentLap >= 1, state.currentLap <= 7 else { return [] }
        return getDuasForLap(state.currentLap)
    }

    var body: some View {
        let S = state.strings
        VStack(alignment: .leading, spacing: 0) {
            StageHeader(number: S.stage3Number, title: S.stage3Title, subtitle: S.stage3Subtitle)

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
        .onChange(of: state.currentLap) { _, _ in
            withAnimation(.easeInOut(duration: 0.2)) { showLapDhikr = false }
        }
    }

    // MARK: — Pre-checklist

    @ViewBuilder
    private var rpreChecklistSection: some View {
        let S = state.strings
        Text(S.beforeYouBegin)
            .font(.system(size: 15, weight: .semibold, design: .serif))
            .foregroundColor(.ink)
            .padding(.bottom, 16)

        VStack(spacing: 16) {
            ChecklistItem(label: S.checkWudu,
                          checked: state.wudu) { state.setWudu($0) }
            ChecklistItem(label: S.checkBlackStone,
                          checked: state.locatedBlackStone) { state.setLocatedBlackStone($0) }
            ChecklistItem(label: S.checkRaisedHand,
                          checked: state.raisedHand) { state.setRaisedHand($0) }
        }
        .padding(.bottom, 16)

        if state.allTawafChecked {
            VStack(alignment: .leading, spacing: 0) {
                Text(S.blackStoneDuaTitle)
                    .font(.system(size: 15, weight: .semibold, design: .serif))
                    .foregroundColor(.ink)
                    .padding(.bottom, 8)
                Text(S.blackStoneDuaBody)
                    .font(.system(size: 13))
                    .foregroundColor(.muted)
                    .lineSpacing(3)
                    .padding(.bottom, 12)
                DuaBlock(arabic: blackStoneDua.arabic, transliteration: blackStoneDua.transliteration,
                         meaning: blackStoneDua.meaning)
                    .padding(.bottom, 20)

                Button(S.beginTawaf) { state.startTawaf() }
                    .primaryButton()
            }
        }
    }

    // MARK: — Active Tawaf

    @ViewBuilder
    private var activeTawafSection: some View {
        let S = state.strings
        let lapReady = state.yemeniCornerChecked && state.blackStonePassChecked

        // 1. Black Stone — beginning of lap
        HStack(alignment: .top, spacing: 0) {
            Rectangle().fill(Color.gold).frame(width: 2)
            VStack(alignment: .leading, spacing: 6) {
                Text(S.blackStonePassTitle)
                    .font(.system(size: 9 * CGFloat(ts), weight: .regular))
                    .foregroundColor(.muted)
                    .tracking(2)
                Text(S.blackStonePassBody)
                    .font(.system(size: 12 * CGFloat(ts)))
                    .foregroundColor(.inkLight)
                    .lineSpacing(3)
                Text("الله أكبر")
                    .font(.system(size: 18 * CGFloat(ts)))
                    .foregroundColor(.ink)
                    .environment(\.layoutDirection, .rightToLeft)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if !state.isArabic {
                    Text("Allahu Akbar")
                        .font(.system(size: 12 * CGFloat(ts), weight: .regular).italic())
                        .foregroundColor(.muted)
                }
            }
            .padding(.leading, 12)
        }
        .padding(.bottom, 10)

        ChecklistItem(label: S.checkBlackStonePass,
                      checked: state.blackStonePassChecked) { state.setBlackStonePassChecked($0) }
            .padding(.bottom, 20)

        // 2. Counter
        VStack(spacing: 8) {
            Text(S.currentLapLabel)
                .font(.system(size: 10 * CGFloat(ts), weight: .regular))
                .foregroundColor(.muted)
                .tracking(2)
                .textCase(.uppercase)

            HStack(alignment: .lastTextBaseline, spacing: 8) {
                if state.isArabic {
                    Text("\(S.numeral(7)) /")
                        .font(.system(size: 22 * CGFloat(ts), weight: .light, design: .serif))
                        .foregroundColor(.muted)
                    Text(S.numeral(state.currentLap))
                        .font(.system(size: 72 * CGFloat(ts), weight: .light, design: .serif))
                        .foregroundColor(.ink)
                } else {
                    Text("\(state.currentLap)")
                        .font(.system(size: 72 * CGFloat(ts), weight: .light, design: .serif))
                        .foregroundColor(.ink)
                    Text("/ 7")
                        .font(.system(size: 22 * CGFloat(ts), weight: .light, design: .serif))
                        .foregroundColor(.muted)
                }
            }
            .environment(\.layoutDirection, .leftToRight)

            lapDots
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
        .padding(.bottom, 20)

        // 2. Yemeni corner instruction + checkbox
        HStack(alignment: .top, spacing: 0) {
            Rectangle().fill(Color.gold).frame(width: 2)
            VStack(alignment: .leading, spacing: 6) {
                Text(S.yemeniCornerTitle)
                    .font(.system(size: 9 * CGFloat(ts), weight: .regular))
                    .foregroundColor(.muted)
                    .tracking(2)
                Text(S.yemeniCornerBody)
                    .font(.system(size: 12 * CGFloat(ts)))
                    .foregroundColor(.inkLight)
                    .lineSpacing(3)
                DuaBlock(arabic: yemeniCornerDua.arabic, transliteration: yemeniCornerDua.transliteration,
                         meaning: yemeniCornerDua.meaning, source: yemeniCornerDua.source, compact: true)
            }
            .padding(.leading, 12)
        }
        .padding(.bottom, 10)

        ChecklistItem(label: S.checkYemeniCorner,
                      checked: state.yemeniCornerChecked) { state.setYemeniCornerChecked($0) }
            .padding(.bottom, 16)

        // 3. Recommended dhikr — collapsible
        if !lapDuas.isEmpty {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) { showLapDhikr.toggle() }
            } label: {
                HStack {
                    Text(showLapDhikr ? S.hideDhikr : S.showDhikr(lapDuas.count))
                        .font(.system(size: 11 * CGFloat(ts), weight: .regular))
                        .foregroundColor(.muted)
                        .tracking(1)
                    Spacer()
                    Image(systemName: showLapDhikr ? "chevron.up" : "chevron.down")
                        .font(.system(size: 10))
                        .foregroundColor(.muted)
                }
            }
            .buttonStyle(.plain)
            .padding(.bottom, showLapDhikr ? 10 : 16)

            if showLapDhikr {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(Array(lapDuas.enumerated()), id: \.offset) { _, dua in
                        DuaBlock(arabic: dua.arabic, transliteration: dua.transliteration,
                                 meaning: dua.meaning, source: dua.source, compact: true)
                    }
                }
                .padding(.bottom, 10)

                HStack(alignment: .top, spacing: 0) {
                    Rectangle().fill(Color.parchmentDark).frame(width: 2)
                    Text(S.tawafAdhkarNote)
                        .font(.system(size: 12 * CGFloat(ts)))
                        .foregroundColor(.muted)
                        .lineSpacing(3)
                        .padding(.leading, 12)
                }
                .padding(.bottom, 16)
            }
        } else {
            // No lap-specific duas — still show the general adhkar note
            HStack(alignment: .top, spacing: 0) {
                Rectangle().fill(Color.parchmentDark).frame(width: 2)
                Text(S.tawafAdhkarNote)
                    .font(.system(size: 12 * CGFloat(ts)))
                    .foregroundColor(.muted)
                    .lineSpacing(3)
                    .padding(.leading, 12)
            }
            .padding(.bottom, 16)
        }

        Rectangle().fill(Color.parchmentDark).frame(height: 1).padding(.bottom, 16)

        Button(S.completeLapButton(state.currentLap)) { state.completeLap() }
            .primaryButton()
            .opacity(lapReady ? 1.0 : 0.35)
            .disabled(!lapReady)
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
        let S = state.strings
        VStack(spacing: 6) {
            Text("الله يتقبل")
                .font(.system(size: 26))
                .foregroundColor(.ink)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .environment(\.layoutDirection, .rightToLeft)
            Text(S.tawafCompleteMessage)
                .font(.system(size: 13))
                .foregroundColor(.muted)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
        .padding(.bottom, 24)

        MetricsCard(title: S.tawafTimesTitle, metrics: state.tawafMetrics(),
                    rowLabel: { S.lapLabel($0) })
            .padding(.bottom, 24)

        Text(S.maqamTitle)
            .font(.system(size: 15, weight: .semibold, design: .serif))
            .foregroundColor(.ink)
            .padding(.bottom, 4)

        HStack(alignment: .top, spacing: 0) {
            Rectangle().fill(Color.parchmentDark).frame(width: 2)
            Text(S.maqamSunnahNote)
                .font(.system(size: 12 * CGFloat(ts)))
                .foregroundColor(.muted)
                .lineSpacing(3)
                .padding(.leading, 12)
        }
        .padding(.bottom, 10)

        DuaBlock(arabic: maqamIbrahimAyah.arabic, transliteration: maqamIbrahimAyah.transliteration,
                 meaning: maqamIbrahimAyah.meaning, source: maqamIbrahimAyah.source)
            .padding(.bottom, 12)

        Text(S.maqamBody)
            .font(.system(size: 13 * CGFloat(ts)))
            .foregroundColor(.inkLight)
            .lineSpacing(3)
            .padding(.bottom, 10)

        VStack(alignment: .leading, spacing: 6) {
            raka_row(S.raka1Pre, surah: S.raka1Surah)
            raka_row(S.raka2Pre, surah: S.raka2Surah)
        }
        .padding(.bottom, 12)

        ChecklistItem(label: S.checkMaqam, checked: maqamChecked) { maqamChecked = $0 }
            .padding(.bottom, 12)

        Text(S.zamzamText)
            .font(.system(size: 13 * CGFloat(ts)))
            .foregroundColor(.inkLight)
            .lineSpacing(3)
            .padding(.bottom, 24)

        Button(S.proceedToSai) { state.goToStage(4) }
            .primaryButton()
    }

    private func raka_row(_ prefix: String, surah: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("·").foregroundColor(.gold).font(.system(size: 14 * CGFloat(ts)))
            (Text(prefix + " ").font(.system(size: 13 * CGFloat(ts))).foregroundColor(.inkLight) +
             Text(surah).font(.system(size: 13 * CGFloat(ts), weight: .medium)).foregroundColor(.ink))
        }
    }
}
