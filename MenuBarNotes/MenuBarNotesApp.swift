//
//  MenuBarNotesApp.swift
//  MenuBarNotes
//
//  Created by Jake Gibbons on 10/06/2025.
//

import SwiftUI
import SwiftData
import AppKit

@main
struct MenuBarNotesApp: App {
    @Environment(\.openWindow) private var openWindow

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup(id: "MainWindow") {
            ContentView()
        }
        .modelContainer(sharedModelContainer)

        Settings {
            PreferencesView()
        }

        MenuBarExtra("Quick Note", systemImage: "square.and.pencil") {
            QuickNotePopover()
        } menu: {
            Button("Open Notes") { openWindow(id: "MainWindow") }
            Button("Preferences\u2026") {
                if NSApp.responds(to: #selector(NSApplication.showPreferencesWindow)) {
                    NSApp.sendAction(#selector(NSApplication.showPreferencesWindow), to: nil, from: nil)
                }
            }
            Divider()
            Button("Quit") { NSApp.terminate(nil) }

        }
        .menuBarExtraStyle(.window)
        .modelContainer(sharedModelContainer)
    }
}
