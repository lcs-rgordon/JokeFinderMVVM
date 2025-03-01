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
    @State var viewModel = JokeViewModel()
    
    // Controls punchline visibility
    @State var punchlineOpacity = 0.0
    
    // Starts a timer to wait on revealing punchline
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    // Controls amount of offset when dragging
    @State var dragOffset = CGSize.zero
    
    // MARK: Computed properties
    var body: some View {
        VStack{
            
            if let currentJoke = viewModel.currentJoke {
                
                Group {
                    
                    Text(currentJoke.setup ?? "")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 100)
                        .onReceive(timer) { _ in
                            withAnimation {
                                punchlineOpacity = 1.0
                            }
                        }

                    Text(currentJoke.punchline ?? "")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .opacity(punchlineOpacity)
                }
                // Ensure that we can drag even when tapping on space between the Text views
                .contentShape(Rectangle())
                // Rotate the card at 1/5 the distance it has been dragged
                .rotationEffect(.degrees(Double(dragOffset.width / 20)))
//                // Move the view a bit ahead of the finger's position
                .offset(x: dragOffset.width)
                /*
                 Now, the calculation for this view takes a little thinking, and I wouldn’t blame you if you wanted to spin this off into a method rather than putting it inline. Here’s how it works:
                 
                 We’re going to take 1/50th of the drag amount, so the card doesn’t fade out too quickly.
                 We don’t care whether they have moved to the left (negative numbers) or to the right (positive numbers), so we’ll put our value through the abs() function. If this is given a positive number it returns the same number, but if it’s given a negative number it removes the negative sign and returns the same value as a positive number.
                 We then use this result to subtract from 2.
                 The use of 2 there is intentional, because it allows the card to stay opaque while being dragged just a little. So, if the user hasn’t dragged at all the opacity is 2.0, which is identical to the opacity being 1. If they drag it 50 points left or right, we divide that by 50 to get 1, and subtract that from 2 to get 1, so the opacity is still 1 – the card is still fully opaque. But beyond 50 points we start to fade out the card, until at 100 points left or right the opacity is 0.
                 */
                .opacity(2 - Double(abs(dragOffset.width / 50)))
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            dragOffset = gesture.translation
                        }
                        .onEnded { gesture in
                            
                            // Remove the joke if the user dragged far enough to the left or right
                            if abs(dragOffset.width) > 100 {
                                
                                // Swipe right, save the joke
                                if dragOffset.width > 0 {
                                    viewModel.saveJoke()
                                }
                                
                                // Clear the old joke
                                viewModel.clearJoke()
                                
                                // Now get a new joke
                                Task {
                                    await viewModel.fetchJoke()
                                    print(viewModel.savedJokes.count)
                                }
                                dragOffset = .zero
                                punchlineOpacity = 0

                            } else {
                                // Put the joke back where it was
                                dragOffset = .zero
                            }
                        }
                )
                
                Spacer()
                
            } else {
                
                Spacer()
                
                ProgressView()
                
                Spacer()
                
            }
            
        }
        .padding()
        .navigationTitle("Joke Finder")
    }
}

#Preview {
    NavigationStack {
        JokeView()
    }
}
