import SwiftUI

struct Stage2AtMiqat: View {
    let state: UmrahState

    var body: some View {
        let S = state.strings
        VStack(alignment: .leading, spacing: 0) {
            StageHeader(number: S.stage2Number, title: S.stage2Title, subtitle: S.stage2Subtitle)

            // Niyyah
            sectionTitle(S.niyyahTitle)
            Text(S.niyyahBody)
                .bodyText()
                .padding(.bottom, 12)

            DuaBlock(arabic: niyyah.arabic, transliteration: niyyah.transliteration,
                     meaning: niyyah.meaning, source: niyyah.source)

            HStack(alignment: .top, spacing: 0) {
                Rectangle().fill(Color.parchmentDark).frame(width: 2)
                if state.isArabic {
                    Text(S.niyyahNoteArabic)
                        .padding(.leading, 12)
                } else {
                    (Text(S.niyyahNotePre) +
                     Text(S.niyyahNoteItalic).italic() +
                     Text(S.niyyahNotePost))
                    .padding(.leading, 12)
                }
            }
            .font(.system(size: 12))
            .foregroundColor(.muted)
            .lineSpacing(2)
            .padding(.top, 12)
            .padding(.bottom, 24)

            Rectangle().fill(Color.parchmentDark).frame(height: 1).padding(.bottom, 24)

            // Talbiyah
            sectionTitle(S.talbiyahTitle)
            Text(S.talbiyahBody)
                .bodyText()
                .padding(.bottom, 12)

            DuaBlock(arabic: talbiyah.arabic, transliteration: talbiyah.transliteration,
                     meaning: talbiyah.meaning)

            Button {
                state.setTalbiyahStarted(!state.talbiyahStarted)
            } label: {
                HStack {
                    Spacer()
                    Text(state.talbiyahStarted ? S.talbiyahStarted : S.talbiyahMarkStarted)
                        .font(.system(size: 13))
                    Spacer()
                }
                .padding(.vertical, 12)
                .overlay(
                    Rectangle().stroke(
                        state.talbiyahStarted ? Color.gold : Color.parchmentDark,
                        lineWidth: 1
                    )
                )
                .foregroundColor(state.talbiyahStarted ? .gold : .inkLight)
                .background(state.talbiyahStarted ? Color.gold.opacity(0.08) : Color.clear)
            }
            .buttonStyle(.plain)
            .padding(.top, 16)
            .padding(.bottom, 24)

            Rectangle().fill(Color.parchmentDark).frame(height: 1).padding(.bottom, 24)

            // Entering the Mosque
            sectionTitle(S.mosqueTitle)
            (Text(S.mosquePre) +
             Text(S.mosqueBold).bold().foregroundColor(.ink) +
             Text(S.mosquePost))
                .font(.system(size: 13))
                .foregroundColor(.muted)
                .lineSpacing(3)
                .padding(.bottom, 12)

            DuaBlock(arabic: enteringMosque.arabic, transliteration: enteringMosque.transliteration,
                     meaning: enteringMosque.meaning)
                .padding(.bottom, 28)

            SectionDivider().padding(.bottom, 16)

            if !state.talbiyahStarted {
                Text(S.talbiyahReminder)
                    .font(.system(size: 11))
                    .foregroundColor(.muted)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)
            }

            Button(S.proceedToTawaf) { state.goToStage(3) }
                .primaryButton()
                .opacity(state.talbiyahStarted ? 1 : 0.4)
                .disabled(!state.talbiyahStarted)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .padding(.bottom, 16)
    }
}

private func sectionTitle(_ text: String) -> some View {
    Text(text)
        .font(.system(size: 15, weight: .semibold, design: .serif))
        .foregroundColor(.ink)
        .padding(.bottom, 6)
}

extension Text {
    func bodyText() -> some View {
        self
            .font(.system(size: 13))
            .foregroundColor(.muted)
            .lineSpacing(3)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
