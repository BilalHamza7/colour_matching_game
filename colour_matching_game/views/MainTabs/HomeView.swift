//
//  HomeView.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-24.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Image(systemName: "square.grid.3x3.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                    .padding()

                Text("Choose Your Mode")
                    .font(.title2).bold()

                ForEach(GameMode.allCases) { mode in
                    NavigationLink(destination: GameView(mode: mode)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(mode.rawValue).font(.headline)
                                Text(modeDescription(for: mode)).font(.caption)
                            }
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .font(.title)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(12)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Color Match")
        }
    }

    func modeDescription(for mode: GameMode) -> String {
        switch mode {
        case .classic: return "Match standard pairs."
        case .setSurge: return "Match 3 tiles of the same color."
        case .chromaShift: return "Cards shuffle as you play!"
        }
    }
}