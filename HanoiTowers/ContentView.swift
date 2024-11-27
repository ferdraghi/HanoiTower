//
//  ContentView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var startGame = false
    @State private var towerSize = 4
    let towerSizes = Array(4...10)
    var body: some View {
        VStack {
            GameTitleParallaxView()
                .padding(.top, 80)
            Spacer()
            TowerSizeSelectorView(towerSize: $towerSize)
                .padding([.leading, .trailing], 40)
            
            Spacer()
            
            PlayButtonView(startGame: $startGame)
                .padding(.bottom, 140)
        }
        .fullScreenCover(isPresented: $startGame) {
            GameplayScreen()
                .environmentObject(GameViewModel(towerSize: towerSize))
        }
        .onChange(of: towerSize) { _, _ in}
        .padding()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
