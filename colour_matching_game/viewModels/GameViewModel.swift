import SwiftUI

@Observable 
class GameViewModel {
    // MARK: - Properties
    var cards: [Card] = []
    var gameState: GameState = .playing
    var score: Int = 0
    var currentLevel: Int = 1
    var timeRemaining: Double = 60.0
    
    private var selectedIndices: [Int] = []
    private let mode: GameMode
    
    // Accessibility & UI Constants
    private let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange, .pink, .cyan]
    private let symbols = ["circle.fill", "square.fill", "triangle.fill", "star.fill", "moon.fill"]

    // MARK: - Computed Properties
    var gridSize: Int {
        if currentLevel <= 2 { return 3 }      // Level 1-2: 3x3
        else if currentLevel <= 5 { return 4 } // Level 3-5: 4x4
        else { return 5 }                     // Level 6+: 5x5
    }

    // MARK: - Initialization
    init(mode: GameMode) {
        self.mode = mode
        setupLevel()
    }

    // MARK: - Game Logic
    func setupLevel() {
        cards = []
        selectedIndices.removeAll()
        gameState = .playing
        
        let totalSlots = gridSize * gridSize
        let usableSlots = totalSlots - 1 // Leave 1 for the Bomb
        
        // Calculate how many matching sets we need
        let cardsPerSet = mode.matchRequirement
        let numberOfSets = usableSlots / cardsPerSet

        for i in 0..<numberOfSets {
            let color = colors[i % colors.count]
            let symbol = symbols[i % symbols.count]
            
            for _ in 0..<cardsPerSet {
                cards.append(Card(color: color, symbol: symbol))
            }
        }
        
        // Fill remaining empty slots with matched/inactive tiles to keep grid shape
        while cards.count < usableSlots {
            cards.append(Card(color: .secondary, symbol: "xmark", isMatched: true))
        }
        
        // Add the Game Over Bomb
        cards.append(Card(color: .primary, symbol: "seal.fill", isBomb: true))
        
        cards.shuffle()
        
        // Progressive Time: Start with 60s, reduce by 3s per level
        self.timeRemaining = max(15.0, 60.0 - Double((currentLevel - 1) * 3))
    }

    func choose(_ card: Card) {
        guard gameState == .playing else { return }
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        guard !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched else { return }

        // 1. Bomb Logic
        if cards[chosenIndex].isBomb {
            cards[chosenIndex].isFaceUp = true
            gameState = .gameOver(reason: "BOOM! You hit the bomb.")
            TelemetryManager.shared.logEvent(name: "game_over_bomb", parameters: ["level": currentLevel])
            return
        }

        // 2. Select Card
        cards[chosenIndex].isFaceUp = true
        selectedIndices.append(chosenIndex)

        // 3. Match Logic
        if selectedIndices.count == mode.matchRequirement {
            checkMatch()
        }
    }

    private func checkMatch() {
        let firstColor = cards[selectedIndices[0]].color
        let isMatch = selectedIndices.allSatisfy { cards[$0].color == firstColor }

        if isMatch {
            handleSuccess()
        } else {
            handleFailure()
        }
    }

    private func handleSuccess() {
        for index in selectedIndices {
            cards[index].isMatched = true
        }
        
        // Bonus: "Set Surge" gives more points and time
        let bonus = mode == .setSurge ? 150 : 100
        score += bonus * currentLevel
        timeRemaining += 2.0 // Small time reward
        
        selectedIndices.removeAll()
        
        // Check if level is cleared
        if cards.filter({ !$0.isMatched && !$0.isBomb }).isEmpty {
            advanceLevel()
        }
    }

    private func handleFailure() {
        let indicesToFlip = selectedIndices
        selectedIndices.removeAll()
        
        // Penalty: Mistakes reduce time in progressive mode
        timeRemaining -= Double(currentLevel) 

        Task {
            try? await Task.sleep(nanoseconds: 600_000_000)
            await MainActor.run {
                withAnimation {
                    for index in indicesToFlip {
                        cards[index].isFaceUp = false
                    }
                }
            }
        }
    }

    func advanceLevel() {
        currentLevel += 1
        gameState = .levelComplete
        
        // Small delay to show the "Win" before generating next level
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.setupLevel()
        }
    }
}