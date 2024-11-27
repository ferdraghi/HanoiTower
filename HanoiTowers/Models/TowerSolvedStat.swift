//
//  TowerSolvedStat.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

struct TowerSolvedStat: Codable, Identifiable {
    var id: Int { size }
    var size: Int
    var solved: Bool
    var perfectlySolved: Bool
    var bestSolvedMoves: Int?
}
