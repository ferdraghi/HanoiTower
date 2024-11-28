//
//  GameStatsTableView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct GameStatsTableView: View {
    @EnvironmentObject var gameStats: GameStatsViewModel
    var body: some View {
        VStack(alignment: .leading) {
            GameStatsHeadersView()
                .frame(height: 80)
                .padding(.bottom, -20)
            ForEach(gameStats.stats) { stat in
                GameStatsRowView(stat: stat)
                    .frame(height: 40)
            }
        }
    }
}

#Preview {
    GameStatsTableView()
        .environmentObject(GameStatsViewModel(useSampleData: true))
}
