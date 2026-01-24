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
    let achievements = [
        Achievement(title: "First Match", icon: "sparkles", isUnlocked: true),
        Achievement(title: "Speed Demon", icon: "bolt.fill", isUnlocked: false),
        Achievement(title: "Perfect Game", icon: "crown.fill", isUnlocked: false),
        Achievement(title: "Color Master", icon: "paintpalette.fill", isUnlocked: true)
    ]

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(achievements) { ach in
                        VStack {
                            Image(systemName: ach.icon)
                                .font(.system(size: 40))
                                .foregroundColor(ach.isUnlocked ? .orange : .gray)
                                .padding()
                                .background(Circle().fill(Color.secondary.opacity(0.1)))
                            
                            Text(ach.title)
                                .font(.caption)
                                .bold()
                                .opacity(ach.isUnlocked ? 1.0 : 0.5)
                        }
                        .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("Achievements")
        }
    }
}
