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
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Previous year")

                Button(action: onPrevMonth) {
                    Image(systemName: "chevron.left")
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Previous month")
            }

            Text(monthYearString)
                .font(.system(size: 16, weight: .bold))
                .frame(minWidth: 120)

            HStack(spacing: 6) {
                Button(action: onNextMonth) {
                    Image(systemName: "chevron.right")
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Next month")

                Button(action: onNextYear) {
                    Image(systemName: "chevron.right.2")
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Next year")
            }

            Spacer()

            Button("Today", action: onToday)
                .buttonStyle(.bordered)
                .controlSize(.small)
                .accessibilityLabel("Today")
        }
    }
}
