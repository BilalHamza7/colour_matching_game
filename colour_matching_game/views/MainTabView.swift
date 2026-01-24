//
//  MainTableView.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Your Game Entry Point (Assuming HomeView is your menu)
            HomeView()
                .tabItem {
                    Label("Play", systemImage: "gamecontroller")
                }
            
            LeaderboardView()
                .tabItem {
                    Label("Ranks", systemImage: "list.number")
                }
            
            AchievementsView()
                .tabItem {
                    Label("Badges", systemImage: "star.circle")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        // This adds a nice tint color to the active tab icon
        .tint(.blue)
    }
}

#Preview {
    MainTabView()
}
