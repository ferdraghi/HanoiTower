//
//  PlayButton.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct PlayButtonView: View {
    @Binding var startGame: Bool
    var body: some View {
        VStack {
            Button {
                startGame.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.mint)
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(color: .gray, radius: 15)
                    Text("PLAY!")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                        .shadow(color: .gray, radius: 5)
                }
            }
            .frame(width: 200, height: 40)
        }
    }
}

#Preview {
    PlayButtonView(startGame: .constant(false))
}
