import Foundation

enum GameMode: String, CaseIterable, Identifiable {
    case classic = "Classic"
    case setSurge = "Set Surge" // 3-4 tiles of same color
    case chromaShift = "Chroma Shift"
    
    var id: String { self.rawValue }
    
    var matchRequirement: Int {
        switch self {
        case .classic: return 2
        case .setSurge: return 3 // Requires 3 matching tiles for a bonus
        case .chromaShift: return 2
        }
    }
}