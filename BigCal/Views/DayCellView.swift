import SwiftUI

struct DayCellView: View {
    let day: CalendarDay

    var body: some View {
        VStack {
            Text("\(day.dayNumber)")
                .font(.system(size: 13, weight: day.isToday ? .bold : .medium))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .aspectRatio(1.0, contentMode: .fit)
        .background(backgroundView)
        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(day.isToday ? Color.accentColor : Color.white.opacity(0.1), lineWidth: day.isToday ? 2 : 1)
        )
        .opacity(day.isCurrentMonth ? 1.0 : 0.3)
        .accessibilityLabel(accessibilityLabel)
    }

    private var textColor: Color {
        if day.isToday {
            return .accentColor
        } else if day.isWeekend {
            return .secondary
        } else {
            return .primary
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
