//
//  File.swift
//  ticTacToeEricW
//
//  Created by Macbook on 1/30/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//

import Foundation
class Tournament {
    var gamesPlayed = 0
    var gamesWonByX = 0
    var gamesWonByO = 0
    
    var game = TicTacToe()
    
    func newGame() {
        game = TicTacToe()
    }
}
