//
//  LandingView.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-01.
//

import SwiftUIIntrospect
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
        .introspect(.tabView, on: .iOS(.v17, .v18), customize: { controller in
            let bar = UITabBarAppearance()
            bar.configureWithOpaqueBackground()
            controller.tabBar.scrollEdgeAppearance = bar
        })
    }
}

#Preview {
    LandingView()
        .environment(JokeViewModel())
}
