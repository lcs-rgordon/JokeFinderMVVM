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
            ZStack {
                Color.favouriteJokes
                    .ignoresSafeArea()
                
                if viewModel.savedJokes.isEmpty {
                    ContentUnavailableView("No favourite jokes", systemImage: "heart.slash", description: Text("See if a new joke might tickle your funny bone!"))
                } else {
                    List(viewModel.savedJokes) { currentJoke in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(currentJoke.setup ?? "")
                            Text(currentJoke.punchline ?? "")
                                .italic()
                        }
                        .swipeActions {
                            ShareLink(
                                "Share",
                                item: "\(currentJoke.setup ?? "")\n\n\(currentJoke.punchline ?? "")",
                                preview: SharePreview(
                                    "Share Joke",
                                    image: Image("ShareJokeImage")
                                )
                            )

                        }
                    }
                    .listStyle(.plain)
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
