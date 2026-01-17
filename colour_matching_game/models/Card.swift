//
//  Card.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-17.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID() // Unique ID so SwiftUI can track it
    let color: Color
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}
