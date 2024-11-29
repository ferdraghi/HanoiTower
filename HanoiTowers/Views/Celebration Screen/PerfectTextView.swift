//
//  PerfectTextView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 28/11/2024.
//

import SwiftUI

struct PerfectTextView: View {
    @State var animating = false
    var body: some View {
        VStack {
            RadialGradient(
                colors: [.yellow, .white, .yellow],
                center: .center,
                startRadius: animating ? 200 : 0,
                endRadius: animating ? 60 : 400
            )
            .animation(.linear(duration: 3).repeatForever(), value: animating)
            .mask{
                HStack {
                    Image(systemName: "star.fill")
                        .font(.gameFont(size: 40))
                    Text("PERFECT")
                        .font(.gameFont(size: 40))
                    Image(systemName: "star.fill")
                        .font(.gameFont(size: 40))
                }
                .shadow(color: .white, radius: animating ? 6 : 0)
                .animation(.easeInOut(duration: 3).repeatForever(), value: animating)
            }
        }
        .scaleEffect(animating ? 1 : 0)
        .animation(.easeInOut(duration: 1).delay(1), value: animating)
        .onAppear() {
            animating.toggle()
        }
    }
}

#Preview {
    PerfectTextView()
}
