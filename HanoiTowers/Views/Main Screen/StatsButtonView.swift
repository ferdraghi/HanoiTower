//
//  StatsButtonView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

struct StatsButtonView: View {
    @Binding var showStats: Bool
    @State private var animating = false
    var body: some View {
        VStack {
            Button {
                showStats.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.purple)
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(color: .purple, radius: animating ? 14 : 5)
                    Text("STATS")
                        .foregroundStyle(.white.opacity(0.8))
                        .font(.gameFont(size: 20))
                        .bold()
                        .shadow(color: .gray, radius: animating ? 5 : 0)
                }
                .animation(.easeInOut(duration: 2).repeatForever(), value: animating)
            }
            .frame(width: 120, height: 40)
        }
        .onAppear() {
            animating.toggle()
        }
    }
}

#Preview {
    StatsButtonView(showStats: .constant(true))
}
