//
//  MenuBarNotesApp.swift
//  MenuBarNotes
//
//  Created by Jake Gibbons on 10/06/2025.
//

import SwiftData
import SwiftUI

@main
struct MenuBarNotesApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Item.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()

  init() {
    appDelegate.container = sharedModelContainer
  }

  var body: some Scene {
    Settings {
      SettingsView()
    }
    .modelContainer(sharedModelContainer)
  }
}
