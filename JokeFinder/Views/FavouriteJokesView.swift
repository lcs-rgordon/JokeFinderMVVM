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
                
                if viewModel.favouriteJokes.isEmpty {
                    ContentUnavailableView("No favourite jokes", systemImage: "heart.slash", description: Text("See if a new joke might tickle your funny bone!"))
                } else {
                    List(viewModel.favouriteJokes) { joke in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(joke.setup)
                            Text(joke.punchline)
                                .italic()
                        }
                        .swipeActions {
                            ShareLink(
                                "Share",
                                item: "\(joke.setup)\n\n\(joke.punchline)",
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
