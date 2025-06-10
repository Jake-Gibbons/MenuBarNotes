import Cocoa
import SwiftData
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
  var statusItem: NSStatusItem!
  var addNoteWindow: NSWindow?
  var container: ModelContainer!

  func applicationDidFinishLaunching(_ notification: Notification) {
    setupStatusItem()
  }

  private func setupStatusItem() {
    statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    if let button = statusItem.button {
      button.image = NSImage(systemSymbolName: "note.text", accessibilityDescription: "Notes")
      button.target = self
      button.action = #selector(statusItemClicked(_:))
      button.sendAction(on: [.leftMouseUp, .rightMouseUp])
    }
  }

  @objc private func statusItemClicked(_ sender: Any?) {
    guard let event = NSApp.currentEvent else { return }
    if event.type == .rightMouseUp {
      showMenu()
    } else {
      showAddNoteWindow()
    }
  }

  private func showMenu() {
    let menu = NSMenu()
    menu.addItem(withTitle: "New Note", action: #selector(newNote), keyEquivalent: "n")
    menu.addItem(withTitle: "Settings", action: #selector(openSettings), keyEquivalent: ",")
    menu.addItem(NSMenuItem.separator())
    menu.addItem(withTitle: "Quit", action: #selector(quit), keyEquivalent: "q")
    statusItem.menu = menu
    statusItem.button?.performClick(nil)
    statusItem.menu = nil
  }

  @objc private func newNote() {
    showAddNoteWindow()
  }

  @objc private func openSettings() {
    NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
  }

  @objc private func quit() {
    NSApp.terminate(nil)
  }

  func showAddNoteWindow() {
    if addNoteWindow == nil {
      let view = AddNoteView { [weak self] in
        self?.addNoteWindow?.close()
        self?.addNoteWindow = nil
      }
      .modelContainer(container)
      let hosting = NSHostingController(rootView: view)
      let window = NSWindow(contentViewController: hosting)
      window.title = "New Note"
      window.setContentSize(NSSize(width: 320, height: 160))
      addNoteWindow = window
    }
    addNoteWindow?.makeKeyAndOrderFront(nil)
    NSApp.activate(ignoringOtherApps: true)
  }
}
