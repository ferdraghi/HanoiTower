//
//  GameplayScreen.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//

import SwiftUI

struct GameplayScreen: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var gameStats: GameStatsViewModel
    var towerSize: Int {
        gameViewModel.towerSize
    }
    
    @State var gameResult: GameResult?
    @State var showCelebration = false
    
    var body: some View {
        VStack {
            GameplayHeaderView(currentMoves: gameViewModel.moves,
                               perfectMoveCount: gameViewModel.perfectMoveCount) {
                gameStats.endedGameWithResult(.init(towerSize: gameViewModel.towerSize,
                                                    solved: false,
                                                    solvedMoves: nil,
                                                    pefectlySolved: nil))
                dismiss()
            }
            
            Spacer()
            HStack(alignment: .bottom) {
                ForEach(0..<gameViewModel.towerCount, id: \.self) { index in
                    TowerView(towerSize: towerSize)
                    .environmentObject(gameViewModel.towerViewModels[index])
                    .onTapGesture {
                        if gameViewModel.state == . playing {
                            gameViewModel.selectTower(index)
                        }
                    }
                    .frame(width: 100)
                    .padding(.trailing, index == 2 ? 0 : 20)
                }
                
            }
            .frame(width: 300, height: 200)
            .padding(.bottom, 260)
            .padding([.leading, .trailing], 30)
        }
        .overlay {
            if showCelebration, let result = gameResult {
                CelebrationScreen(result: result) {
                    dismiss()
                }
            }
        }
        .onChange(of: gameViewModel.state) { _, newValue in
            if newValue == .completed {
                gameResult = .init(towerSize: gameViewModel.towerSize,
                                   solved: true,
                                   solvedMoves: gameViewModel.moves,
                                   pefectlySolved: gameViewModel.moves == gameViewModel.perfectMoveCount)
                showCelebration.toggle()
                gameStats.endedGameWithResult(gameResult!)
            }
        }
        .onAppear() {
            gameViewModel.gameBegin()
        }
    }
}

#Preview {
    var gameViewModel = GameViewModel()
        
    GameplayScreen()
        .environmentObject(gameViewModel)
        .environmentObject(GameStatsViewModel(useSampleData: true))
        .task {
        gameViewModel.prepareGameWithWoterSize(4)
    }
}
