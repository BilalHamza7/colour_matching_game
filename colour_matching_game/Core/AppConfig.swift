import SwiftUI

struct AppConfig {
    static let baseTimer: Double = 60.0
    static let bombPenalty: Double = -10.0 // Penalty for hitting a bomb if it's not instant Game Over
    static let mistakePenalty: Double = 2.0
    static let streakBonusTime: Double = 5.0
    
    // Grid settings
    static let easyGridSize = 3
    static let mediumGridSize = 4
    static let hardGridSize = 5
}