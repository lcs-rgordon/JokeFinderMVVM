//
//  FavouriteJoke.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-02.
//

import SwiftData

@Model
class FavouriteJoke {
    var setup: String
    var punchline: String
    
    init(setup: String, punchline: String) {
        self.setup = setup
        self.punchline = punchline
    }
}
