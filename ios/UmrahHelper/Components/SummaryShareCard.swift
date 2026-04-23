import SwiftUI
import UIKit

// MARK: - Share card view (always renders in light / parchment colours)

struct SummaryShareCard: View {
    let date: Date
    let tawafFormatted: String
    let saiFormatted: String
    let totalFormatted: String
    let isArabic: Bool

    private var S: AppStrings { AppStrings(isArabic: isArabic) }

    // Fixed light-mode colours so the card always looks consistent
    private let bg       = Color(red: 250/255, green: 247/255, blue: 242/255)
    private let border   = Color(red: 237/255, green: 231/255, blue: 220/255)
    private let inkC     = Color(red: 26/255,  green: 26/255,  blue: 26/255)
    private let inkLightC = Color(red: 74/255,  green: 74/255,  blue: 74/255)
    private let mutedC   = Color(red: 138/255, green: 122/255, blue: 106/255)
    private let goldC    = Color(red: 201/255, green: 168/255, blue: 76/255)

    var body: some View {
        VStack(spacing: 0) {

            // Header
            VStack(spacing: 8) {
                Text("الله يتقبل")
                    .font(.system(size: 36))
                    .foregroundColor(goldC)
                    .environment(\.layoutDirection, .rightToLeft)

                Text("دَلِيلُ الْعُمْرَة")
                    .font(.system(size: 17))
                    .foregroundColor(inkC)

                Text(date.formatted(date: .long, time: .omitted))
                    .font(.system(size: 12))
                    .foregroundColor(mutedC)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 26)
            .padding(.horizontal, 28)

            separator

            // Stats
            VStack(spacing: 0) {
                statRow(label: S.tawafLabel, value: tawafFormatted, bold: false)
                border.frame(height: 1)
                statRow(label: S.saiLabel,   value: saiFormatted,   bold: false)
                border.frame(height: 1)
                statRow(label: S.totalUmrahLabel, value: totalFormatted, bold: true)
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 12)

            separator

            // Footer
            Text("Umrah Helper")
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(mutedC)
                .tracking(2)
                .padding(.top, 14)
                .padding(.bottom, 18)
        }
        .frame(width: 360)
        .background(bg)
        .environment(\.layoutDirection, isArabic ? .rightToLeft : .leftToRight)
    }

    private var separator: some View {
        HStack(spacing: 12) {
            border.frame(height: 1)
            Text("✦").font(.system(size: 11)).foregroundColor(goldC)
            border.frame(height: 1)
        }
        .padding(.horizontal, 28)
    }

    private func statRow(label: String, value: String, bold: Bool) -> some View {
        HStack {
            Text(label)
                .font(bold ? .system(size: 13, weight: .semibold) : .system(size: 13))
                .foregroundColor(bold ? inkC : mutedC)
            Spacer()
            Text(value)
                .font(bold ? .system(size: 13, weight: .semibold).monospacedDigit()
                           : .system(size: 13).monospacedDigit())
                .foregroundColor(bold ? inkC : inkLightC)
        }
        .padding(.vertical, 10)
    }
}

// MARK: - Image renderer

@MainActor
func renderSummaryCard(date: Date, tawaf: String, sai: String, total: String, isArabic: Bool) -> UIImage? {
    let card = SummaryShareCard(
        date: date,
        tawafFormatted: tawaf,
        saiFormatted: sai,
        totalFormatted: total,
        isArabic: isArabic
    )
    let renderer = ImageRenderer(content: card)
    renderer.scale = 3
    return renderer.uiImage
}

// MARK: - UIActivityViewController wrapper

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    func updateUIViewController(_ vc: UIActivityViewController, context: Context) {}
}
