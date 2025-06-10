import SwiftUI
import SwiftData

struct QuickNotePopover: View {
    @Environment(\.modelContext) private var modelContext
    @State private var text: String = ""
    var onClose: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .trailing) {
            TextEditor(text: $text)
                .frame(minWidth: 200, minHeight: 120)
                .padding(.bottom, 4)

            HStack {
                Spacer()
                Button("Save") { save() }
                    .keyboardShortcut(.return, modifiers: [.command])
            }
        }
        .padding()
    }

    private func save() {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let item = Item(timestamp: Date(), text: trimmed)
        modelContext.insert(item)
        text = ""
        onClose?()
    }
}

#Preview {
    QuickNotePopover()
        .modelContainer(for: Item.self, inMemory: true)
}

