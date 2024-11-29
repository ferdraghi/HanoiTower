//
//  ContentView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var gameStats: GameStatsViewModel
    @State private var startGame = false
    @State private var showStats = false
    @State private var towerSize = 4
    let towerSizes = Array(4...10)
    var body: some View {
        GeometryReader { g in
            VStack {
                GameTitleParallaxView()
                    .padding(.top, 80)
                
                Spacer()
                StatsButtonView(showStats: $showStats)
                TowerSizeSelectorView(towerSize: $towerSize,
                                      solvedSizes: gameStats.sizesSolved,
                                      perfectlySolvedSizes: gameStats.sizesPerfectlySolved)
                .padding([.leading, .trailing], 40)
                Spacer()
                PlayButtonView {
                    gameViewModel.prepareGameWithWoterSize(towerSize)
                    startGame.toggle()
                }
                .padding(.bottom, 80)
                Spacer()
            }
            .frame(height: g.size.height)
            .onChange(of: towerSize) { _, _ in}
            .padding()
            .preferredColorScheme(.dark)
        }
        .fullScreenCover(isPresented: $startGame) {
            GameplayScreen()
                .environmentObject(gameViewModel)
                .environmentObject(gameStats)
        }
        .fullScreenCover(isPresented: $showStats) {
            GameStatsScreen()
                .environmentObject(gameStats)
        }
        .ignoresSafeArea()
    }
    
}

#Preview {
    ContentView()
        .environmentObject(GameViewModel())
        .environmentObject(GameStatsViewModel())
}
