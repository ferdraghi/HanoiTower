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
    var body: some View {
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
    }
}

#Preview {
    TowerSizeSelectorView(towerSize: .constant(4))
}
