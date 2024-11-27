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
                .frame(width: 40 * CGFloat(1 + (0.166 * Double(pieceSize - 1))) , height: 25)
                .foregroundStyle(.red)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: selected ? 2 : 0)
                }
                .shadow(color: .white, radius: selected ? 5 : 0)
            Text("\(pieceSize)")
                .monospacedDigit()
                .bold()
                .font(.title2)
                .shadow(color: .white, radius: 3, x: 1, y: 1)
        }
    }
}

#Preview {
    HStack(spacing: 40) {
        VStack {
            ForEach(1..<11) { index in
                TowerPieceView(pieceSize: index)
            }
        }
        VStack {
            ForEach(1..<11) { index in
                TowerPieceView(pieceSize: index, selected: true)
            }
        }
    }
}
