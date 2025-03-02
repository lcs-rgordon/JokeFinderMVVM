//
//  JokeFinderApp.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-01.
//

import SwiftData
import SwiftUI

@main
struct JokeFinderApp: App {
    
    // MARK: Stored properties
    
    // View model for the views in this app
    @State var viewModel: JokeViewModel
    
    // Container for favourite jokes stored using SwiftData
    let container: ModelContainer
    
    // MARK: Computed properties
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environment(viewModel)
                .modelContainer(container)
        }
    }
    
    // MARK: Initializer(s)
    init() {
        do {
            container = try ModelContainer(for: FavouriteJoke.self)
            viewModel = JokeViewModel(modelContext: container.mainContext)
        } catch {
            fatalError("Failed to create ModelContainer for FavouriteJokes")
        }
    }
}
