//
//  GameViewModel.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//
import SwiftUI

enum GameViewModelState {
    case idle, playing, failedMove, successfulMove, completed
}

@MainActor
class GameViewModel: ObservableObject {
    var towerSize: Int = 0
    var towerCount: Int = 0
    private(set) var towerViewModels: [GameTowerViewModel] = []
    private(set) var moves = 0
    private(set) var lastSuccessfulMove: Int?
    var perfectMoveCount: Int {
        Int(pow(2, Double(towerSize))) - 1
    }
    @Published var state: GameViewModelState = .idle

    @Published private(set) var selectedTower: Int? {
        willSet {
            guard let tower = newValue else {
                if let current = selectedTower {
                    towerViewModels[current].selected = false
                }
                return
            }
            towerViewModels[tower].selected = true
        }
    }
    
    func prepareGameWithWoterSize(_ size: Int, towerCount: Int = 3) {
        state = .idle
        towerSize = size
        self.towerCount = towerCount
        towerViewModels = []
        moves = 0
        lastSuccessfulMove = nil
        (0..<towerCount).forEach { index in
            self.towerViewModels.append(GameTowerViewModel(numberOfPieces: index == 0 ? towerSize : 0))
        }
    }
    
    func gameBegin() {
        state = .playing
    }
    
    func piecesForTower(_ tower: Int) -> [TowerPiece] {
        guard tower >= 0, tower < towerViewModels.count else { return [] }
        return towerViewModels[tower].pieces
    }
    
    func selectTower(_ number: Int) {
        guard
            number < towerViewModels.count,
            selectedTower != number
        else {
            selectedTower = nil
            return
        }
        
        if let selectedTower = selectedTower {
            let result = testMovePiece(from: towerViewModels[selectedTower], to: towerViewModels[number])
            if (result) {
                lastSuccessfulMove = number
                towerViewModels[number].getTopPieceFrom(towerViewModels[selectedTower])
                moves += 1
            }
            updateStateWithMoveResult(result)
        } else {
            selectedTower = number
        }
    }
    
    private func updateStateWithMoveResult(_ result: Bool) {
        state = result ? .successfulMove : .failedMove
        selectedTower = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
            guard let self = self else { return }
            
            let completed = self.towerViewModels.last?.pieceCount == self.towerSize
            state = completed ? .completed : .playing
        }
    }
    
    private func testMovePiece(from start: GameTowerViewModel, to target: GameTowerViewModel) -> Bool {
        guard let testPieceSize = start.topPieceSize else { return false }
        
        if (target.topPieceSize ?? Int.max) > testPieceSize {
            return true
        }
        
        return false
    }
}
