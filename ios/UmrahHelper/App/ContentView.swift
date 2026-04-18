import SwiftUI

struct ContentView: View {
    @State private var state = UmrahState()
    @State private var showingBackConfirm = false
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            guideTab
                .tabItem {
                    Label("Guide", systemImage: "book")
                }
                .tag(0)

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
                .tag(1)
        }
        .tint(Color.gold)
    }

    private var guideTab: some View {
        ZStack(alignment: .top) {
            Color.parchment.ignoresSafeArea()

            if state.stage == 0 {
                Stage0Welcome(state: state)
            } else {
                VStack(spacing: 0) {
                    UmrahProgressBar(currentStage: state.stage)

                    ScrollView {
                        stageContent
                            .frame(maxWidth: 480)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
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
        .alert("Go back?", isPresented: $showingBackConfirm) {
            Button("Go back", role: .destructive) {
                withAnimation(.easeInOut(duration: 0.2)) { state.goBack() }
            }
            Button("Stay", role: .cancel) {}
        } message: {
            Text("Your progress in this stage is saved and will be preserved.")
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
