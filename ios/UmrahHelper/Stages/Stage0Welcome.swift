import SwiftUI

struct Stage0Welcome: View {
    let state: UmrahState
    @State private var jumpAlertStage: Int? = nil

    var body: some View {
        let S = state.strings
        ZStack {
            Color.parchment.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {
                    Spacer(minLength: 40)

                    VStack(spacing: 10) {
                        Text("دَلِيلُ الْعُمْرَة")
                            .font(.system(size: 44))
                            .foregroundColor(.ink)
                            .frame(maxWidth: .infinity, alignment: .center)

                        Text(S.welcomeSubtitle)
                            .font(.system(size: 16, weight: .regular, design: .serif))
                            .italic()
                            .foregroundColor(.inkLight)
                            .multilineTextAlignment(.center)
                    }

                    SectionDivider()

                    Text(S.welcomeBody)
                        .font(.system(size: 14))
                        .foregroundColor(.inkLight)
                        .lineSpacing(4)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(S.welcomeTrustNote)
                        .font(.system(size: 11))
                        .foregroundColor(.muted)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Button(S.beginButton) {
                        state.startUmrah()
                    }
                    .primaryButton()

                    VStack(spacing: 12) {
                        Text(S.orJumpToStep)
                            .font(.system(size: 11))
                            .foregroundColor(.muted)

                        HStack(spacing: 4) {
                            ForEach(1...5, id: \.self) { s in
                                Button {
                                    if s <= state.stage + 1 {
                                        state.goToStage(s)
                                    } else {
                                        jumpAlertStage = s
                                    }
                                } label: {
                                    VStack(spacing: 5) {
                                        Circle()
                                            .fill(s <= state.stage ? Color.gold : Color.parchmentDark)
                                            .frame(width: 7, height: 7)
                                        Text(S.stageLabels[s - 1])
                                            .font(.system(size: 9))
                                            .foregroundColor(s <= state.stage ? Color.gold : Color.muted)
                                            .multilineTextAlignment(.center)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
            }
        }
        .alert(S.jumpAheadTitle, isPresented: Binding(
            get: { jumpAlertStage != nil },
            set: { if !$0 { jumpAlertStage = nil } }
        )) {
            Button(S.jumpAheadConfirm) {
                if let s = jumpAlertStage { state.goToStage(s) }
                jumpAlertStage = nil
            }
            Button(S.jumpAheadCancel, role: .cancel) { jumpAlertStage = nil }
        } message: {
            Text(S.jumpAheadMessage)
        }
    }
}
