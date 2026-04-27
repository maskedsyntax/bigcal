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
        .padding(.horizontal, 14)
        .padding(.bottom, 14)
        .padding(.top, 10)
        .frame(width: 320, height: 350)
        .background(.regularMaterial.opacity(0.8)) // More transparent blend
        .preferredColorScheme(.dark)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [.white.opacity(0.15), .clear, .white.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 0.5
                )
        )
        .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
    }
}
