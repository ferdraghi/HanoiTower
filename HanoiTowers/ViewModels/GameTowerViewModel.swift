//
//  GameTowerViewModel.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 28/11/2024.
//

import SwiftUI

class GameTowerViewModel: ObservableObject {
    private var tower: Tower
    @Published var selected: Bool = false
    @Published private(set) var pieceCount: Int

    var pieces: [TowerPiece] {
        tower.pieces
    }
    
    var topPieceSize: Int? {
        tower.peekTopPiece()?.size
    }
    
    init(numberOfPieces: Int) {
        self.tower = Tower()
        self.pieceCount = numberOfPieces

        if numberOfPieces > 0 {
            Array(0..<numberOfPieces).map { TowerPiece(size: numberOfPieces-$0) }.forEach { piece in
                self.tower.stack(piece)
            }
        }
    }
    
    func stack(_ piece: TowerPiece) {
        tower.stack(piece)
    }
    
    func handOverTopPiece() -> TowerPiece? {
        guard pieceCount > 0 else { return nil }
        
        let piece = tower.topPiece()
        pieceCount = tower.pieces.count
        
        return piece
    }
    
    func getTopPieceFrom(_ towerVM: GameTowerViewModel) {
        guard let newPiece = towerVM.handOverTopPiece() else { return }
        
        tower.stack(newPiece)
        pieceCount = tower.pieces.count
    }
}
