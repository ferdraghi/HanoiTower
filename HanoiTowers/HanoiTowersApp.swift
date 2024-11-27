//
//  HanoiTowersApp.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//

import SwiftUI

@main
struct HanoiTowersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GameStatsViewModel())
        }
    }
}
