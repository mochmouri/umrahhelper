import SwiftUI

private let stageLabels = ["Miqat Prep", "At Miqat", "Tawaf", "Saʿi", "Tahleel"]

struct Stage0Welcome: View {
    let state: UmrahState
    @State private var jumpAlertStage: Int? = nil

    var body: some View {
        ZStack {
            Color.parchment.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {
                    Spacer(minLength: 40)

                    VStack(spacing: 10) {
                        Text("دَلِيلُ الْعُمْرَة")
                            .font(.system(size: 44))
                            .foregroundColor(.ink)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .environment(\.layoutDirection, .rightToLeft)

                        Text("A step-by-step companion for your Umrah")
                            .font(.system(size: 16, weight: .regular, design: .serif))
                            .italic()
                            .foregroundColor(.inkLight)
                            .multilineTextAlignment(.center)
                    }

                    SectionDivider()

                    Text("Umrah is the lesser pilgrimage to Makkah; it is a voluntary act of worship that may be performed at any time of the year. Though shorter than Hajj, it carries immense spiritual weight and is a profound opportunity for renewal and closeness to Allah. This guide walks you through each step, from putting on Ihram to the final cut of the hair, so your heart can remain in worship rather than in logistics.")
                        .font(.system(size: 14))
                        .foregroundColor(.inkLight)
                        .lineSpacing(4)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Button("BEGIN") {
                        state.startUmrah()
                    }
                    .primaryButton()

                    VStack(spacing: 12) {
                        Text("or jump to a step")
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
                                        Text(stageLabels[s - 1])
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
        .alert("Jump ahead?", isPresented: Binding(
            get: { jumpAlertStage != nil },
            set: { if !$0 { jumpAlertStage = nil } }
        )) {
            Button("Jump ahead") {
                if let s = jumpAlertStage { state.goToStage(s) }
                jumpAlertStage = nil
            }
            Button("Cancel", role: .cancel) { jumpAlertStage = nil }
        } message: {
            Text("You haven't reached this step yet. Jump ahead anyway?")
        }
    }
}
