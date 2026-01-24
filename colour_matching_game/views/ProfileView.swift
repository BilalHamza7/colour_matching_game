//
//  ProfileView.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("User Info")) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Bilal Hamza")
                                .font(.headline)
                            Text("Level 12 Color Matcher")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical)
                }
                
                Section(header: Text("Statistics")) {
                    LabeledContent("Games Played", value: "42")
                    LabeledContent("Total Wins", value: "28")
                    LabeledContent("High Score", value: "2500")
                }
                
                Section {
                    Button("Edit Profile") { /* Action here */ }
                    Button("Logout", role: .destructive) { /* Action here */ }
                }
            }
            .navigationTitle("Profile")
        }
    }
}
