//
//  GameTitleView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct ParallaxImageStackAxis {
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
}

struct GameTitleParallaxView: View {
    @State private var animating: Bool = false
    private var animatingAngleDegrees: (Double, Double) = (20, -20)
    private var animatingAxis: (ParallaxImageStackAxis, ParallaxImageStackAxis) = (
        .init(x: -90, y: -45, z: -30),
        .init(x: -45, y: -90, z: -85))
    private let title = "Hanoi Towers"
    var body: some View {
        ZStack {
            ForEach(1..<6) { i in
                RainbowTextView(title, size: 150)
                    .opacity(0.33 * (1.0 / CGFloat(i)))
                    .rotation3DEffect(.degrees(animating ? animatingAngleDegrees.0 : animatingAngleDegrees.1),
                                      axis: (x: animating ? animatingAxis.0.x : animatingAxis.1.x,
                                             y: animating ? animatingAxis.0.y : animatingAxis.1.y,
                                             z: animating ? animatingAxis.0.z : animatingAxis.1.z),
                                      anchorZ: 50 + CGFloat((30 * i)))
                    .animation(.easeInOut(duration: 20).repeatForever(), value: animating)
            }
            RainbowTextView(title, size: 150)
                .rotation3DEffect(.degrees(animating ? animatingAngleDegrees.0 : animatingAngleDegrees.1),
                                  axis: (x: animating ? animatingAxis.0.x : animatingAxis.1.x,
                                         y: animating ? animatingAxis.0.y : animatingAxis.1.y,
                                         z: animating ? animatingAxis.0.z : animatingAxis.1.z),
                                  anchorZ: 50)
                .animation(.easeInOut(duration: 20).repeatForever(), value: animating)
            ForEach(1..<6) { i in
                RainbowTextView(title, size: 150)
                    .opacity(0.33 * (1.0 / CGFloat(i)))
                    .rotation3DEffect(.degrees(animating ? animatingAngleDegrees.0 : animatingAngleDegrees.1),
                                      axis: (x: animating ? animatingAxis.0.x : animatingAxis.1.x,
                                             y: animating ? animatingAxis.0.y : animatingAxis.1.y,
                                             z: animating ? animatingAxis.0.z : animatingAxis.1.z),
                                      anchorZ: 50 - CGFloat((30 * i)))
            }
            .animation(.easeInOut(duration: 20).repeatForever(), value: animating)
        }
        .frame(height: 200)
        .onAppear() {
            animating.toggle()
        }
    }
}

#Preview {
    GameTitleParallaxView()
}
