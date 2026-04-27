import SwiftUI

struct CalendarHeaderView: View {
    let monthYearString: String
    let onPrevYear: () -> Void
    let onPrevMonth: () -> Void
    let onNextMonth: () -> Void
    let onNextYear: () -> Void
    let onToday: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 6) {
                Button(action: onPrevYear) {
                    Image(systemName: "chevron.left.2")
                        .frame(width: 22, height: 22)
                        .background(Color.white.opacity(0.05), in: Circle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Previous year")

                Button(action: onPrevMonth) {
                    Image(systemName: "chevron.left")
                        .frame(width: 22, height: 22)
                        .background(Color.white.opacity(0.05), in: Circle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Previous month")
            }

            Text(monthYearString)
                .font(.system(size: 15, weight: .bold))
                .frame(minWidth: 110)

            HStack(spacing: 6) {
                Button(action: onNextMonth) {
                    Image(systemName: "chevron.right")
                        .frame(width: 22, height: 22)
                        .background(Color.white.opacity(0.05), in: Circle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Next month")

                Button(action: onNextYear) {
                    Image(systemName: "chevron.right.2")
                        .frame(width: 22, height: 22)
                        .background(Color.white.opacity(0.05), in: Circle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Next year")
            }

            Spacer()

            Button(action: onToday) {
                Text("Today")
                    .font(.system(size: 12, weight: .semibold))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 42, minHeight: 24)
                    .padding(.horizontal, 9)
                    .background(Color.white.opacity(0.07), in: Capsule())
                    .overlay(
                        Capsule()
                            .strokeBorder(Color.white.opacity(0.12), lineWidth: 0.5)
                    )
            }
                .buttonStyle(.plain)
                .accessibilityLabel("Today")
        }
    }
}
