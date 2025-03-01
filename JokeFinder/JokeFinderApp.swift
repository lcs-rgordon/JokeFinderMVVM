//
//  JokeFinderApp.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-01.
//

import SwiftUI

@main
struct JokeFinderApp: App {
    
    // MARK: Stored properties
    @State var viewModel = JokeViewModel()
    
    // MARK: Computed properties
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environment(viewModel)
        }
    }
}
