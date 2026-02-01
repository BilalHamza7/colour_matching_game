import SwiftUI

struct Card: Identifiable, Equatable {
    let id = UUID()
    var color: Color
    var symbol: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var isBomb: Bool = false
    
    // Static helper for descriptions (for Accessibility)
    var accessibilityDescription: String {
        if isBomb { return "Bomb" }
        return "\(color.description) \(symbol.replacingOccurrences(of: ".fill", with: ""))"
    }
}
