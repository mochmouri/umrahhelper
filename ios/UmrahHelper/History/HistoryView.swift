import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \UmrahSession.date, order: .reverse) private var sessions: [UmrahSession]
    @Environment(\.modelContext) private var modelContext
    @State private var sessionToDelete: UmrahSession? = nil

    @AppStorage("isArabic") private var isArabic = false
    private var S: AppStrings { AppStrings(isArabic: isArabic) }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.parchment.ignoresSafeArea()

                if sessions.isEmpty {
                    VStack(spacing: 12) {
                        Text(S.noUmrahsTitle)
                            .font(.system(size: 15, weight: .regular, design: .serif))
                            .foregroundColor(.inkLight)
                        Text(S.noUmrahsBody)
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
                            sessionToDelete = sessions[offsets.first!]
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle(S.historyTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.parchment, for: .navigationBar)
            .alert(S.deleteTitle, isPresented: Binding(
                get: { sessionToDelete != nil },
                set: { if !$0 { sessionToDelete = nil } }
            )) {
                Button(S.deleteConfirm, role: .destructive) {
                    if let s = sessionToDelete { modelContext.delete(s) }
                    sessionToDelete = nil
                }
                Button(S.cancelButton2, role: .cancel) { sessionToDelete = nil }
            } message: {
                Text(S.deleteMessage)
            }
        }
        .environment(\.layoutDirection, isArabic ? .rightToLeft : .leftToRight)
    }

    private func sessionRow(_ session: UmrahSession) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(session.date.formatted(date: .long, time: .omitted))
                .font(.system(size: 14, weight: .medium, design: .serif))
                .foregroundColor(.ink)
            HStack(spacing: 16) {
                metricPill(label: S.totalPill, value: session.formatDuration(session.totalDuration))
                metricPill(label: S.tawafLabel, value: session.formatDuration(session.tawafTotal))
                metricPill(label: S.saiLabel, value: session.formatDuration(session.saiTotal))
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
