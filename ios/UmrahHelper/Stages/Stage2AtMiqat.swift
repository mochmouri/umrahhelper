import SwiftUI

struct Stage2AtMiqat: View {
    let state: UmrahState

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            StageHeader(number: "Stage 2", title: "At the Miqat",
                        subtitle: "The moment you make Niyyah, Ihram begins.")

            // Niyyah
            sectionTitle("Niyyah — The Intention")
            Text("Face the Qibla (if possible), put on your Ihram garments if not already wearing them, and make this intention with your heart. Say it aloud.")
                .bodyText()
                .padding(.bottom, 12)

            DuaBlock(arabic: niyyah.arabic, transliteration: niyyah.transliteration,
                     meaning: niyyah.meaning, source: niyyah.source)

            HStack(alignment: .top, spacing: 0) {
                Rectangle().fill(Color.parchmentDark).frame(width: 2)
                Text("There are several forms of declaring your intention. The benefit of this particular form is that if an obstacle prevents completion — such as illness, lack of funds, menstruation for women, or any other emergency — the person in Ihram may exit their Ihram and is not required to offer the sacrifice due for being prevented (")
                + Text("hady al-iḥṣār").italic()
                + Text("), nor any expiatory sacrifice.")
            }
            .font(.system(size: 12))
            .foregroundColor(.muted)
            .lineSpacing(2)
            .padding(.top, 12)
            .padding(.bottom, 24)

            Rectangle().fill(Color.parchmentDark).frame(height: 1).padding(.bottom, 24)

            // Talbiyah
            sectionTitle("Talbiyah")
            Text("Begin reciting the Talbiyah immediately after Niyyah. Continue reciting it — loudly for men, softly for women — until you begin Tawaf.")
                .bodyText()
                .padding(.bottom, 12)

            DuaBlock(arabic: talbiyah.arabic, transliteration: talbiyah.transliteration,
                     meaning: talbiyah.meaning)

            Button {
                state.setTalbiyahStarted(!state.talbiyahStarted)
            } label: {
                HStack {
                    Spacer()
                    Text(state.talbiyahStarted ? "✓  I have started reciting" : "Mark as started")
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
            sectionTitle("Entering Al-Masjid Al-Haraam")
            (Text("Enter with your ") +
             Text("right foot first").bold().foregroundColor(.ink) +
             Text(". Say this dua as you step inside. When you first see the Ka'bah, pause — this is a moment when duas are answered."))
                .font(.system(size: 13))
                .foregroundColor(.muted)
                .lineSpacing(3)
                .padding(.bottom, 12)

            DuaBlock(arabic: enteringMosque.arabic, transliteration: enteringMosque.transliteration,
                     meaning: enteringMosque.meaning)
                .padding(.bottom, 28)

            SectionDivider().padding(.bottom, 16)

            if !state.talbiyahStarted {
                Text("Mark the Talbiyah as started before proceeding.")
                    .font(.system(size: 11))
                    .foregroundColor(.muted)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)
            }

            Button("PROCEED TO TAWAF →") { state.goToStage(3) }
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
