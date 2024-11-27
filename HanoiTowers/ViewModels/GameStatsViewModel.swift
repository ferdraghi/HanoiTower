//
//  GameStats.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

@MainActor
class GameStatsViewModel: ObservableObject {
    @Published private(set) var stats = [TowerSolvedStat]()

    private let smallestSize: Int
    private let biggestSize: Int
    private var savePath: URL {
        FileManager.documentsDirectory.appendingPathComponent("gameStats.json")
    }
    
    init(smallestSize: Int = 4, biggestSize: Int = 10) {
        self.smallestSize = smallestSize
        self.biggestSize = biggestSize
        loadStats()
    }
    
    var sizesSolved: [Int] {
        let solved = stats.filter { $0.solved }
        return solved.map { $0.size }
    }
    
    var sizesPerfectlySolved: [Int] {
        let perfectSolves = stats.filter { $0.perfectlySolved }
        return perfectSolves.map { $0.size }
    }
    
    func endedGameWithResult(_ result: GameResult) {
        if let currentStatIndex = stats.firstIndex(where: { $0.size == result.towerSize }) {
            let currentStat = stats[currentStatIndex]
            if result.solved {
                guard let solvedMoves = result.solvedMoves,
                      let perfectSolve = result.pefectlySolved
                else {
                    print("missing solvedMoves and/or perfectSolve on resolved result")
                    return
                }
                stats[currentStatIndex].solved = true
                stats[currentStatIndex].perfectlySolved = currentStat.perfectlySolved || perfectSolve
                stats[currentStatIndex].bestSolvedMoves = min(currentStat.bestSolvedMoves ?? Int.max, solvedMoves)
            }
        } else {
            let newStat = TowerSolvedStat(size: result.towerSize, solved: result.solved, perfectlySolved: result.pefectlySolved ?? false, bestSolvedMoves: result.solvedMoves)
            stats.append(newStat)
        }

        saveStats()
    }
    
    private func loadStats() {
        do {
            let data = try Data(contentsOf: savePath)
            stats = try JSONDecoder().decode([TowerSolvedStat].self, from: data)
        } catch {
            print("Failed to load stats: \(error)")
            initializeNewStats()
        }
    }
    
    private func saveStats() {
        do {
            let data = try JSONEncoder().encode(stats)
            try data.write(to: savePath)
        } catch {
            print("Failed to save data: \(error)")
        }
    }
    
    private func initializeNewStats() {
        stats = Array(4...10).map { TowerSolvedStat(size: $0, solved: false, perfectlySolved: false, bestSolvedMoves: nil) }
        saveStats()
    }
}
