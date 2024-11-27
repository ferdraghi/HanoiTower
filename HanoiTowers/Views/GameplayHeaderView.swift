//
//  GameplayHeaderView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct GameplayHeaderView: View {
    let currentMoves: Int
    let perfectMoveCount: Int
    let buttonAction: () -> Void
    var body: some View {
        HStack {
            Text("Moves: \(currentMoves)")
                .font(.largeTitle)
                .monospacedDigit()
                .padding(.leading, 30)
            Spacer()
            Button {
                buttonAction()
            } label: {
                Image(systemName: "xmark.square.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .foregroundStyle(.red.opacity(0.8))
            }
            .padding()
        }
        HStack {
            Text("Perfect Moves: \(perfectMoveCount)")
                .font(.headline)
                .monospacedDigit()
                .padding(.leading, 30)
            Spacer()
        }
    }
}

#Preview {
    GameplayHeaderView(currentMoves: 0, perfectMoveCount: 15) {
        print("Pressed Button")
    }
}
