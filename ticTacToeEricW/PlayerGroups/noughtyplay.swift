//
//  noughtyplay.swift
//  ticTacToeEricW
//
//  Created by Macbook on 4/2/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//
//
 

//Abstract:
 //Contains the TicTacToe game model that implements an almost exact solution of Tic Tac Toe with a touch of randomness that allows the human player (player 1) to win with some moves.

   //Although there is an exact solution to Tic Tac Toe that guarantees that the computer never looses,
    //this solution has an element of randomnes where the human player can win on some occassions.
 
 //This implementation uses two bitmaps to represent the state of the game board. One bitmap marks the positions played by X (Player 1) in the game, while the other bitmap contains the positions played by O (player 2). When a player plays a position, the bit position played is toggled to 1 for that player's board bitmap after checking that the position is still available. At any point during the game, the two bitmaps can be bitwise or'ed to determine all occupied (or available) positions in the game. Also, checking for wins is easy; winnings can be determined by bitwise and'ing a given player's bitmap with well known winning bit patterns stored in a dictionary.

//A bitmap is a type of memory organization or image file format used to store digital images. The term bitmap comes from the computer programming terminology, meaning just a map of bits, a spatially mapped array of bits. Now, along with pixmap, it commonly refers to the similar concept of a spatially mapped array of pixels. Raster images in general may be referred to as bitmaps or pixmaps, whether synthetic or photographic, in files or memory.
