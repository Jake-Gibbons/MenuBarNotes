# MenuBarNotes

MenuBarNotes is a macOS menu bar utility for quickly keeping notes. It is delivered as a standard Xcode project rather than a Swift package.

## Building

1. Open `MenuBarNotes.xcodeproj` in **Xcode**.
2. Select the desired scheme and build the app with **Product ▸ Build** or the <kbd>⌘B</kbd> shortcut.

## Running Tests

Unit and UI tests must be run from Xcode. Open the workspace created by Xcode when building the project, then run the tests via **Product ▸ Test** (<kbd>⌘U</kbd>).

Running `swift test` in the repository root will fail because this project is not a Swift Package.
