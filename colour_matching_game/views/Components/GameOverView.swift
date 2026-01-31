//
//  GameOverView.swift
//  colour_matching_game
//
//  Created by bsccomp242p-026 on 2026-01-31.
//

import SwiftUI

struct GameOverView: View {
    let reason: String
    let score: Int
    let onRestart: () -> Void
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // Darken the background
            Color.black.opacity(0.85)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
                
                Text("GAME OVER")
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                
                Text(reason)
                    .font(.title3)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                VStack(spacing: 5) {
                    Text("FINAL SCORE")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(score)")
                        .font(.system(size: 50, weight: .bold, design: .monospaced))
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(20)

                HStack(spacing: 20) {
                    Button(action: onRestart) {
                        Label("Try Again", systemImage: "arrow.clockwise")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: { dismiss() }) {
                        Text("Menu")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .transition(.opacity.combined(with: .scale))
    }
}
