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
    private let usingSampleData: Bool
    private var savePath: URL {
        FileManager.documentsDirectory.appendingPathComponent("gameStats.json")
    }
    
    init(smallestSize: Int = 4, biggestSize: Int = 10, useSampleData: Bool = false) {
        self.smallestSize = smallestSize
        self.biggestSize = biggestSize
        self.usingSampleData = useSampleData
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
    
    func resetAllStats() {
        stats = []
        initializeNewStats()
    }
    
    private func loadStats() {
        guard !usingSampleData else {
            loadSampleData()
            return
        }
        do {
            let data = try Data(contentsOf: savePath)
            stats = try JSONDecoder().decode([TowerSolvedStat].self, from: data)
        } catch {
            print("Failed to load stats: \(error)")
            initializeNewStats()
        }
    }
    
    private func saveStats() {
        guard !usingSampleData else {
            return
        }
        do {
            let data = try JSONEncoder().encode(stats)
            try data.write(to: savePath)
        } catch {
            print("Failed to save data: \(error)")
        }
    }
    
    private func initializeNewStats() {
        guard !usingSampleData else {
            return
        }
        stats = Array(4...10).map { TowerSolvedStat(size: $0, solved: false, perfectlySolved: false, bestSolvedMoves: nil) }
        saveStats()
    }
    
    private func loadSampleData() {
        stats = [
            .init(size: 4, solved: true, perfectlySolved: true, bestSolvedMoves: 15),
            .init(size: 5, solved: true, perfectlySolved: true, bestSolvedMoves: 31),
            .init(size: 6, solved: true, perfectlySolved: true, bestSolvedMoves: 63),
            .init(size: 7, solved: true, perfectlySolved: false, bestSolvedMoves: 154),
            .init(size: 8, solved: true, perfectlySolved: false, bestSolvedMoves: 387),
            .init(size: 9, solved: false, perfectlySolved: false, bestSolvedMoves: nil),
            .init(size: 10, solved: false, perfectlySolved: false, bestSolvedMoves: nil)
        ]
    }
}
