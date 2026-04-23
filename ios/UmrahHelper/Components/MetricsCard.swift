import SwiftUI

struct MetricsCard: View {
    let title: String
    let metrics: UmrahState.SessionMetrics?
    var rowLabel: (Int) -> String = { "Lap \($0 + 1)" }

    @AppStorage("isArabic") private var isArabic = false
    private var S: AppStrings { AppStrings(isArabic: isArabic) }

    var body: some View {
        if let m = metrics {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold, design: .serif))
                    .foregroundColor(.ink)
                    .padding(.bottom, 12)

                ForEach(Array(m.durations.enumerated()), id: \.offset) { i, dur in
                    HStack {
                        Text(rowLabel(i))
                            .font(.system(size: 12))
                            .foregroundColor(.muted)
                        Spacer()
                        Text(format(dur))
                            .font(.system(size: 12).monospacedDigit())
                            .foregroundColor(.inkLight)
                    }
                    .padding(.vertical, 5)

                    if i < m.durations.count - 1 {
                        Rectangle().fill(Color.parchmentDark).frame(height: 1)
                    }
                }

                Rectangle().fill(Color.parchmentDark).frame(height: 1).padding(.top, 4)

                HStack {
                    Text(S.averageLabel)
                        .font(.system(size: 12))
                        .foregroundColor(.muted)
                    Spacer()
                    Text(format(m.average))
                        .font(.system(size: 12).monospacedDigit())
                        .foregroundColor(.inkLight)
                }
                .padding(.vertical, 5)

                HStack {
                    Text(S.totalLabel)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.ink)
                    Spacer()
                    Text(format(m.total))
                        .font(.system(size: 13, weight: .semibold).monospacedDigit())
                        .foregroundColor(.ink)
                }
                .padding(.vertical, 5)
            }
            .padding(16)
            .background(Color.parchmentDark.opacity(0.35))
        }
    }

    private func format(_ t: TimeInterval) -> String {
        let m = Int(t) / 60; let s = Int(t) % 60
        return String(format: "%d:%02d", m, s)
    }
}
