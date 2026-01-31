import SwiftUI

struct Card: Identifiable, Equatable {
    let id = UUID()
    let color: Color
    let symbol: String    // e.g., "square.fill", "circle.fill" for Accessibility
    var isFaceUp = false
    var isMatched = false
    var isBomb = false    // The "Game Over" tile
    
    // For unit testing and comparison
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}