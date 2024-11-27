//
//  PlayButton.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct PlayButtonView: View {
    @Binding var startGame: Bool
    @State private var animating = false
    var body: some View {
        VStack {
            Button {
                startGame.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.mint)
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(color: .gray, radius: animating ? 25 : 5)
                    Text("PLAY!")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                        .shadow(color: .gray, radius: animating ? 5 : 0)
                }
                .animation(.easeInOut(duration: 2).repeatForever(), value: animating)
            }
            .frame(width: 200, height: 40)
        }
        .onAppear() {
            animating.toggle()
        }
    }
}

#Preview {
    PlayButtonView(startGame: .constant(false))
}
