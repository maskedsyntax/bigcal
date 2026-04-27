import SwiftUI
import AppKit

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
        .background {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.clear)
                .background {
                    GlassEffectView(material: .hudWindow)
                }
                .overlay {
                    Color.black.opacity(0.18)
                }
        }
        .preferredColorScheme(.dark)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.28),
                            .white.opacity(0.08),
                            .white.opacity(0.02)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 0.65
                )
        )
        .overlay(alignment: .top) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.white.opacity(0.10), .clear],
                        startPoint: .top,
                        endPoint: .center
                    )
                )
                .blendMode(.plusLighter)
                .allowsHitTesting(false)
        }
        .shadow(color: .black.opacity(0.22), radius: 20, x: 0, y: 10)
    }
}

private struct GlassEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = .behindWindow
        view.state = .active
        view.isEmphasized = true
        return view
    }

    func updateNSView(_ view: NSVisualEffectView, context: Context) {
        view.material = material
    }
}
