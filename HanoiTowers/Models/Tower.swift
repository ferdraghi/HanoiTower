//
//  Tower.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//

import Foundation

struct Tower {
    private(set) var pieces = [TowerPiece]()

    mutating func stack(_ piece: TowerPiece) {
        pieces.append(piece)
    }
    
    mutating func topPiece() -> TowerPiece? {
        pieces.popLast()
    }
    
    func peekLast() -> TowerPiece? {
        pieces.last
    }
}
