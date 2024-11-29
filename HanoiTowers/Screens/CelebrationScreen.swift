//
//  CelebrationScreen.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 28/11/2024.
//

import SwiftUI

struct CelebrationScreen: View {
    let result: GameResult
    let buttonAction: () -> Void
    @State private var animating = false
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black.opacity(0.5))
            VStack(spacing: 20) {
                Spacer()
                CompletedTextView()
                    .frame(height: 80)
                PerfectTextView()
                    .frame(height: result.pefectlySolved ?? false ? 80 : 0)
                    .opacity(result.pefectlySolved ?? false ? 1 : 0)
                Spacer()
                ReturnButtonView { buttonAction() }
                    .opacity(animating ? 1 : 0)
                    .animation(.easeInOut(duration: 2).delay(2), value: animating)
                    .padding(.bottom, 60)
                    
            }
        }
        .onAppear() {
            animating.toggle()
        }
    }
}

#Preview {
    CelebrationScreen(result: .init(towerSize: 6, solved: true, solvedMoves: 6, pefectlySolved: true)) {}
}
