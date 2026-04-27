# BigCal Menu Bar Calendar — Spec

## Goal
Build a lightweight macOS menu bar app that shows a large, glassy/translucent month calendar when the user clicks the menu bar icon.

The app is for personal use and does not need App Store submission. It should run locally from Xcode and appear in the macOS menu bar.

## Platform
- macOS app
- Swift
- SwiftUI
- Minimum macOS target: macOS 13 Ventura or newer
- Use `MenuBarExtra` for the menu bar/status bar item

## App Type
This should be a menu bar-only app.

Requirements:
- No Dock icon
- No standard main app window on launch
- App appears as a small calendar icon in the macOS menu bar
- Clicking the icon opens a calendar dropdown/window
- Clicking outside should dismiss the dropdown, using standard `MenuBarExtra` behavior

Recommended implementation:

```swift
@main
struct BigCalApp: App {
    var body: some Scene {
        MenuBarExtra("BigCal", systemImage: "calendar") {
            CalendarMenuView()
                .frame(width: 720, height: 620)
        }
        .menuBarExtraStyle(.window)
    }
}
```

Also configure the app to behave like a menu bar utility:

```xml
<key>LSUIElement</key>
<true/>
```

This hides the Dock icon and app switcher entry.

## Core Features

### 1. Month Calendar View
The app should show a clean month grid.

Requirements:
- Display the current month by default
- Show month name and year at the top
- Show weekday headers: Mon, Tue, Wed, Thu, Fri, Sat, Sun
- Show all days in a 7-column grid
- Include leading/trailing days from adjacent months if needed to complete the grid
- Visually dim days that are outside the selected month
- Highlight today
- Highlight weekends subtly
- Keep layout large enough for a 4K display

### 2. Month Navigation
User should be able to move between months.

Controls:
- Previous month button
- Next month button
- “Today” button to return to current month

Behavior:
- Navigation should update the visible month immediately
- Today button should reset to the current month and year

### 3. Year Navigation
User should be able to switch years.

Acceptable implementation options:
- Add previous year and next year buttons
- Or add a year picker/dropdown
- Or support both

Preferred layout:
- Top header contains:
  - Previous year button
  - Previous month button
  - Current Month Year title
  - Next month button
  - Next year button
  - Today button

Example:

```text
«   ‹      April 2026      ›   »     Today
```

### 4. Menu Bar Icon
The app should have a calendar icon in the macOS menu bar.

Requirements:
- Use SF Symbol `calendar` initially
- Menu bar title should not show text by default, only icon if possible
- Tooltip/title can be `BigCal`

Optional:
- Later allow a custom icon asset

## Design Direction

### Visual Style
The UI should feel glassy, translucent, modern, and native to macOS.

Style goals:
- Glassmorphism
- Frosted/translucent background
- Rounded corners
- Soft borders
- Subtle shadows
- Large readable typography
- Calm spacing
- Native macOS feel

Suggested styling:
- Use `.background(.ultraThinMaterial)` or `.regularMaterial`
- Use rounded rectangles with corner radius around 24
- Add a subtle border using white opacity
- Use soft shadow
- Avoid heavy colors
- Respect light/dark mode automatically

Example style direction:

```swift
.background(.ultraThinMaterial)
.clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
.overlay(
    RoundedRectangle(cornerRadius: 24, style: .continuous)
        .stroke(.white.opacity(0.18), lineWidth: 1)
)
.shadow(radius: 24, y: 12)
```

### Layout
Suggested size:
- Width: 720 px
- Height: 620 px

Suggested structure:
- Outer padding: 20 to 28
- Header height: around 56
- Weekday header row
- Month grid
- Day cells should be large and readable

Day cell:
- Rounded rectangle shape
- Day number aligned top or centered
- Today has stronger visual treatment
- Outside-month days have lower opacity
- Hover state is optional but nice

## Functional Requirements

### Date Logic
Create a small date/calendar utility layer.

Required functions:
- Get current month start date
- Move selected month forward/backward
- Move selected year forward/backward
- Generate visible calendar days for the month grid
- Detect whether a date is today
- Detect whether a date belongs to selected month
- Detect weekend days

Use `Calendar.current`, `Date`, and `DateComponents`.

Important:
- Week should start on Monday
- Avoid hardcoding month lengths
- Handle leap years correctly
- Handle year transitions correctly, such as December to January and January to December

Suggested model:

```swift
struct CalendarDay: Identifiable {
    let id = UUID()
    let date: Date
    let dayNumber: Int
    let isCurrentMonth: Bool
    let isToday: Bool
    let isWeekend: Bool
}
```

## Non-Goals for v1
Do not include these in v1:
- Real calendar events
- Google Calendar integration
- Apple Calendar/EventKit permissions
- Reminders
- Creating or editing events
- Desktop floating mode
- Dock app behavior
- Settings screen
- Notifications
- App Store distribution flow

## UX Details

### On Launch
- App launches silently
- No window opens automatically
- Menu bar icon appears

### On Click
- Calendar opens as a menu bar dropdown/window
- Current month is shown by default

### Empty States
No empty state is needed because the calendar always has content.

### Keyboard Support
Nice to have:
- Left arrow: previous month
- Right arrow: next month
- Up arrow: previous year
- Down arrow: next year
- T: Today
- Escape: close dropdown if supported naturally

Keyboard shortcuts are optional for v1.

## Accessibility
Include basic accessibility support:
- Buttons should have labels like “Previous month”, “Next month”, “Previous year”, “Next year”, and “Today”
- Day cells should have accessibility labels with full dates, such as “Monday, April 27, 2026”
- Today should be announced as today

## File/Code Structure
Recommended structure:

```text
BigCal/
  BigCalApp.swift
  Views/
    CalendarMenuView.swift
    CalendarHeaderView.swift
    MonthGridView.swift
    DayCellView.swift
  Models/
    CalendarDay.swift
  Utilities/
    CalendarGenerator.swift
```

## Implementation Notes

### Menu Bar App
Use `MenuBarExtra` with `.window` style rather than a normal menu. This allows a richer SwiftUI view inside the dropdown.

### Hiding Dock Icon
Set `LSUIElement` to `true` in `Info.plist`.

### Window Sizing
The menu bar dropdown should be large enough to be useful on a 4K monitor.

Start with:

```swift
.frame(width: 720, height: 620)
```

If the dropdown feels too large, reduce to:

```swift
.frame(width: 640, height: 560)
```

## Acceptance Criteria
The app is complete when:

- Running the app shows an icon in the macOS menu bar
- The app does not show in the Dock
- Clicking the menu bar icon opens a large translucent calendar
- The calendar defaults to the current month
- The user can go to previous/next month
- The user can go to previous/next year
- The user can return to today
- Today is clearly highlighted
- Days outside the active month are visible but dimmed
- Week starts on Monday
- The UI works in both light and dark mode
- No calendar permissions are requested
- No App Store registration or submission is required for local use

## Suggested App Name
BigCal

## Future Ideas
Keep these out of v1, but design cleanly enough to add later:

- Show Apple Calendar events
- Pin as floating desktop calendar
- Resize dropdown
- Custom themes
- Custom first day of week
- Mini agenda below month grid
- Keyboard shortcuts
- Launch at login
