//
//  LeaderboardView.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-24.
//

import SwiftUI

struct Player: Identifiable {
    let id = UUID()
    let name: String
    let score: Int
}

struct LeaderboardView: View {
    // Mock data for now
    let topPlayers = [
        Player(name: "Bilal", score: 2500),
        Player(name: "Sara", score: 2100),
        Player(name: "John", score: 1800),
        Player(name: "Techie_99", score: 1500)
    ]

    var body: some View {
        NavigationStack {
            List(topPlayers.indices, id: \.self) { index in
                HStack {
                    Text("\(index + 1)") // Rank
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .frame(width: 30)
                    
                    Text(topPlayers[index].name)
                        .font(.body)
                    
                    Spacer()
                    
                    Text("\(topPlayers[index].score) pts")
                        .bold()
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 5)
            }
            .navigationTitle("Leaderboard")
        }
    }
}
