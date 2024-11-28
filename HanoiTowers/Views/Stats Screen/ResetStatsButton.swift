//
//  ResetStatsButton.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//
import SwiftUI

struct ResetStatsButton: View {
    @Binding var resetStats: Bool
    @State private var animating = false
    var body: some View {
        VStack {
            Button {
                resetStats.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.red)
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(color: .red, radius: animating ? 25 : 5)
                    Text("Reset stats")
                        .foregroundStyle(.white)
                        .font(.gameFont)
                        .bold()
                        .shadow(color: .red, radius: animating ? 5 : 0)
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
    ResetStatsButton(resetStats: .constant(false))
}
