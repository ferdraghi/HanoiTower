//
//  GameTitleView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct GameTitleView: View {
    @State private var shiftColors = false
    var body: some View {
        VStack {
            LinearGradient(
                colors: [.red, .blue, .green, .yellow],
                startPoint: .leading,
                endPoint: .trailing
            )
            .mask {
                Text("Hanoi Towers")
                    .font(.system(size: 80, weight: .heavy, design: .rounded ))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .hueRotation(.degrees(shiftColors ? 720 : 0))
            .animation(.linear(duration: 2).repeatForever(autoreverses: true), value: shiftColors)
            .frame(height: 80)
        }
        .onAppear() {
            shiftColors.toggle()
        }

    }
}

#Preview {
    GameTitleView()
}
