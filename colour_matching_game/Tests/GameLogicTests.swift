import XCTest
@testable import colour_matching_game

final class GameLogicTests: XCTestCase {
    
    // CASE: Does the Bomb trigger Game Over?
    func testBombInteraction() {
        let vm = GameViewModel(difficulty: .easy, mode: .classic)
        
        // Find the bomb manually in the shuffled array
        guard let bombIndex = vm.cards.firstIndex(where: { $0.isBomb }) else {
            XCTFail("Bomb should exist in a 3x3 grid")
            return
        }
        
        vm.choose(vm.cards[bombIndex])
        
        if case .gameOver(let reason) = vm.gameState {
            XCTAssertEqual(reason, "You hit a bomb!")
        } else {
            XCTFail("Game state should be gameOver after hitting a bomb")
        }
    }

    // CASE: Does Set Surge require 3 cards to match?
    func testSetSurgeRequirement() {
        let vm = GameViewModel(difficulty: .easy, mode: .setSurge)
        
        // Pick two identical cards (should not match yet in Set Surge)
        let redCards = vm.cards.filter { $0.color == .red }
        vm.choose(redCards[0])
        vm.choose(redCards[1])
        
        XCTAssertFalse(redCards[0].isMatched, "In Set Surge, 2 cards should not trigger a match yet.")
        XCTAssertEqual(vm.mode.matchRequirement, 3)
    }
}