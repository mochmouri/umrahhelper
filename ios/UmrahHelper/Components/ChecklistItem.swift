import SwiftUI

struct ChecklistItem: View {
    let label: String
    let checked: Bool
    let onToggle: (Bool) -> Void

    var body: some View {
        Button(action: { onToggle(!checked) }) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    Rectangle()
                        .stroke(checked ? Color.gold : Color.parchmentDark, lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                    if checked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.gold)
                    }
                }
                .padding(.top, 1)

                Text(label)
                    .font(.system(size: 14))
                    .foregroundColor(.inkLight)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .buttonStyle(.plain)
    }
}
