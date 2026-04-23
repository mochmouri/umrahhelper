import SwiftUI

struct AdhkarView: View {
    @AppStorage("isArabic") private var isArabic = false
    private var S: AppStrings { AppStrings(isArabic: isArabic) }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.parchment.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(S.adhkarSubtitle)
                            .font(.system(size: 13))
                            .foregroundColor(.muted)
                            .lineSpacing(3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 24)

                        VStack(spacing: 12) {
                            ForEach(Array(adhkarPool.enumerated()), id: \.offset) { index, dua in
                                DuaBlock(
                                    arabic: dua.arabic,
                                    transliteration: dua.transliteration,
                                    meaning: dua.meaning,
                                    source: dua.source
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                    .frame(maxWidth: 480)
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle(S.adhkarNavTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.parchment, for: .navigationBar)
        }
        .environment(\.layoutDirection, isArabic ? .rightToLeft : .leftToRight)
    }
}
