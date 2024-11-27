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
                    .font(.system(size: 50, weight: .heavy, design: .rounded ))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .shadow(color: .white, radius: 5)
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

struct ParallaxImageStackAxis {
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
}

struct GameTitleParallaxView: View {
    @State private var animating: Bool = false
    private var animatingAngleDegrees: (Double, Double) = (13, -13)
    private var animatingAxis: (ParallaxImageStackAxis, ParallaxImageStackAxis) = (
        .init(x: -90, y: -45, z: -30),
        .init(x: -45, y: -90, z: -85))
    var body: some View {
        ZStack {
            GameTitleView()
                .rotation3DEffect(.degrees(animating ? animatingAngleDegrees.0 : animatingAngleDegrees.1),
                                  axis: (x: animating ? animatingAxis.0.x : animatingAxis.1.x,
                                         y: animating ? animatingAxis.0.y : animatingAxis.1.y,
                                         z: animating ? animatingAxis.0.z : animatingAxis.1.z),
                                  anchorZ: 50)
            ForEach(1..<4) { i in
                GameTitleView()
                    .opacity(0.25)
                    .rotation3DEffect(.degrees(animating ? animatingAngleDegrees.0 : animatingAngleDegrees.1),
                                      axis: (x: animating ? animatingAxis.0.x : animatingAxis.1.x,
                                             y: animating ? animatingAxis.0.y : animatingAxis.1.y,
                                             z: animating ? animatingAxis.0.z : animatingAxis.1.z),
                                      anchorZ: 50 - CGFloat((30 * i)))
            }
        }
        .animation(.easeInOut(duration: 3.5).repeatForever(), value: animating)
        .onAppear() {
            animating.toggle()
        }
    }
}

#Preview {
    GameTitleParallaxView()
}
