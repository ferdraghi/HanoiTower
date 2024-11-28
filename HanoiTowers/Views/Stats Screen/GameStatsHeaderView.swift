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
                    .font(.system(size: 15, weight: .heavy, design: .rounded ))
                    .frame(width: 40, alignment: .center)
                Text("Completed")
                    .font(.system(size: 15, weight: .heavy, design: .rounded ))
                    .frame(width: 100, alignment: .center)
                Text("Perfect")
                    .font(.system(size: 15, weight: .heavy, design: .rounded ))
                    .frame(width: 80, alignment: .center)
                Text("Best Run")
                    .font(.system(size: 15, weight: .heavy, design: .rounded ))
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
