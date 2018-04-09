//
//  WinningDelegate.swift
//  ticTacToeEricW
//
//  Created by Macbook on 4/9/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//

import Foundation
protocol WinningDelegate: class {
    func computerPlayedPosition(_ position: Int)
    func player(_ player: Player, wonWithPositions positions: [Int])
    func gameInStalement()
}

class Winning
{
    
    var numberOfPositions: Int {
        return 9
    }
    weak var delegate: WinningDelegate?
    
    
    fileprivate var xBoard = 0
    fileprivate var oBoard = 0
    fileprivate let winningPositions: Dictionary<Int, [Int]> = [
        0x7: [0, 1, 2], // First Row winning pattern
        0x38: [3,4,5],  // Middle Row winning pattern
        0x1C0: [6,7,8], // Last Row winning pattern
        0x49:  [0, 3, 6], // First Column winning pattern
        0x92:  [1, 4, 7], // Second Column winning pattern
        0x124: [2, 5, 8], // Last Column winning pattern
        0x111: [0, 4, 8], // Left Diagonal winning pattern
        0x54:  [2, 4, 6], // Right Diagonal winning pattern
    ]
    var computerThinking = false
    
    
    
    
    
    
    func playPosition(_ position: Int, forPlayer player: Player)
    {
        guard position < numberOfPositions else { return }
        
        let toggleBit = 1 << position
        switch player {
        case .x:
            guard !computerThinking else { return }
            computerThinking = true
            xBoard = xBoard | toggleBit
            if isWinnerBoard(xBoard) {
                delegate?.player(.x, wonWithPositions: positionsOnWinningBoard(xBoard))
            }
            else if isWinnerBoard(oBoard) {
                delegate?.player(.o, wonWithPositions: positionsOnWinningBoard(oBoard))
            }
            else if nobodyCanWin() {
                delegate?.gameInStalement()
            }
            else {
                let nextPosition = nextMoveForPlayer2()
                delegate?.computerPlayedPosition(nextPosition)
                playPosition(nextPosition, forPlayer: .o)
            }
            computerThinking = false
            
        default:
            oBoard = oBoard | toggleBit
            if isWinnerBoard(oBoard) {
                delegate?.player(.o, wonWithPositions: positionsOnWinningBoard(oBoard))
            }
            else if nobodyCanWin() {
                delegate?.gameInStalement()
            }
        }
    }
    
    
    
    fileprivate func nobodyCanWin() -> Bool {
        return ((xBoard | oBoard) == 0x1FF)
    }
    
    
    
    fileprivate func winningCells() -> [Int] {
        if isWinnerBoard(xBoard) {
            return positionsOnWinningBoard(xBoard)
        }
        else {
            return positionsOnWinningBoard(oBoard)
        }
    }
    
    
    
    
    
    fileprivate func nextMoveForPlayer2() -> Int {
        var position = 0
        var nextWinningPositionForPlayer1 = -1
        var nextWinningPositionForPlayer2 = -1
        
        for i in 0..<numberOfPositions { // Take or block next winning move
            if availablePosition(i) {
                if winsBoard(oBoard, withPosition: i) {
                    nextWinningPositionForPlayer2 = i
                    break    // Found a winning position for player 2, stop searching and take it
                }
                else if winsBoard(xBoard, withPosition: i) {
                    nextWinningPositionForPlayer1 = i  // player 1's potential winning position that can be blocked
                }
            }
        }
        
        if nextWinningPositionForPlayer2 > -1 {
            position = nextWinningPositionForPlayer2
        }
        else if nextWinningPositionForPlayer1 > -1 {
            position = nextWinningPositionForPlayer1
        }
        else if availablePosition(4) {
            position = 4
        }
        else if (xBoard == 0x44) || (xBoard == 0xC) {
            position = 1
        }
        else if ( ((xBoard == 0x42) || (xBoard == 0x108) || (xBoard == 0x102)) && availablePosition(0) )  {
            position = 0
        }
        else if ( ((xBoard == 0xC0) || (xBoard == 0x24) || (xBoard == 0xA4)) && availablePosition(8) )  {
            position = 8
        }
        else {
            position = randomComputerMove()
        }
        return position
    }
    
    
    
    
    fileprivate func availablePosition(_ position: Int) -> Bool
    {
        let checkBit = 1 << position
        return ((xBoard & checkBit) == 0) && ((oBoard & checkBit) == 0)
    }
    
    
    fileprivate func isWinnerBoard(_ board: Int) -> Bool
    {
        let winnings = (winningPositions.keys).filter{$0 & board == $0}
        return winnings.count > 0
    }
    
    
    fileprivate func positionsOnWinningBoard(_ board: Int) -> [Int]
    {
        let winnings = (winningPositions.keys).filter{$0 & board == $0}
        if let keyValue = winnings.first, let positions = winningPositions[keyValue] {
            return positions
        }
        
        return []
    }
    
    
    fileprivate func winsBoard(_ initialBoard: Int, withPosition position: Int) -> Bool
    {
        let checkBit = 1 << position
        let board = initialBoard | checkBit
        return isWinnerBoard(board)
    }
    
    
    
    fileprivate func randomComputerMove() -> Int
    {
        var position = 0
        
        repeat {
            position = Int(arc4random_uniform(UInt32(numberOfPositions-1)))
        } while !availablePosition(position)
        
        return position
    }
    
}
