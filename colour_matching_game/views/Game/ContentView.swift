//
//  ContentView.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-10.
//

import SwiftUI
internal import Combine

struct ContentView: View {
    @State private var viewModel: GameViewModel
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    // FIX: Change init to accept GameMode
    init(mode: GameMode) {
        _viewModel = State(initialValue: GameViewModel(mode: mode))
    }
    
    // FIX: Make grid columns dynamic based on the ViewModel's gridSize
    var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 10), count: viewModel.gridSize)
    }
    
    var body: some View {
        VStack {
            // Header using the ScoreView component we built
            ScoreView(
                score: viewModel.score,
                level: viewModel.currentLevel,
                timeRemaining: viewModel.timeRemaining
            )
            .padding()
            
            Text(viewModel.mode.rawValue)
                .font(.title2).bold()
                .foregroundColor(.secondary)
            
            Spacer()
            
            // Grid now adapts to 3x3, 4x4, or 5x5
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .accessibilityLabel(AccessibilityManager.label(for: card))
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    viewModel.choose(card)
                                }
                            }
                }
            }
            .padding()
            
            Spacer()
            
            Button("Reset Level") {
                viewModel.setupLevel()
            }
            .buttonStyle(.bordered)
        }
        .onReceive(timer) { _ in
                    viewModel.updateTimer()
                }
        .overlay {
            // Check if the game state is gameOver
            if case .gameOver(let reason) = viewModel.gameState {
                // ONLY use the component we built
                GameOverView(reason: reason, score: viewModel.score) {
                    withAnimation {
                        viewModel.resetGame() // Now calls the full reset
                    }
                }
            }
        }
    }
}

#Preview("Classic Mode") {
    ContentView(mode: .classic)
}

#Preview("Set Surge") {
    ContentView(mode: .setSurge)
}
