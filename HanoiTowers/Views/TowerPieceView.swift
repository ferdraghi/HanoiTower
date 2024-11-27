//
//  TowerPieceView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//

import SwiftUI

struct TowerPieceView: View {
    let pieceSize: Int
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 40 + CGFloat(10 * Double(pieceSize)), height: 45)
                .clipShape(.rect(cornerRadius: 10))
                .foregroundStyle(.red)
//            Rectangle()
//                .frame(width: 40, height: 40)
//                .clipShape(.rect(cornerRadius: 20))
//                .foregroundStyle(.white)
            Text("\(pieceSize)")
                .monospacedDigit()
                .bold()
                .font(.largeTitle)
                .shadow(color: .white, radius: 3, x: 1, y: 1)
        }
    }
}
