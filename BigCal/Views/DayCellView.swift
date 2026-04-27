import SwiftUI

struct DayCellView: View {
    let day: CalendarDay

    var body: some View {
        VStack {
            Text("\(day.dayNumber)")
                .font(.system(size: 12, weight: day.isToday ? .bold : .medium))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .aspectRatio(1.0, contentMode: .fit)
        .background {
            if day.isToday {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(Color.accentColor.opacity(0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .stroke(Color.accentColor.opacity(0.4), lineWidth: 1)
                    )
            }
        }
        .opacity(day.isCurrentMonth ? 1.0 : 0.25)
        .accessibilityLabel(accessibilityLabel)
    }

    private var textColor: Color {
        if day.isToday {
            return .accentColor
        } else {
            return .primary.opacity(0.9)
        }
    }

    @ViewBuilder
    private var backgroundView: some View {
        if day.isToday {
            Color.accentColor.opacity(0.15)
        } else if day.isWeekend && day.isCurrentMonth {
            Color.primary.opacity(0.03)
        } else {
            Color.clear
        }
    }

    private var accessibilityLabel: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        var label = formatter.string(from: day.date)
        if day.isToday {
            label += ", Today"
        }
        return label
    }
}
