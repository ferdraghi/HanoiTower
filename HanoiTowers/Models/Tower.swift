//
//  Tower.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//

import Foundation

struct Tower {
    private var _pieces = [TowerPiece]()
    var pieces: [TowerPiece] {
        _pieces.reversed()
    }

    mutating func stack(_ piece: TowerPiece) {
        _pieces.append(piece)
    }
    
    mutating func topPiece() -> TowerPiece? {
        _pieces.popLast()
    }
    
    func peekTopPiece() -> TowerPiece? {
        _pieces.last
    }
}
