//
//  GameViewModel.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 26/11/2024.
//
import SwiftUI

enum GameViewModelState {
    case playing, failedMove, successfulMove, completed
}

@MainActor
class GameViewModel: ObservableObject {
    let towerSize: Int
    private(set) var towerViewModels: [GameTowerViewModel] = []
    private(set) var moves = 0
    private(set) var lastSuccessfulMove: Int?
    var perfectMoveCount: Int {
        Int(pow(2, Double(towerSize))) - 1
    }
    @Published var state: GameViewModelState = .playing

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
    
    init(towerSize: Int) {
        self.towerSize = towerSize
        self.towerViewModels = [GameTowerViewModel(numberOfPieces: towerSize), GameTowerViewModel(numberOfPieces: 0), GameTowerViewModel(numberOfPieces: 0)]
    }
    
    func piecesForTower(_ tower: Int) -> [TowerPiece] {
        guard tower >= 0, tower < towerViewModels.count else { return [] }
        return towerViewModels[tower].tower.pieces
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            
            let completed = self.towerViewModels[2].pieceCount == self.towerSize
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
