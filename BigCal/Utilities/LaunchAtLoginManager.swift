import ServiceManagement
import Foundation

class LaunchAtLoginManager: ObservableObject {
    @Published var isEnabled: Bool {
        didSet {
            toggleLaunchAtLogin(isEnabled)
        }
    }

    init() {
        self.isEnabled = SMAppService.mainApp.status == .enabled
        // Refresh status in case it changed externally
        objectWillChange.send()
    }

    private func toggleLaunchAtLogin(_ enabled: Bool) {
        let service = SMAppService.mainApp
        
        do {
            if enabled {
                if service.status == .enabled {
                    try? service.unregister()
                }
                try service.register()
            } else {
                try service.unregister()
            }
        } catch {
            print("Failed to update launch at login status: \(error.localizedDescription)")
            // Revert state if it failed
            DispatchQueue.main.async {
                self.isEnabled = service.status == .enabled
            }
        }
    }
}
