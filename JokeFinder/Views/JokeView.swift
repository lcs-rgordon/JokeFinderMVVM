//
//  JokeView.swift
//  JokeFinder
//
//  Created by Russell Gordon on 2025-03-01.
//

import SwiftUI

struct JokeView: View {
    
    // MARK: Stored properties
    
    // Create the view model
    var viewModel = JokeViewModel()
    
    // Controls punchline visibility
    @State var punchlineOpacity = 0.0
    
    // MARK: Computed properties
    var body: some View {
        VStack{
            
            if let currentJoke = viewModel.currentJoke {
                
                Text(currentJoke.setup)
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Button {
                    
                    // Fade in the punchline
                    withAnimation {
                        punchlineOpacity = 1.0
                    }
                    
                } label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .tint(.black)
                }
                
                Text(currentJoke.punchline)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .opacity(punchlineOpacity)
                
                Spacer()
                
            } else {
                
                ProgressView()
                
            }
            
        }
        .padding()
        .navigationTitle("Random Jokes")
    }
}

#Preview {
    NavigationStack {
        JokeView()
    }
}
