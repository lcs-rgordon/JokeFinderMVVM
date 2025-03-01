//
//  LandingView.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-01.
//

import SwiftUI

struct LandingView: View {
    
    // MARK: Stored properties
    @State var currentTab = 0

    // MARK: Computed properties
    var body: some View {
        TabView(selection: $currentTab) {
            
            JokeView()
                .tabItem {
                    Label {
                        Text("New Jokes")
                    } icon: {
                        Image(systemName: "smiley")
                    }

                }
                .tag(1)

            FavouriteJokesView()
                .tabItem {
                    Label {
                        Text("Favourites")
                    } icon: {
                        Image(systemName: "heart.fill")
                    }

                }
                .tag(2)

            
        }
    }
}

#Preview {
    LandingView()
        .environment(JokeViewModel())
}
