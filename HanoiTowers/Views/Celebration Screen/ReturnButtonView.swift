//
//  ReturnButtonView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 29/11/2024.
//

import SwiftUI

struct ReturnButtonView: View {
    let buttonAction: () -> Void
    @State private var animating = false
    var body: some View {
        VStack {
            Button {
                buttonAction()
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.mint)
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(color: .mint, radius: animating ? 25 : 5)
                    Text("MAIN MENU")
                        .foregroundStyle(.white)
                        .font(.gameFont)
                        .bold()
                        .shadow(color: .white, radius: animating ? 5 : 0)
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
    ReturnButtonView {}
}
