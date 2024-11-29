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
                        guard gameViewModel.state == . playing else { return }
                        gameViewModel.selectTower(index)
                    }
                    .frame(width: 100)
                    .padding(.trailing, index == 2 ? 0 : 20)
                }
                
            }
            .frame(width: 300, height: 200)
            .padding(.bottom, 260)
            .padding([.leading, .trailing], 30)
        }
        .onChange(of: gameViewModel.state) { _, newValue in
            if newValue == .completed {
                gameStats.endedGameWithResult(.init(towerSize: gameViewModel.towerSize,
                                                    solved: true,
                                                    solvedMoves: gameViewModel.moves,
                                                    pefectlySolved: gameViewModel.moves == gameViewModel.perfectMoveCount))
                dismiss()
            }
        }
    
    }
}

#Preview {
    GameplayScreen()
        .environmentObject(GameViewModel(towerSize: 10))
}
