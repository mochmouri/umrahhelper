import SwiftUI

struct UmrahProgressBar: View {
    let currentStage: Int

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { stage in
                Rectangle()
                    .fill(stage <= currentStage ? Color.gold : Color.parchmentDark)
                    .frame(height: 3)
                    .frame(maxWidth: .infinity)
                    .animation(.easeInOut(duration: 0.3), value: currentStage)
            }
        }
        .padding(.horizontal, 0)
    }
}
