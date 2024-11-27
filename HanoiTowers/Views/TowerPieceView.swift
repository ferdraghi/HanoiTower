//
//  TowerPieceView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//

import SwiftUI

struct TowerPieceView: View {
    let pieceSize: Int
    let selected: Bool
    
    init(pieceSize: Int, selected: Bool = false) {
        self.pieceSize = pieceSize
        self.selected = selected
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 40 + CGFloat(10 * Double(pieceSize)), height: 45)
                //.clipShape(.rect(cornerRadius: 10))
                .foregroundStyle(.red)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: selected ? 2 : 0)
                }
                .shadow(color: .white, radius: selected ? 5 : 0)
            Text("\(pieceSize)")
                .monospacedDigit()
                .bold()
                .font(.largeTitle)
                .shadow(color: .white, radius: 3, x: 1, y: 1)
        }
    }
}

#Preview {
    VStack {
        TowerPieceView(pieceSize: 4)
        TowerPieceView(pieceSize: 4, selected: true)
    }
}
