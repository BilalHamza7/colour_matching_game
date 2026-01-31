//
//  AchievementsView.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-24.
//

import Foundation
import SwiftUI

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let isUnlocked: Bool
}

struct AchievementsView: View {
    let badges = [
        Achievement(title: "First Match", icon: "hand.thumbsup.fill", isUnlocked: true),
        Achievement(title: "Bomb Survivor", icon: "shield.fill", isUnlocked: false),
        Achievement(title: "Speed Runner", icon: "bolt.fill", isUnlocked: false)
    ]

    var body: some View {
        NavigationStack {
            List(badges) { badge in
                HStack {
                    Image(systemName: badge.icon)
                        .font(.title2)
                        .foregroundColor(badge.isUnlocked ? .orange : .gray)
                        .frame(width: 40)
                    Text(badge.title)
                        .opacity(badge.isUnlocked ? 1.0 : 0.5)
                    Spacer()
                    if !badge.isUnlocked { Image(systemName: "lock.fill").foregroundColor(.gray) }
                }
            }
            .navigationTitle("Badges")
        }
    }
}