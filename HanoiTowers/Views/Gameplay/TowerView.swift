//
//  TowerView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct TowerView: View {
    @EnvironmentObject private var towerViewModel: GameTowerViewModel
    let towerSize: Int
    @State private var introAnimation: Bool = false
    @State private var newPieceAnimation: Bool = false
    
    private var pieces: [TowerPiece] {
        towerViewModel.tower.pieces
    }
    
    private var towerSelected: Bool {
        towerViewModel.selected
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .frame(width: 5, height: min(500.0, CGFloat(60 * towerSize)))
                .foregroundStyle(.gray)
            VStack(spacing: 3) {
                Spacer()
                ForEach(pieces) { piece in
                    let index = pieces.firstIndex { $0.size == piece.size } ?? 0
                    TowerPieceView(pieceSize: piece.size,
                                   selected: towerSelected && index == 0)
                    .offset(x: 0, y: pieceOffsetForIndex(index))
                    .animation(.easeIn(duration: 1.5 - (CGFloat(index) / 30.0)).speed(2), value: introAnimation)
                }
            }
            .frame(width: 100, height: 500)
            .background(.blue.opacity(towerSelected ? 0.5 : 0.15))
            .onAppear() {
                introAnimation.toggle()
            }
            .onChange(of: towerViewModel.hasNewPiece) { _, newValue in
                if newValue {
                    withAnimation(.easeIn(duration: 1).speed(4)) {
                        newPieceAnimation.toggle()
                    } completion: {
                        newPieceAnimation = false
                        towerViewModel.clearNewPieceStatus()
                    }
                }
            }
        }
    }
    
    private func pieceOffsetForIndex(_ index: Int) -> CGFloat {
        guard towerViewModel.hasNewPiece else { return introAnimation ? 0 : -500 }
        
        if index == 0 {
            return newPieceAnimation ? 0 : -200
        }
        
        return 0
    }
}

#Preview {
    var vm4 = GameTowerViewModel(numberOfPieces: 4)
    var vm7 = GameTowerViewModel(numberOfPieces: 7)
    var vm10 = GameTowerViewModel(numberOfPieces: 10)
    HStack {
        TowerView(towerSize: 10)
            .environmentObject(vm4)
            .onTapGesture {
                vm4.selected.toggle()
                
                if !vm4.selected {
                    vm4.getTopPieceFrom(.init(numberOfPieces: 1))
                }
            }
        TowerView(towerSize: 10)
            .environmentObject(vm7)
            .onTapGesture {
                vm7.selected.toggle()
                if !vm7.selected {
                    vm7.getTopPieceFrom(.init(numberOfPieces: 1))
                }
            }
        TowerView(towerSize: 10)
            .environmentObject(vm10)
            .onTapGesture {
                vm10.selected.toggle()
                if !vm10.selected {
                    vm10.getTopPieceFrom(.init(numberOfPieces: 1))
                }
            }
    }
}
