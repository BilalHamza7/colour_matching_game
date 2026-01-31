import XCTest
import SwiftUI
@testable import colour_matching_game

final class GameLogicTests: XCTestCase {
    
    func testBombInteraction() {
        // FIX: Remove 'difficulty'
        let vm = GameViewModel(mode: .classic)
        
        guard let bombIndex = vm.cards.firstIndex(where: { $0.isBomb }) else {
            XCTFail("Bomb should exist in Level 1")
            return
        }
        
        vm.choose(vm.cards[bombIndex])
        
        if case .gameOver(let reason) = vm.gameState {
            // FIX: Ensure this string matches your ViewModel (e.g., "BOOM! You hit the bomb.")
            XCTAssertTrue(reason.contains("bomb"), "Reason should mention the bomb")
        } else {
            XCTFail("Game state should be gameOver after hitting a bomb")
        }
    }

    func testSetSurgeRequirement() {
        // FIX: Remove 'difficulty'
        let vm = GameViewModel(mode: .setSurge)
        
        // Match 3 is required for Set Surge
        XCTAssertEqual(vm.mode.matchRequirement, 3)
        
        // Find cards of same color
        let redCards = vm.cards.filter { $0.color == .red }
        
        // Act: Choose only 2
        vm.choose(redCards[0])
        vm.choose(redCards[1])
        
        // Assert: Should not be matched yet
        XCTAssertFalse(vm.cards[vm.cards.firstIndex(where: { $0.id == redCards[0].id })!].isMatched)
    }
}
