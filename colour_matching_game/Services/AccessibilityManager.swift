
import SwiftUI

struct AccessibilityManager {
    /// Generates a descriptive label for a card
    static func label(for card: Card) -> String {
        if card.isMatched {
            return "Matched \(card.color.description)"
        }
        
        if card.isFaceUp {
            if card.isBomb {
                return "Danger! This is a bomb."
            }
            // Describes the color and the symbol (e.g., "Red Star")
            let symbolName = card.symbol.replacingOccurrences(of: ".fill", with: "")
            return "\(card.color.description) \(symbolName)"
        } else {
            return "Hidden card"
        }
    }
}
