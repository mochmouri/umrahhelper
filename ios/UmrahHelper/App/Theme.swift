import SwiftUI
import UIKit

// MARK: - Text scale environment key

private struct AppTextScaleKey: EnvironmentKey {
    static let defaultValue: Double = 1.0
}
extension EnvironmentValues {
    var appTextScale: Double {
        get { self[AppTextScaleKey.self] }
        set { self[AppTextScaleKey.self] = newValue }
    }
}

extension Color {
    // All colours are adaptive: light → parchment palette, dark → warm dark palette
    static let parchment = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 18/255,  green: 18/255,  blue: 14/255,  alpha: 1) // #12120E
            : UIColor(red: 250/255, green: 247/255, blue: 242/255, alpha: 1) // #FAF7F2
    })
    static let parchmentDark = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 36/255,  green: 34/255,  blue: 28/255,  alpha: 1) // #24221C
            : UIColor(red: 237/255, green: 231/255, blue: 220/255, alpha: 1) // #EDE7DC
    })
    static let ink = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 240/255, green: 236/255, blue: 226/255, alpha: 1) // #F0ECE2
            : UIColor(red: 26/255,  green: 26/255,  blue: 26/255,  alpha: 1) // #1A1A1A
    })
    static let inkLight = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 176/255, green: 168/255, blue: 154/255, alpha: 1) // #B0A89A
            : UIColor(red: 74/255,  green: 74/255,  blue: 74/255,  alpha: 1) // #4A4A4A
    })
    static let muted = Color(UIColor { tc in
        tc.userInterfaceStyle == .dark
            ? UIColor(red: 112/255, green: 102/255, blue: 88/255,  alpha: 1) // #706658
            : UIColor(red: 138/255, green: 122/255, blue: 106/255, alpha: 1) // #8A7A6A
    })
    static let gold      = Color(red: 201/255, green: 168/255, blue: 76/255)
    static let greenSoft = Color(red: 61/255,  green: 122/255, blue: 90/255)
    static let redSoft   = Color(red: 155/255, green: 58/255,  blue: 58/255)
}

struct PrimaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.ink)
            .foregroundColor(.parchment)
            .font(.system(size: 12, weight: .regular))
            .tracking(2)
    }
}

struct GhostButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
            .foregroundColor(.muted)
            .font(.system(size: 12, weight: .regular))
            .tracking(2)
    }
}

extension View {
    func primaryButton() -> some View { modifier(PrimaryButton()) }
    func ghostButton() -> some View { modifier(GhostButton()) }
}

struct SectionDivider: View {
    var body: some View {
        HStack(spacing: 12) {
            Rectangle().fill(Color.parchmentDark).frame(height: 1)
            Text("✦").font(.system(size: 13)).foregroundColor(.gold)
            Rectangle().fill(Color.parchmentDark).frame(height: 1)
        }
    }
}

struct StageHeader: View {
    let number: String
    let title: String
    let subtitle: String

    @Environment(\.appTextScale) private var ts

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(number.uppercased())
                .font(.system(size: 10 * CGFloat(ts), weight: .regular))
                .foregroundColor(.gold)
                .tracking(3)
            Text(title)
                .font(.system(size: 22 * CGFloat(ts), weight: .semibold, design: .serif))
                .foregroundColor(.ink)
            Text(subtitle)
                .font(.system(size: 13 * CGFloat(ts)))
                .foregroundColor(.muted)
                .lineSpacing(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 24)
    }
}

struct GoldBorderNote: View {
    let text: String

    @Environment(\.appTextScale) private var ts

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Rectangle().fill(Color.gold).frame(width: 2)
            Text(text)
                .font(.system(size: 13 * CGFloat(ts)))
                .foregroundColor(.inkLight)
                .lineSpacing(3)
                .padding(.leading, 12)
                .padding(.vertical, 2)
        }
    }
}
