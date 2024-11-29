//
//  GameTowerViewModel.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 28/11/2024.
//

import SwiftUI

class GameTowerViewModel: ObservableObject {
    private(set) var tower: Tower
    @Published var selected: Bool = false
    @Published private(set) var hasNewPiece: Bool = false

    var topPieceSize: Int? {
        tower.peekTopPiece()?.size
    }
    
    var pieceCount: Int {
        tower.pieces.count
    }
    
    init(numberOfPieces: Int) {
        self.tower = Tower()
        
        if numberOfPieces > 0 {
            Array(0..<numberOfPieces).map { TowerPiece(size: numberOfPieces-$0) }.forEach { piece in
                self.tower.stack(piece)
            }
        }
    }
    
    func stack(_ piece: TowerPiece) {
        tower.stack(piece)
    }
    
    func getTopPieceFrom(_ towerVM: GameTowerViewModel) {
        guard let newPiece = towerVM.tower.topPiece() else { return }
        
        tower.stack(newPiece)
        hasNewPiece = true
    }
    
    func clearNewPieceStatus() {
        hasNewPiece = false
    }
}