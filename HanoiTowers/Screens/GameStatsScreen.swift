//
//  GameStatsScreen.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct GameStatsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var gameStats: GameStatsViewModel
    @State private var resetStats = false
    @State private var confirmResetStats = false
    @State private var presentResetConfirmation = false
    var body: some View {
        GeometryReader { g in
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.square.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .foregroundStyle(.red.opacity(0.8))
                    }
                    .padding([.trailing, .top], 20)
                }
                .padding(.bottom, 20)
                GameStatsTableView()
                    .environmentObject(gameStats)
                Spacer()
                HStack {
                    ResetStatsButton(resetStats: $confirmResetStats)
                        .confirmationDialog(
                            "Are you sure you want to reset all the stats?",
                            isPresented: $confirmResetStats,
                            titleVisibility: .visible) {
                                Button("Reset", role: .destructive) {
                                    gameStats.resetAllStats()
                                }
                                Button("Cancel", role: .cancel) {}
                            }
                }
                .padding(.bottom, 70)
            }
        }
    }
}

#Preview {
    GameStatsScreen()
        .environmentObject(GameStatsViewModel(useSampleData: true))
}
