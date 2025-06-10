//
//  Item.swift
//  MenuBarNotes
//
//  Created by Jake Gibbons on 10/06/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
  var text: String
  var timestamp: Date

  init(text: String, timestamp: Date = Date()) {
    self.text = text
    self.timestamp = timestamp
  }
}
