import SwiftUI

struct ContentView: View {
    @State private var state = UmrahState()
    @State private var showingBackConfirm = false
    @State private var selectedTab = 0

    private var scrollKey: String {
        "\(state.stage)-\(state.currentLap)-\(state.currentRound)" +
        "-\(state.tawafStarted ? 1 : 0)-\(state.tawafComplete ? 1 : 0)" +
        "-\(state.saiStarted ? 1 : 0)-\(state.saiComplete ? 1 : 0)"
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            guideTab
                .tabItem {
                    Label(state.strings.tabGuide, systemImage: "book")
                }
                .tag(0)

            HistoryView()
                .tabItem {
                    Label(state.strings.tabHistory, systemImage: "clock")
                }
                .tag(1)

            AdhkarView()
                .tabItem {
                    Label(state.strings.tabAdhkar, systemImage: "text.book.closed")
                }
                .tag(2)
        }
        .tint(Color.gold)
        .preferredColorScheme(state.isDarkMode ? .dark : .light)
        .environment(\.appTextScale, state.textScale)
    }

    private var guideTab: some View {
        ZStack(alignment: .top) {
            Color.parchment.ignoresSafeArea()

            if state.stage == 0 {
                Stage0Welcome(state: state)
                    .environment(\.layoutDirection, state.isArabic ? .rightToLeft : .leftToRight)
            } else {
                VStack(spacing: 0) {
                    UmrahProgressBar(currentStage: state.stage)

                    ScrollView {
                        stageContent
                            .environment(\.layoutDirection, state.isArabic ? .rightToLeft : .leftToRight)
                            .frame(maxWidth: 480)
                            .frame(maxWidth: .infinity)
                    }
                    .id(scrollKey)

                    if state.stage > 0 {
                        Button(state.strings.backButton) {
                            if state.stage > 1 {
                                showingBackConfirm = true
                            } else {
                                withAnimation(.easeInOut(duration: 0.2)) { state.goBack() }
                            }
                        }
                        .font(.system(size: 12))
                        .foregroundColor(.muted)
                        .padding(.vertical, 12)
                    }
                }
            }
        }
        .overlay(alignment: state.isArabic ? .topLeading : .topTrailing) {
            HStack(spacing: 6) {
                Button {
                    let steps: [Double] = [0.85, 1.0, 1.2]
                    let idx = steps.firstIndex(where: { abs($0 - state.textScale) < 0.05 }) ?? 1
                    state.textScale = steps[(idx + 1) % steps.count]
                } label: {
                    Text("Aa")
                        .font(.system(size: state.textScale < 0.95 ? 9 : state.textScale > 1.1 ? 14 : 11))
                        .foregroundColor(.muted)
                        .frame(width: 32, height: 28)
                        .background(Color.parchmentDark.opacity(0.6))
                }
                .buttonStyle(.plain)

                Button { state.isDarkMode.toggle() } label: {
                    Image(systemName: state.isDarkMode ? "sun.max" : "moon")
                        .font(.system(size: 12))
                        .foregroundColor(.muted)
                        .frame(width: 32, height: 28)
                        .background(Color.parchmentDark.opacity(0.6))
                }
                .buttonStyle(.plain)

                Button { state.isArabic.toggle() } label: {
                    Text(state.isArabic ? "EN" : "عربي")
                        .font(.system(size: 11))
                        .foregroundColor(.muted)
                        .padding(.horizontal, 10)
                        .frame(height: 28)
                        .background(Color.parchmentDark.opacity(0.6))
                }
                .buttonStyle(.plain)
            }
            .padding(.top, 8)
            .padding(state.isArabic ? .leading : .trailing, 12)
        }
        .gesture(
            DragGesture(minimumDistance: 50)
                .onEnded { value in
                    guard selectedTab == 0 else { return }
                    let h = abs(value.translation.width)
                    let v = abs(value.translation.height)
                    guard h > v else { return }
                    if value.translation.width < -50 {
                        withAnimation(.easeInOut(duration: 0.2)) { state.goForward() }
                    } else if value.translation.width > 50 {
                        if state.stage > 1 {
                            showingBackConfirm = true
                        } else if state.stage == 1 {
                            withAnimation(.easeInOut(duration: 0.2)) { state.goBack() }
                        }
                    }
                }
        )
        .alert(state.strings.goBackTitle, isPresented: $showingBackConfirm) {
            Button(state.strings.goBackConfirm, role: .destructive) {
                withAnimation(.easeInOut(duration: 0.2)) { state.goBack() }
            }
            Button(state.strings.goBackStay, role: .cancel) {}
        } message: {
            Text(state.strings.goBackMessage)
        }
    }

    @ViewBuilder
    private var stageContent: some View {
        switch state.stage {
        case 1: Stage1BeforeMiqat(state: state)
        case 2: Stage2AtMiqat(state: state)
        case 3: Stage3Tawaf(state: state)
        case 4: Stage4Sai(state: state)
        case 5: Stage5Tahleel(state: state)
        default: EmptyView()
        }
    }
}
