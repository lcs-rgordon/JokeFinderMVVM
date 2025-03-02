//
//  FavouriteJoke.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-02.
//

import SwiftUI
import SwiftData

@Model
class FavouriteJoke {
    var setup: String
    var punchline: String
    var savedAt: Date
    
    init(setup: String, punchline: String, savedAt: Date = Date()) {
        self.setup = setup
        self.punchline = punchline
        self.savedAt = savedAt
    }
}
