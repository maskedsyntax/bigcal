import SwiftUI
import AppKit

struct CalendarMenuView: View {
    @State private var currentMonthDate = Date()
    @State private var today = Date()
    @EnvironmentObject var launchManager: LaunchAtLoginManager
    private let generator = CalendarGenerator()
    
    // Timer to refresh 'today' and handle midnight rollover
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 16) {
            CalendarHeaderView(
                monthYearString: generator.monthYearString(for: currentMonthDate),
                onPrevYear: { currentMonthDate = generator.moveYear(by: -1, from: currentMonthDate) },
                onPrevMonth: { currentMonthDate = generator.moveMonth(by: -1, from: currentMonthDate) },
                onNextMonth: { currentMonthDate = generator.moveMonth(by: 1, from: currentMonthDate) },
                onNextYear: { currentMonthDate = generator.moveYear(by: 1, from: currentMonthDate) },
                onToday: { 
                    today = Date()
                    currentMonthDate = today
                }
            )

            MonthGridView(
                days: generator.generateDays(for: currentMonthDate, today: today),
                weekdayHeaders: generator.weekdayHeaders()
            )
            
            Divider()
                .background(Color.white.opacity(0.1))
            
            HStack {
                Toggle("Launch at Login", isOn: $launchManager.isEnabled)
                    .font(.system(size: 11))
                    .toggleStyle(.checkbox)
                
                Spacer()
                
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Text("Quit")
                        .font(.system(size: 11, weight: .medium))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.05), in: RoundedRectangle(cornerRadius: 6))
                }
                .buttonStyle(.plain)
            }
            .padding(.top, -4)
        }
        .padding(.horizontal, 14)
        .padding(.bottom, 14)
        .padding(.top, 10)
        .frame(width: 320, height: 420)
        .onAppear {
            today = Date()
            // If the month is still the same as the month of 'today' from when the app started,
            // we might want to update currentMonthDate too, but only if they haven't navigated.
            // For simplicity, let's just refresh 'today' for the highlight.
        }
        .onReceive(timer) { _ in
            let newNow = Date()
            // Only update if the day has actually changed to minimize re-renders
            if !Calendar.autoupdatingCurrent.isDate(newNow, inSameDayAs: today) {
                today = newNow
            }
        }
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
