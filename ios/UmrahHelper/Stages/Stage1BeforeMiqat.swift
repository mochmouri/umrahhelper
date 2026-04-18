import SwiftUI

private let dosAndDonts: [(text: String, isDo: Bool)] = [
    ("Make Ghusl (full body wash) before entering Ihram", true),
    ("Men: wear two white unstitched sheets (izaar + rida'). A belt can be used to secure them.", true),
    ("Women: wear modest, loose clothing — any colour", true),
    ("Make your Niyyah when you reach the Miqat", true),
    ("Clip nails and trim hair before — not permissible after Niyyah", true),
    ("No perfume or scented products — after Niyyah", false),
    ("Men: no stitched clothing — after Niyyah", false),
    ("Men: no head covering — after Niyyah", false),
    ("No cutting/plucking/shaving of hair or nails — after Niyyah", false),
    ("No sexual relations — after Niyyah", false),
    ("No arguing, fighting, cursing, or using foul language.", false),
    ("No hunting or disturbing wildlife. However, killing harmful animals (like snakes/scorpions) is allowed.", false),
]

struct Stage1BeforeMiqat: View {
    let state: UmrahState

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            StageHeader(number: "Stage 1", title: "Before Miqat",
                        subtitle: "Prepare your body, your garments, and your intention.")

            GoldBorderNote(text: "Travelling on Saudia Airlines? The cabin crew will announce when you are crossing the Miqat. Be ready in Ihram clothing before boarding, or at least before the announcement.")
                .padding(.bottom, 28)

            Text("Do's & Don'ts")
                .font(.system(size: 15, weight: .semibold, design: .serif))
                .foregroundColor(.ink)
                .padding(.bottom, 16)

            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(dosAndDonts.enumerated()), id: \.offset) { _, item in
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

            Text("Once you have made Ghusl and prepared your garments, proceed to the Miqat. You will make your Niyyah and begin reciting the Talbiyah there.")
                .font(.system(size: 13))
                .foregroundColor(.inkLight)
                .lineSpacing(3)
                .padding(.bottom, 16)

            Button("CONTINUE TO MIQAT →") { state.goToStage(2) }
                .primaryButton()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .padding(.bottom, 16)
    }
}
