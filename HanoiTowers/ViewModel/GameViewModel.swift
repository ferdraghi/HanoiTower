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

class GameViewModel: ObservableObject {
    let towerSize: Int
    var towers: [Tower]
    private(set) var moves = 0
    var perfectMoveCount: Int {
        Int(pow(2, Double(towerSize))) - 1
    }
    @Published var state: GameViewModelState = .playing

    @Published private(set) var selectedTower: Int? {
        didSet {
            guard let tower = selectedTower else {
                selectedPiece = nil
                return
            }
            
            selectedPiece = towers[tower].peekTopPiece()?.size
        }
    }
    @Published private(set) var selectedPiece: Int?
    
    init(towerSize: Int) {
        self.towerSize = towerSize
        self.towers = [Tower(), Tower(), Tower()]
        Array(0..<towerSize).map { TowerPiece(size: towerSize-$0) }.forEach { piece in
            self.towers[0].stack(piece)
        }
    }
    
    func selectedTower(_ number: Int) {
        guard
            number < towers.count,
            selectedTower != number
        else {
            selectedTower = nil
            return
        }
        
        if let selectedTower = selectedTower {
            let result = testMovePiece(from: towers[selectedTower], to: towers[number])
            if (result) {
                towers[number].stack(towers[selectedTower].topPiece()!)
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
            
            let completed = self.towers[2].pieces.count == self.towerSize
            state = completed ? .completed : .playing
        }
    }
    
    private func testMovePiece(from start: Tower, to target: Tower) -> Bool {
        guard let testPiece = start.peekTopPiece() else { return false }
        
        if (target.peekTopPiece()?.size ?? Int.max) > testPiece.size {
            return true
        }
        
        return false
    }
}
