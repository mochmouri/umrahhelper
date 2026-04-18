import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \UmrahSession.date, order: .reverse) private var sessions: [UmrahSession]
    @Environment(\.modelContext) private var modelContext
    @State private var sessionToDelete: UmrahSession? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color.parchment.ignoresSafeArea()

                if sessions.isEmpty {
                    VStack(spacing: 12) {
                        Text("No Umrahs recorded yet.")
                            .font(.system(size: 15, weight: .regular, design: .serif))
                            .foregroundColor(.inkLight)
                        Text("Complete an Umrah using the guide to see your history here.")
                            .font(.system(size: 13))
                            .foregroundColor(.muted)
                            .multilineTextAlignment(.center)
                            .lineSpacing(3)
                    }
                    .padding(.horizontal, 32)
                } else {
                    List {
                        ForEach(sessions) { session in
                            NavigationLink(destination: SessionDetailView(session: session)) {
                                sessionRow(session)
                            }
                            .listRowBackground(Color.parchment)
                        }
                        .onDelete { offsets in
                            offsets.forEach { modelContext.delete(sessions[$0]) }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.parchment, for: .navigationBar)
        }
    }

    private func sessionRow(_ session: UmrahSession) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(session.date.formatted(date: .long, time: .omitted))
                .font(.system(size: 14, weight: .medium, design: .serif))
                .foregroundColor(.ink)
            HStack(spacing: 16) {
                metricPill(label: "Total", value: session.formatDuration(session.totalDuration))
                metricPill(label: "Tawaf", value: session.formatDuration(session.tawafTotal))
                metricPill(label: "Saʿi", value: session.formatDuration(session.saiTotal))
            }
        }
        .padding(.vertical, 8)
    }

    private func metricPill(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.system(size: 10))
                .foregroundColor(.muted)
                .tracking(1)
            Text(value)
                .font(.system(size: 13).monospacedDigit())
                .foregroundColor(.inkLight)
        }
    }
}
