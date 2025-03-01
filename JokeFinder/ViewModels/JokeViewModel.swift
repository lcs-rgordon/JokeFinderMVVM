//
//  JokeViewModel.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-01.
//

import Foundation

@Observable
class JokeViewModel {
    
    // MARK: Stored properties
    
    // Whatever joke has most recently been downloaded
    var currentJoke: Joke? = nil
    
    // Holds a list of saved jokes
    var savedJokes: [Joke] = []
    
    // MARK: Function(s)
    
    // This loads a new joke from the endpoint
    //
    // "async" means it is an asynchronous function.
    //
    // That means it can be run alongside other functionality
    // in our app. Since this function might take a while to complete
    // this ensures that other parts of our app (like the user interface)
    // won't "freeze up" while this function does it's job.
    func fetchJoke() async {
        
        do {
            let url4 = URL(string: "https://official-joke-api.appspot.com/random_joke")!
            let joke = try await URLSession.shared.decode(Joke.self, from: url4)
            self.currentJoke = joke
        } catch {
            print("Download error: \(error.localizedDescription)")
        }
        
    }
    
}
