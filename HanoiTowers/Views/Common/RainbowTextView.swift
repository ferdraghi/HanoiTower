//
//  RainbowTextView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 28/11/2024.
//

import SwiftUI

struct RainbowTextView: View {
    let text: String
    let size: CGFloat
    @State private var shiftColors = false
    
    init(_ text: String, size: CGFloat) {
        self.text = text
        self.size = size
    }
    
    var body: some View {
        GeometryReader { g in
            VStack {
                LinearGradient(
                    colors: [.red, .blue, .green, .yellow],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask {
                    Text(text)
                        .font(.gameFont(size: size))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                        .shadow(color: .white, radius: 5)
                }
                .frame(width: g.size.width, height: 200)
            }
            .hueRotation(.degrees(shiftColors ? 720 : 360))
            .animation(.linear(duration: 2).repeatForever(autoreverses: true), value: shiftColors)
        }
        .onAppear() {
            shiftColors.toggle()
        }

    }
}

#Preview {
    RainbowTextView("Hanoi Towers", size: 60)
}
