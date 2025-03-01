//
//  ContentView.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-01.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    
    // Create the view model
    var viewModel = JokeViewModel()

    // MARK: Computed properties
    var body: some View {
        Text("Hello world")
            .task {
                debugPrint("About to access view model")
                await viewModel.fetchJoke()
                debugPrint(viewModel.currentJoke)
                debugPrint("Finished getting joke")
            }
    }
}

#Preview {
    ContentView()
}
