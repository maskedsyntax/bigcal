import SwiftUI

struct MonthGridView: View {
    let days: [CalendarDay]
    let weekdayHeaders: [String]

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 6), count: 7)

    var body: some View {
        VStack(spacing: 10) {
            // Weekday Headers
            HStack(spacing: 0) {
                ForEach(weekdayHeaders, id: \.self) { header in
                    Text(header)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }

            // Days Grid
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(days) { day in
                    DayCellView(day: day)
                }
            }
        }
    }
}
