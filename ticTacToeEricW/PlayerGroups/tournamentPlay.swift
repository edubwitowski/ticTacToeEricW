//
//  tournamentPlay.swift
//  ticTacToeEricW
//
//  Created by Macbook on 4/2/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//

import Foundation

class TournamentPlay {
    var gamesPlayed = 0
    var gamesWonByX = 0
    var gamesWonByO = 0
    
    var game = TicTacToePotus()
    
    func newGame() {
        game = TicTacToePotus()
    }
}
