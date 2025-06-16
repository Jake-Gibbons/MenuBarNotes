import Cocoa
import SwiftData
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    var statusItem: NSStatusItem!
    var popover: NSPopover?
    var mainWindow: NSWindow?
    var container: ModelContainer!

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        setupStatusItem()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(openMainWindow),
                                               name: .openMainWindow,
                                               object: nil)
    }

    private func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "note.text",
                                   accessibilityDescription: "Notes")
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
            togglePopover()
        }
    }

    private func togglePopover() {
        if let popover = popover, popover.isShown {
            popover.performClose(nil)
        } else {
            showPopover()
        }
    }

    private func showPopover() {
        if popover == nil {
            let view = QuickNotePopover().modelContainer(container)
            let hosting = NSHostingController(rootView: view)
            let pop = NSPopover()
            pop.contentViewController = hosting
            pop.behavior = .transient
            pop.contentSize = NSSize(width: 240, height: 180)
            popover = pop
        }
        if let button = statusItem.button {
            popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }

    private func showMenu() {
        let menu = NSMenu()
        menu.addItem(withTitle: "Open App", action: #selector(openMainWindow), keyEquivalent: "")
        menu.addItem(withTitle: "Preferences\u2026", action: #selector(openSettings), keyEquivalent: ",")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Quit", action: #selector(quit), keyEquivalent: "q")
        statusItem.menu = menu
        statusItem.button?.performClick(nil)
        statusItem.menu = nil
    }

    @objc private func openSettings() {
        NSApp.sendAction(#selector(NSApplication.showPreferencesWindow), to: nil, from: nil)
    }

    @objc private func quit() {
        NSApp.terminate(nil)
    }

    @objc func openMainWindow() {
        if mainWindow == nil {
            let view = ContentView().modelContainer(container)
            let hosting = NSHostingController(rootView: view)
            let window = NSWindow(contentViewController: hosting)
            window.title = "Notes"
            window.setContentSize(NSSize(width: 480, height: 320))
            window.delegate = self
            mainWindow = window
        }
        NSApp.setActivationPolicy(.regular)
        mainWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    func windowWillClose(_ notification: Notification) {
        mainWindow = nil
        NSApp.setActivationPolicy(.accessory)
    }
}

