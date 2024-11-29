//
//  CompletedTextView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 28/11/2024.
//

import SwiftUI

struct CompletedTextView: View {
    @State private var explodingAnimation = false
    var body: some View {
        ZStack {
            RainbowTextView("Completed!", size: 60)
            RainbowTextView("Completed!", size: 60)
                .scaleEffect(explodingAnimation ? 10 : 1, anchor: .center)
                .opacity(explodingAnimation ? 0 : 1)
                .animation(.easeIn(duration: 1), value: explodingAnimation)
        }
        .onAppear() {
            explodingAnimation.toggle()
        }
    }
}

#Preview {
    CompletedTextView()
}
