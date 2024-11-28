//
//  GameStatsRowView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct GameStatsRowView: View {
    let stat: TowerSolvedStat
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(stat.size)")
                    .font(.system(size: 15, weight: .heavy, design: .rounded ))
                    .frame(width: 40, alignment: .center)
                Image(systemName: stat.solved ? "checkmark" : "xmark")
                    .foregroundStyle(stat.solved ? .green : .red)
                    .font(.system(size: 20, weight: .heavy, design: .rounded ))
                    .frame(width: 100, alignment: .center)
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                    .font(.system(size: 20, weight: .heavy, design: .rounded ))
                    .opacity(stat.perfectlySolved ? 1.0 : 0)
                    .frame(width: 80, alignment: .center)
                Text("\(stat.bestSolvedMoves ?? 0)")
                    .font(.system(size: 15, weight: .heavy, design: .rounded ))
                    .opacity(stat.solved ? 1.0 : 0)
                    .frame(width: 80, alignment: .center)
            }
            Rectangle()
                .frame(height: 1)
                .opacity(0.5)
        }
    }
}

#Preview {
    GameStatsRowView(stat: .init(size: 4, solved: true, perfectlySolved: true, bestSolvedMoves: 15))
    GameStatsRowView(stat: .init(size: 5, solved: true, perfectlySolved: false, bestSolvedMoves: 40))
    GameStatsRowView(stat: .init(size: 6, solved: false, perfectlySolved: false, bestSolvedMoves: 15))
}
