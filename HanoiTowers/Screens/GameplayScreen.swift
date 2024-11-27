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
    var towerSize: Int {
        gameViewModel.towerSize
    }
    
    var body: some View {
        VStack {
            GameplayHeaderView(currentMoves: gameViewModel.moves,
                               perfectMoveCount: gameViewModel.perfectMoveCount) {
                dismiss()
            }
            
            Spacer()
            HStack(alignment: .bottom) {
                ForEach(0...2, id: \.self) { index in
                    TowerView(towerSize: towerSize,
                              pieces: gameViewModel.towers[index].pieces,
                              selectedPiece: gameViewModel.selectedPiece,
                              towerSelected: gameViewModel.selectedTower == index)
                    .onTapGesture {
                        guard gameViewModel.state == . playing else { return }
                        gameViewModel.selectedTower(index)
                    }
                    .frame(width: 100)
                    .padding(.trailing, index == 2 ? 0 : 20)
                }
                
            }
            .frame(width: 300, height: 200)
            .padding(.bottom, 260)
            .padding([.leading, .trailing], 30)
        }
    }
}

#Preview {
    GameplayScreen()
        .environmentObject(GameViewModel(towerSize: 10))
}
