//
//  ContentView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var towerSize = 4
    @State private var startGame = false
    let towerSizes = Array(4...10)
    var body: some View {
        VStack {
            Text("Hanoi Towers")
                .font(.largeTitle)
                .bold()
                .padding(.top, 80)
            
            HStack {
                Text("Tower Size:")
                    .font(.title)
                    .bold()
                    .padding(.trailing, 20)
                
                Picker("Tower Size", selection: $towerSize) {
                    ForEach(towerSizes, id:\.self) { size in
                        Text("\(size)")
                            .font(.title)
                            .bold()
                            .tag(size)
                    }
                }
                .pickerStyle(.wheel)
                .contentShape(Rectangle())
            }
            .padding([.leading, .trailing], 40)
            .padding(.top, 100)
            Spacer()
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
                .frame(width: 200, height: 40)
                .padding(.bottom, 140)
                
            }
        }
        .fullScreenCover(isPresented: $startGame, content: {
            GameplayScreen()
                .environmentObject(GameViewModel(towerSize: Int(towerSize)))
        })
        .padding()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
