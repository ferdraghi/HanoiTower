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
            HStack {
                Text("Moves: \(gameViewModel.moves)")
                    .font(.largeTitle)
                    .monospacedDigit()
                    .padding(.leading, 30)
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
                .padding()
            }
            HStack {
                Text("Perfect Moves: \(gameViewModel.perfectMoveCount)")
                    .font(.headline)
                    .monospacedDigit()
                    .padding(.leading, 30)
                Spacer()
            }
            
            Spacer()
            HStack(alignment: .bottom) {
                ForEach(0...2, id: \.self) { index in
                    VStack {
                        Spacer()
                        VStack(spacing: 3) {
                            Spacer()
                            ForEach(gameViewModel.towers[index].pieces.reversed()) { piece in
                                TowerPieceView(pieceSize: piece.size)
                            }
                        }
                        .frame(width: 100, height: 500)
                        
                        .background(.blue.opacity(gameViewModel.selectedTower == index ? 0.5 : 0.15))
                        .onTapGesture {
                            guard gameViewModel.state == . playing else { return }
                            gameViewModel.selectedTower(index)
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
    }
}

#Preview {
    GameplayScreen()
        .environmentObject(GameViewModel(towerSize: 4))
}
