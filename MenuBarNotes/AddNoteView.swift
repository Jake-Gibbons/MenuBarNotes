import SwiftData
import SwiftUI

struct AddNoteView: View {
  @Environment(\.modelContext) private var modelContext
  @State private var text: String = ""
  var onSave: (() -> Void)?

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("New Note").font(.headline)
      TextField("Note text", text: $text, axis: .vertical)
        .textFieldStyle(.roundedBorder)
      HStack {
        Spacer()
        Button("Save") {
          let newItem = Item(timestamp: Date(), text: text)
          modelContext.insert(newItem)
          onSave?()
        }
        .disabled(text.isEmpty)
      }
    }
    .padding()
    .frame(width: 300)
  }
}

#Preview {
  AddNoteView()
    .modelContainer(for: Item.self, inMemory: true)
}
