import Foundation

class CalendarGenerator {
    private let calendar: Calendar

    init(calendar: Calendar = .current) {
        var cal = calendar
        cal.firstWeekday = 2 // Monday
        self.calendar = cal
    }

    func generateDays(for date: Date) -> [CalendarDay] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date) else {
            return []
        }

        let monthStart = monthInterval.start

        // Get the first day of the grid (may be in previous month)
        let firstWeekday = calendar.component(.weekday, from: monthStart)
        // Adjust for Monday start (Monday=2, Tuesday=3, ..., Sunday=1)
        // If firstWeekday is Monday (2), offset is 0.
        // If firstWeekday is Sunday (1), offset is 6.
        let offset = (firstWeekday - calendar.firstWeekday + 7) % 7
        
        guard let gridStart = calendar.date(byAdding: .day, value: -offset, to: monthStart) else {
            return []
        }

        var days: [CalendarDay] = []
        let today = calendar.startOfDay(for: Date())

        // Standard 7x6 grid (42 days) to cover all possible month layouts
        for i in 0..<42 {
            if let date = calendar.date(byAdding: .day, value: i, to: gridStart) {
                let dayNumber = calendar.component(.day, from: date)
                let isCurrentMonth = calendar.isDate(date, equalTo: monthStart, toGranularity: .month)
                let isToday = calendar.isDate(date, inSameDayAs: today)
                let weekday = calendar.component(.weekday, from: date)
                let isWeekend = (weekday == 1 || weekday == 7) // Sunday=1, Saturday=7

                days.append(CalendarDay(
                    date: date,
                    dayNumber: dayNumber,
                    isCurrentMonth: isCurrentMonth,
                    isToday: isToday,
                    isWeekend: isWeekend
                ))
            }
        }

        return days
    }

    func monthYearString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    func weekdayHeaders() -> [String] {
        let symbols = calendar.shortWeekdaySymbols // ["Sun", "Mon", ...]
        let firstIndex = calendar.firstWeekday - 1 // 1
        let shiftedSymbols = Array(symbols[firstIndex...] + symbols[..<firstIndex])
        return shiftedSymbols
    }

    func moveMonth(by value: Int, from date: Date) -> Date {
        return calendar.date(byAdding: .month, value: value, to: date) ?? date
    }

    func moveYear(by value: Int, from date: Date) -> Date {
        return calendar.date(byAdding: .year, value: value, to: date) ?? date
    }
}
