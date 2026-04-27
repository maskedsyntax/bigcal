import SwiftUI

struct CalendarMenuView: View {
    @State private var currentMonthDate = Date()
    private let generator = CalendarGenerator()

    var body: some View {
        VStack(spacing: 16) {
            CalendarHeaderView(
                monthYearString: generator.monthYearString(for: currentMonthDate),
                onPrevYear: { currentMonthDate = generator.moveYear(by: -1, from: currentMonthDate) },
                onPrevMonth: { currentMonthDate = generator.moveMonth(by: -1, from: currentMonthDate) },
                onNextMonth: { currentMonthDate = generator.moveMonth(by: 1, from: currentMonthDate) },
                onNextYear: { currentMonthDate = generator.moveYear(by: 1, from: currentMonthDate) },
                onToday: { currentMonthDate = Date() }
            )

            MonthGridView(
                days: generator.generateDays(for: currentMonthDate),
                weekdayHeaders: generator.weekdayHeaders()
            )
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .padding(.top, 12)
        .frame(width: 380, height: 410)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.18), lineWidth: 1)
        )
        .shadow(radius: 24, y: 12)
    }
}
