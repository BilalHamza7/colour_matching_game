//
//  ContentView.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-10.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = GameViewModel()
    
    // Defines a 3-column grid layout
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            Text("Color Match")
                .font(.largeTitle).bold()
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                viewModel.choose(card)
                            }
                        }
                }
            }
            .padding()
            
            Button("Reset Game") {
                viewModel.setupGame()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

// A small sub-view for the card itself
struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(card.isFaceUp || card.isMatched ? card.color : Color.gray)
                .frame(height: 100)
            
            if !card.isFaceUp && !card.isMatched {
                Text("?")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
