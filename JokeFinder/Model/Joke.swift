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
    var isFavourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case type
        case setup
        case punchline
        case id
        case isFavourite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.setup = try container.decode(String.self, forKey: .setup)
        self.punchline = try container.decode(String.self, forKey: .punchline)
        self.id = try container.decode(Int.self, forKey: .id)
        self.isFavourite = false
    }
    
}
