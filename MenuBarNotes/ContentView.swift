//
//  ContentView.swift
//  MenuBarNotes
//
//  Created by Jake Gibbons on 10/06/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]
  @State private var noteText = ""

  var body: some View {
    VStack {
      List {
        ForEach(items) { item in
          VStack(alignment: .leading) {
            Text(item.text)
            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))
              .font(.caption)
              .foregroundStyle(.secondary)
          }
        }
        .onDelete(perform: deleteItems)
      }
      HStack {
        TextField("New note", text: $noteText)
        Button("Add") { addItem() }
          .disabled(noteText.isEmpty)
      }
      .padding()
    }
    .frame(minWidth: 250, minHeight: 300)
  }

  private func addItem() {
    withAnimation {
      let newItem = Item(text: noteText)
      modelContext.insert(newItem)
      noteText = ""
    }
  }

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(items[index])
      }
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
