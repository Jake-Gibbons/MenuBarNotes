import SwiftUI

struct PreferencesView: View {
    @AppStorage("launchAtLogin") private var launchAtLogin = false
    @AppStorage("syncICloud") private var syncICloud = false
    @AppStorage("syncAppleNotes") private var syncAppleNotes = false

    var body: some View {
        Form {
            Toggle("Launch at login", isOn: $launchAtLogin)
            Toggle("Sync notes with iCloud", isOn: $syncICloud)
            Toggle("Sync notes with Apple Notes", isOn: $syncAppleNotes)
        }
        .padding()
        .frame(width: 320)
    }
}

#Preview {
    PreferencesView()
}
