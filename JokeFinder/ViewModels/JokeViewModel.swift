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
    var favouriteJokes: [FavouriteJoke] = []
    
    // MARK: Initializer(s)
    init() {
        Task {
            await self.fetchJoke()
        }
    }
    
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
        
        // 1. Attempt to create a URL from the address provided
        let endpoint = "https://official-joke-api.appspot.com/random_joke"
        guard let url = URL(string: endpoint) else {
            debugPrint("Invalid address for JSON endpoint.")
            return
        }
        
        // 2. Fetch the raw data from the URL
        //
        // Network requests can potentially fail (throw errors) so
        // we complete them within a do-catch block to report errors if they
        // occur.
        //
        do {
            
            // Fetch the data
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // 3. Decode the data
            
            // Create a decoder object to do most of the work for us
            let decoder = JSONDecoder()
            
            // Use the decoder object to convert the raw data into an instance of our Swift data type
            let decodedData = try decoder.decode(Joke.self, from: data)
            
            // If we got here, decoding succeeded, return the instance of our data type
            self.currentJoke = decodedData
            
        } catch {
            
            // Show an error that we wrote and understand
            print("Count not retrieve data from endpoint, or could not decode into an instance of a Swift data type.")
            print("----")
            
            // Show the detailed error to help with debugging
            debugPrint(error)
            
        }
        
    }
    
    // Add the current joke to the list of favourites
    func saveJoke() {
        
        // Save current joke
        if let currentJoke = self.currentJoke {
            favouriteJokes.insert(
                FavouriteJoke(
                    setup: currentJoke.setup ?? "",
                    punchline: currentJoke.punchline ?? ""
                ),
                at: 0
            )            
        }

    }
    
    // Clear the current joke
    func clearJoke() {

        self.currentJoke = nil

    }
    
}
