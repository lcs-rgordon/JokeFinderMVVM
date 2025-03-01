//
//  FavouriteJokesView.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-01.
//

import SwiftUI

struct FavouriteJokesView: View {
    
    // MARK: Stored properties
    @Environment(JokeViewModel.self) var viewModel
    
    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            List(viewModel.savedJokes) { currentJoke in
                VStack(alignment: .leading, spacing: 5) {
                    Text(currentJoke.setup ?? "")
                    Text(currentJoke.punchline ?? "")
                        .italic()
                }
            }
            .navigationTitle("Favourites")
        }
    }
}

#Preview {
    FavouriteJokesView()
        .environment(JokeViewModel())
}
