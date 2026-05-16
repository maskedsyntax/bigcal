// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BigCal",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "BigCal", targets: ["BigCal"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "BigCal",
            dependencies: [],
            path: "BigCal",
            exclude: ["Info.plist", "Resources/BigCalIcon.icns", "Resources/BigCalIcon.png"],
            sources: [
                "BigCalApp.swift",
                "Models/CalendarDay.swift",
                "Utilities/CalendarGenerator.swift",
                "Utilities/LaunchAtLoginManager.swift",
                "Views/CalendarHeaderView.swift",
                "Views/CalendarMenuView.swift",
                "Views/DayCellView.swift",
                "Views/MonthGridView.swift"
            ]
        )
    ]
)
