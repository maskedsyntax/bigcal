import SwiftUI

@main
struct BigCalApp: App {
    var body: some Scene {
        MenuBarExtra("BigCal", systemImage: "calendar") {
            CalendarMenuView()
        }
        .menuBarExtraStyle(.window)
    }
}
