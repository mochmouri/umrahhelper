import SwiftUI

struct SessionDetailView: View {
    let session: UmrahSession

    @AppStorage("isArabic") private var isArabic = false
    private var S: AppStrings { AppStrings(isArabic: isArabic) }

    @State private var shareImage: UIImage? = nil
    @State private var showShare = false

    var body: some View {
        ZStack {
            Color.parchment.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(session.date.formatted(date: .complete, time: .omitted))
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .foregroundColor(.ink)
                        Text(session.date.formatted(date: .omitted, time: .shortened))
                            .font(.system(size: 13))
                            .foregroundColor(.muted)
                    }
                    .padding(.bottom, 24)

                    VStack(spacing: 0) {
                        summaryRow(S.tawafLabel, value: session.formatDuration(session.tawafTotal))
                        Rectangle().fill(Color.parchmentDark).frame(height: 1)
                        summaryRow(S.saiLabel, value: session.formatDuration(session.saiTotal))
                        Rectangle().fill(Color.parchmentDark).frame(height: 1)
                        HStack {
                            Text(S.totalUmrahLabel)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.ink)
                            Spacer()
                            Text(session.formatDuration(session.totalDuration))
                                .font(.system(size: 13, weight: .semibold).monospacedDigit())
                                .foregroundColor(.ink)
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.horizontal, 16)
                    .background(Color.parchmentDark.opacity(0.35))
                    .padding(.bottom, 24)

                    if !session.lapDurations.isEmpty {
                        breakdownSection(
                            title: S.tawafLapBreakdown,
                            durations: session.lapDurations,
                            rowLabel: { S.lapLabel($0) }
                        )
                        .padding(.bottom, 16)
                    }

                    if !session.roundDurations.isEmpty {
                        breakdownSection(
                            title: S.saiRoundBreakdown,
                            durations: session.roundDurations,
                            rowLabel: { S.roundLabel($0) }
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
            }
        }
        .navigationTitle(S.sessionTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.parchment, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    shareImage = renderSummaryCard(
                        date: session.date,
                        tawaf: session.formatDuration(session.tawafTotal),
                        sai:   session.formatDuration(session.saiTotal),
                        total: session.formatDuration(session.totalDuration),
                        isArabic: isArabic
                    )
                    showShare = shareImage != nil
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 14))
                        .foregroundColor(.muted)
                }
            }
        }
        .sheet(isPresented: $showShare) {
            if let img = shareImage {
                ShareSheet(items: [img])
            }
        }
        .environment(\.layoutDirection, isArabic ? .rightToLeft : .leftToRight)
    }

    private func summaryRow(_ label: String, value: String) -> some View {
        HStack {
            Text(label).font(.system(size: 13)).foregroundColor(.muted)
            Spacer()
            Text(value).font(.system(size: 13).monospacedDigit()).foregroundColor(.inkLight)
        }
        .padding(.vertical, 8)
    }

    private func breakdownSection(title: String, durations: [Double], rowLabel: @escaping (Int) -> String) -> some View {
        let total = durations.reduce(0, +)
        let avg = durations.isEmpty ? 0 : total / Double(durations.count)

        return VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 13, weight: .semibold, design: .serif))
                .foregroundColor(.ink)
                .padding(.bottom, 12)

            ForEach(Array(durations.enumerated()), id: \.offset) { i, dur in
                HStack {
                    Text(rowLabel(i))
                        .font(.system(size: 12)).foregroundColor(.muted)
                    Spacer()
                    Text(session.formatDuration(dur))
                        .font(.system(size: 12).monospacedDigit()).foregroundColor(.inkLight)
                }
                .padding(.vertical, 5)
                if i < durations.count - 1 {
                    Rectangle().fill(Color.parchmentDark).frame(height: 1)
                }
            }

            Rectangle().fill(Color.parchmentDark).frame(height: 1).padding(.top, 4)

            HStack {
                Text(S.averageLabel).font(.system(size: 12)).foregroundColor(.muted)
                Spacer()
                Text(session.formatDuration(avg))
                    .font(.system(size: 12).monospacedDigit()).foregroundColor(.inkLight)
            }
            .padding(.vertical, 5)

            HStack {
                Text(S.totalLabel).font(.system(size: 13, weight: .semibold)).foregroundColor(.ink)
                Spacer()
                Text(session.formatDuration(total))
                    .font(.system(size: 13, weight: .semibold).monospacedDigit()).foregroundColor(.ink)
            }
            .padding(.vertical, 5)
        }
        .padding(16)
        .background(Color.parchmentDark.opacity(0.35))
    }
}
