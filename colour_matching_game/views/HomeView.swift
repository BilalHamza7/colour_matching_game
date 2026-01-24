//
//  HomeView.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-24.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack { // Required to allow "jumping" to the game screen
            VStack(spacing: 20) {
                Text("Select Difficulty")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                // We loop through our Difficulty enum cases
                ForEach(Difficulty.allCases) { level in
                    NavigationLink(destination: ContentView(difficulty: level)) {
                        Text(level.rawValue)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                }
            }
            .padding()
            .navigationTitle("Main Menu")
        }
    }
}
