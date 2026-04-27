import SwiftUI

// ── Replace these with your real URLs ────────────────────────────────────────
private let donationURL   = URL(string: "https://buy.stripe.com/eVq9AT6003aAbj2fCs1oI00")!
private let appURL        = URL(string: "https://mochmouri.github.io/umrahhelper/")!
private let formspreeURL  = URL(string: "https://formspree.io/f/xrerwzle")!
// ─────────────────────────────────────────────────────────────────────────────

enum MessageType: String, CaseIterable {
    case question, correction, general
    func label(_ S: AppStrings) -> String {
        switch self {
        case .question:   return S.aboutTypeQuestion
        case .correction: return S.aboutTypeCorrection
        case .general:    return S.aboutTypeGeneral
        }
    }
}

enum SendState { case idle, sending, success, error }

struct AboutView: View {
    @Environment(\.appTextScale) private var ts
    let state: UmrahState

    @State private var showShareSheet = false
    @State private var msgType: MessageType = .general
    @State private var name  = ""
    @State private var email = ""
    @State private var message = ""
    @State private var sendState: SendState = .idle

    var body: some View {
        let S = state.strings
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                // ── Intro ─────────────────────────────────────────────────
                Text(S.aboutIntroTitle)
                    .font(.system(size: 20 * CGFloat(ts), weight: .semibold, design: .serif))
                    .foregroundColor(.ink)
                    .padding(.bottom, 10)

                Text(S.aboutIntroBody)
                    .font(.system(size: 13 * CGFloat(ts)))
                    .foregroundColor(.inkLight)
                    .lineSpacing(3)
                    .padding(.bottom, 32)

                divider

                // ── Free / Donate ──────────────────────────────────────────
                Text(S.aboutFreeTitle)
                    .font(.system(size: 20 * CGFloat(ts), weight: .semibold, design: .serif))
                    .foregroundColor(.ink)
                    .padding(.bottom, 10)

                Text(S.aboutFreeBody)
                    .font(.system(size: 13 * CGFloat(ts)))
                    .foregroundColor(.inkLight)
                    .lineSpacing(3)
                    .padding(.bottom, 16)

                Link(destination: donationURL) {
                    Text(S.aboutDonateButton)
                        .font(.system(size: 12 * CGFloat(ts), weight: .regular))
                        .foregroundColor(.gold)
                        .tracking(2)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .overlay(Rectangle().stroke(Color.gold, lineWidth: 1))
                }
                .padding(.bottom, 32)

                divider

                // ── Share ──────────────────────────────────────────────────
                Text(S.aboutShareTitle)
                    .font(.system(size: 20 * CGFloat(ts), weight: .semibold, design: .serif))
                    .foregroundColor(.ink)
                    .padding(.bottom, 10)

                Text(S.aboutShareBody)
                    .font(.system(size: 13 * CGFloat(ts)))
                    .foregroundColor(.inkLight)
                    .lineSpacing(3)
                    .padding(.bottom, 16)

                Button {
                    showShareSheet = true
                } label: {
                    Text(S.aboutShareButton)
                        .font(.system(size: 12 * CGFloat(ts), weight: .regular))
                        .foregroundColor(.ink)
                        .tracking(2)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
                }
                .buttonStyle(.plain)
                .padding(.bottom, 32)
                .sheet(isPresented: $showShareSheet) {
                    ShareSheet(items: [appURL])
                }

                divider

                // ── Contact form ───────────────────────────────────────────
                Text(S.aboutContactTitle)
                    .font(.system(size: 20 * CGFloat(ts), weight: .semibold, design: .serif))
                    .foregroundColor(.ink)
                    .padding(.bottom, 10)

                Text(S.aboutContactBody)
                    .font(.system(size: 13 * CGFloat(ts)))
                    .foregroundColor(.inkLight)
                    .lineSpacing(3)
                    .padding(.bottom, 16)

                if sendState == .success {
                    Text(S.aboutContactSuccess)
                        .font(.system(size: 13 * CGFloat(ts)))
                        .foregroundColor(.inkLight)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 24)
                        .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
                } else {
                    // Type picker
                    HStack(spacing: 8) {
                        ForEach(MessageType.allCases, id: \.self) { t in
                            Button {
                                msgType = t
                            } label: {
                                Text(t.label(S))
                                    .font(.system(size: 11 * CGFloat(ts)))
                                    .foregroundColor(msgType == t ? .ink : .muted)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .overlay(Rectangle().stroke(
                                        msgType == t ? Color.ink : Color.parchmentDark,
                                        lineWidth: msgType == t ? 1.5 : 1
                                    ))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom, 12)

                    formField(placeholder: S.aboutContactName, text: $name)
                        .padding(.bottom, 10)

                    formField(placeholder: S.aboutContactEmail, text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.bottom, 10)

                    ZStack(alignment: .topLeading) {
                        if message.isEmpty {
                            Text(S.aboutContactMessage)
                                .font(.system(size: 13 * CGFloat(ts)))
                                .foregroundColor(.muted)
                                .padding(.top, 10)
                                .padding(.leading, 4)
                        }
                        TextEditor(text: $message)
                            .font(.system(size: 13 * CGFloat(ts)))
                            .foregroundColor(.ink)
                            .frame(minHeight: 120)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                    }
                    .padding(10)
                    .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
                    .padding(.bottom, 12)

                    if sendState == .error {
                        Text(S.aboutContactError)
                            .font(.system(size: 11 * CGFloat(ts)))
                            .foregroundColor(.red)
                            .padding(.bottom, 8)
                    }

                    Button {
                        submitForm(S: S)
                    } label: {
                        Text(sendState == .sending ? S.aboutContactSending : S.aboutContactSend)
                            .font(.system(size: 12 * CGFloat(ts), weight: .regular))
                            .tracking(2)
                            .textCase(.uppercase)
                            .foregroundColor(.parchment)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.ink)
                    }
                    .buttonStyle(.plain)
                    .opacity(message.trimmingCharacters(in: .whitespaces).isEmpty || sendState == .sending ? 0.4 : 1)
                    .disabled(message.trimmingCharacters(in: .whitespaces).isEmpty || sendState == .sending)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 40)
        }
        .background(Color.parchment.ignoresSafeArea())
        .environment(\.layoutDirection, state.isArabic ? .rightToLeft : .leftToRight)
    }

    private var divider: some View {
        HStack(spacing: 12) {
            Rectangle().fill(Color.parchmentDark).frame(height: 1)
            Text("✦").foregroundColor(.gold)
            Rectangle().fill(Color.parchmentDark).frame(height: 1)
        }
        .padding(.bottom, 32)
    }

    private func formField(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .font(.system(size: 13 * CGFloat(ts)))
            .foregroundColor(.ink)
            .padding(10)
            .overlay(Rectangle().stroke(Color.parchmentDark, lineWidth: 1))
    }

    private func submitForm(S: AppStrings) {
        guard !message.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        sendState = .sending

        var request = URLRequest(url: formspreeURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let body: [String: String] = [
            "type": msgType.rawValue,
            "name": name.isEmpty ? "(not provided)" : name,
            "email": email.isEmpty ? "(not provided)" : email,
            "message": message,
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { _, response, _ in
            DispatchQueue.main.async {
                let code = (response as? HTTPURLResponse)?.statusCode ?? 0
                if (200..<300).contains(code) {
                    sendState = .success
                    name = ""; email = ""; message = ""; msgType = .general
                } else {
                    sendState = .error
                }
            }
        }.resume()
    }
}
