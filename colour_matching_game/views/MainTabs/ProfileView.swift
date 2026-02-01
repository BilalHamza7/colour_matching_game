//
//  ProfileView.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-24.
//

import SwiftUI

struct ProfileView: View {
    @State private var userName: String = "Player 1"
    @State private var telemetryEnabled: Bool = true

    var body: some View {
        NavigationStack {
            Form {
                Section("User Info") {
                    TextField("Name", text: $userName)
                }
                Section("Settings") {
                    Toggle("Send Telemetry Data", isOn: $telemetryEnabled)
                }
                Section("Stats") {
                    HStack {
                        Text("Highest Level")
                        Spacer()
                        Text("12").bold()
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}
