import SwiftUI

struct MonthGridView: View {
    let days: [CalendarDay]
    let weekdayHeaders: [String]

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)

    var body: some View {
        VStack(spacing: 8) {
            // Weekday Headers
            HStack(spacing: 0) {
                ForEach(weekdayHeaders, id: \.self) { header in
                    Text(header)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.primary.opacity(0.5))
                        .frame(maxWidth: .infinity)
                }
            }

            // Days Grid
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(days) { day in
                    DayCellView(day: day)
                }
            }
        }
    }
}
