import SwiftUI

struct DuaBlock: View {
    let arabic: String
    let transliteration: String
    let meaning: String
    var source: String? = nil
    var compact: Bool = false

    @Environment(\.appTextScale) private var ts

    private var arabicSize: CGFloat  { (compact ? 18 : 22) * CGFloat(ts) }
    private var transSize: CGFloat   { (compact ? 11 : 12) * CGFloat(ts) }
    private var meaningSize: CGFloat { (compact ? 12 : 13) * CGFloat(ts) }
    private var spacing: CGFloat { compact ? 8 : 12 }
    private var padding: CGFloat { compact ? 12 : 16 }

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text(arabic)
                .font(.custom("Amiri-Regular", size: arabicSize))
                .foregroundColor(.ink)
                .environment(\.layoutDirection, .rightToLeft)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .lineSpacing(6)

            Text(transliteration)
                .font(.system(size: transSize, weight: .regular).italic())
                .foregroundColor(.muted)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .environment(\.layoutDirection, .leftToRight)

            Text(meaning)
                .font(.system(size: meaningSize))
                .foregroundColor(.inkLight)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .environment(\.layoutDirection, .leftToRight)

            if let source {
                Text(source)
                    .font(.system(size: 10 * CGFloat(ts)))
                    .foregroundColor(.muted)
            }
        }
        .padding(padding)
        .background(Color.parchmentDark.opacity(0.4))
    }
}
