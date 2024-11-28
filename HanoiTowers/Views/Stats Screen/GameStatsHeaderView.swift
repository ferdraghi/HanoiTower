//
//  GameStatsHeaderView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct GameStatsHeadersView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Size")
                    .font(.gameFont(size: 15))
                    .frame(width: 40, alignment: .center)
                Text("Completed")
                    .font(.gameFont(size: 15))
                    .frame(width: 100, alignment: .center)
                Text("Perfect")
                    .font(.gameFont(size: 15))
                    .frame(width: 80, alignment: .center)
                Text("Best Run")
                    .font(.gameFont(size: 15))
                    .frame(width: 80, alignment: .center)
            }
            Rectangle()
                .frame(height: 1)
        }
    }
}

#Preview {
    GameStatsHeadersView()
}
