//
//  GameTitleView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct GameTitleView: View {
    var body: some View {
        Text("Hanoi Towers")
            .font(.system(size: 80, weight: .heavy, design: .rounded ))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            //font(.largeTitle)
            //.bold()
    }
}

#Preview {
    GameTitleView()
}
