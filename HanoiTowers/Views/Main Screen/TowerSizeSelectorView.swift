//
//  TowerSizeSelectorView.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI


struct TowerSizeSelectorView: View {
    @Binding var towerSize: Int
    let towerSizes = Array(4...10)
    let solvedSizes: [Int]
    let perfectlySolvedSizes: [Int]
    var body: some View {
        HStack {
            Text("Tower Size:")
                .font(.title)
                .bold()
                .padding(.trailing, 20)
            
            Picker("Tower Size", selection: $towerSize) {
                ForEach(towerSizes, id:\.self) { size in
                    HStack {
                        Text("\(size)")
                            .font(.title)
                            .bold()
                            .tag(size)
                        Image(systemName: perfectlySolvedSizes.contains(size) ? "star.fill" : "checkmark")
                            .foregroundStyle(perfectlySolvedSizes.contains(size) ? .yellow :
                                                solvedSizes.contains(size) ? .green : .clear)
                    }
                }
            }
            .pickerStyle(.wheel)
            .contentShape(Rectangle())
        }
    }
}

#Preview {
    TowerSizeSelectorView(towerSize: .constant(4), solvedSizes: [4,5,6,7,8], perfectlySolvedSizes: [4, 5, 8])
}
