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
    
    // Holds a list of favourite jokes
    var favouriteJokes: [Joke] = []
    
    // MARK: Initializer(s)
    init() {
        Task {
            await self.fetchJoke()
        }
        
        // Get saved jokes from device storage
        loadFavouriteJokes()
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
            favouriteJokes.insert(currentJoke, at: 0)
            
            // Update the file on device so data is persisted
            persistFavouriteJokes()
        }

    }
    
    // Clear the current joke
    func clearJoke() {

        self.currentJoke = nil

    }
    
    // Load saved jokes from file on device
    func loadFavouriteJokes() {
        
        // Get a URL that points to the saved JSON data containing our list of favourite jokes
        let filename = getDocumentsDirectory().appendingPathComponent(fileLabel)
        
        // Attempt to load from the JSON in the stored file
        do {
            
            // Load the raw data
            let data = try Data(contentsOf: filename)
            
            print("Got data from file, contents are:")
            print(String(data: data, encoding: .utf8)!)
            
            // Decode the data into Swift native data structures
            self.favouriteJokes = try JSONDecoder().decode([Joke].self, from: data)
            
        } catch {
            
            print(error)
            print("Could not load data from file, initializing with empty list.")
            
            self.favouriteJokes = []
        }
        
    }
    
    // Write favourite jokes to file on device
    func persistFavouriteJokes() {
        
        // Get a URL that points to the saved JSON data containing our list of people
        let filename = getDocumentsDirectory().appendingPathComponent(fileLabel)
        
        do {
            
            // Create an encoder
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            // Encode the list of people we've tracked
            let data = try encoder.encode(self.favouriteJokes)
            
            // Actually write the JSON file to the documents directory
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            print("Wrote data from file, contents are:")
            print(String(data: data, encoding: .utf8)!)
            
            print("Saved data to documents directory successfully.")
            
        } catch {
            
            print(error)
            print("Unable to write list of favourite jokes to documents directory.")
        }
        
    }
    
}
