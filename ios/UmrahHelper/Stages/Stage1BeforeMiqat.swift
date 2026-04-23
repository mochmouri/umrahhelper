import SwiftUI

struct Stage1BeforeMiqat: View {
    let state: UmrahState

    var body: some View {
        let S = state.strings
        VStack(alignment: .leading, spacing: 0) {
            StageHeader(number: S.stage1Number, title: S.stage1Title, subtitle: S.stage1Subtitle)

            GoldBorderNote(text: S.saudiaNote)
                .padding(.bottom, 28)

            Text(S.dosAndDontsTitle)
                .font(.system(size: 15, weight: .semibold, design: .serif))
                .foregroundColor(.ink)
                .padding(.bottom, 16)

            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(S.dosAndDonts.enumerated()), id: \.offset) { _, item in
                    HStack(alignment: .top, spacing: 12) {
                        Text(item.isDo ? "✓" : "✕")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(item.isDo ? .greenSoft : .redSoft)
                            .frame(width: 18, alignment: .center)
                            .padding(.top, 2)
                        Text(item.text)
                            .font(.system(size: 13))
                            .foregroundColor(item.isDo ? .ink : .inkLight)
                            .lineSpacing(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding(.bottom, 32)

            SectionDivider().padding(.bottom, 24)

            Text(S.stage1BodyText)
                .font(.system(size: 13))
                .foregroundColor(.inkLight)
                .lineSpacing(3)
                .padding(.bottom, 16)

            Button(S.continueToMiqat) { state.goToStage(2) }
                .primaryButton()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .padding(.bottom, 16)
    }
}
