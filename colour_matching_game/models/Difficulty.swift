enum Difficulty: String, CaseIterable, Identifiable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var id: String { self.rawValue }
    
    // Define how many pairs each mode has
    var pairCount: Int {
        switch self {
        case .easy: return 4   // 8 cards
        case .medium: return 6 // 12 cards
        case .hard: return 10  // 20 cards
        }
    }
}
