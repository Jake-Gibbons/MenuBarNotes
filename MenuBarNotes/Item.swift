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
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
