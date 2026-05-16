import SwiftUI

@main
struct BigCalApp: App {
    @StateObject private var launchManager = LaunchAtLoginManager()
    
    var body: some Scene {
        MenuBarExtra("BigCal", systemImage: "calendar") {
            CalendarMenuView()
                .environmentObject(launchManager)
        }
        .menuBarExtraStyle(.window)
    }
}
