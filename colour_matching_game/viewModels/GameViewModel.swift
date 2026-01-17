//
//  GameViewModel.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-17.
//


import SwiftUI

@Observable // This makes the UI update automatically when data changes
class GameViewModel {
    var cards: [Card] = []
    private var colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange]
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    init() {
        setupGame()
    }
    
    func setupGame() {
        cards = []
        // Create pairs of colors
        for color in colors {
            cards.append(Card(color: color))
            cards.append(Card(color: color))
        }
        cards.shuffle()
    }
    
    func choose(_ card: Card) {
        // 1. Find the index of the card in our array
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        // 2. Ignore the tap if the card is already face up or already matched
        if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            
            // 3. Check if there is already one card face up
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                // Second card flipped!
                cards[chosenIndex].isFaceUp = true
                
                if cards[chosenIndex].color == cards[potentialMatchIndex].color {
                    // MATCH FOUND
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    indexOfOneAndOnlyFaceUpCard = nil
                } else {
                    // NO MATCH - Flip them back after a short delay
                    // We use Task to not "freeze" the whole app during the wait
                    Task {
                        try? await Task.sleep(nanoseconds: 700_000_000) // 0.7 seconds
                        await MainActor.run {
                            withAnimation {
                                cards[chosenIndex].isFaceUp = false
                                cards[potentialMatchIndex].isFaceUp = false
                                indexOfOneAndOnlyFaceUpCard = nil
                            }
                        }
                    }
                }
            } else {
                // First card flipped!
                // Close any other face-up cards (cleanup) and set this one
                for index in cards.indices { cards[index].isFaceUp = false }
                
                cards[chosenIndex].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        // turn the card face down if the chosen index is face up and un matched
        else if cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            cards[chosenIndex].isFaceUp = false
            //resets the tracker
            if indexOfOneAndOnlyFaceUpCard == chosenIndex {
                indexOfOneAndOnlyFaceUpCard = nil
            }
        }
    }
}
