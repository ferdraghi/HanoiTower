//
//  TowerView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct TowerView: View {
    let towerSize: Int
    let pieces: [TowerPiece]
    let selectedPiece: Int?
    let towerSelected: Bool
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .frame(width: 5, height: min(500.0, CGFloat(60 * towerSize)))
                .foregroundStyle(.gray)
            VStack(spacing: 3) {
                Spacer()
                ForEach(pieces) { piece in
                    TowerPieceView(pieceSize: piece.size,
                                   selected: piece.size == (selectedPiece ?? -1))
                }
            }
            .frame(width: 100, height: 500)
            .background(.blue.opacity(towerSelected ? 0.5 : 0.15))
        }
    }
}

#Preview {
    var pieces: (Int) -> [TowerPiece] = { size in
        var pieces = Array(0..<size).map { TowerPiece(size: size-$0) }
        return pieces.reversed()
    }
    HStack {
        TowerView(towerSize: 10, pieces: pieces(4), selectedPiece: 1, towerSelected: true)
        TowerView(towerSize: 10, pieces: pieces(7), selectedPiece: 1, towerSelected: true)
        TowerView(towerSize: 10, pieces: pieces(10), selectedPiece: 1, towerSelected: true)
    }
}
