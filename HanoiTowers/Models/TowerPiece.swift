//
//  TowerPiece.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//

import Foundation

struct TowerPiece: Identifiable {
    var id: Int {
        return size
    }
    let size: Int
}
