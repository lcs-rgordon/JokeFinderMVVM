//
//  Joke.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-01.
//

import Foundation

struct Joke: Identifiable, Codable {
    
    // MARK: Stored properties
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}
