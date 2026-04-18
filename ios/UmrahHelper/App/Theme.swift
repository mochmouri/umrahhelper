import SwiftUI

extension Color {
    static let parchment     = Color(red: 250/255, green: 247/255, blue: 242/255)
    static let parchmentDark = Color(red: 237/255, green: 231/255, blue: 220/255)
    static let ink           = Color(red: 26/255,  green: 26/255,  blue: 26/255)
    static let inkLight      = Color(red: 74/255,  green: 74/255,  blue: 74/255)
    static let muted         = Color(red: 138/255, green: 122/255, blue: 106/255)
    static let gold          = Color(red: 201/255, green: 168/255, blue: 76/255)
    static let greenSoft     = Color(red: 61/255,  green: 122/255, blue: 90/255)
    static let redSoft       = Color(red: 155/255, green: 58/255,  blue: 58/255)
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

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(number.uppercased())
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.gold)
                .tracking(3)
            Text(title)
                .font(.system(size: 22, weight: .semibold, design: .serif))
                .foregroundColor(.ink)
            Text(subtitle)
                .font(.system(size: 13))
                .foregroundColor(.muted)
                .lineSpacing(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 24)
    }
}

struct GoldBorderNote: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Rectangle().fill(Color.gold).frame(width: 2)
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(.inkLight)
                .lineSpacing(3)
                .padding(.leading, 12)
                .padding(.vertical, 2)
        }
    }
}
