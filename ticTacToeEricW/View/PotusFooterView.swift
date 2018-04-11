
//
//  PotusFooterView.swift
//  ticTacToeEricW
//
//  Created by Macbook on 4/10/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//


import UIKit

class PotusFooterView: UICollectionReusableView
{
    
    @IBOutlet fileprivate weak var gamesPlayedLabel: UILabel!
    @IBOutlet fileprivate weak var wonByXLabel: UILabel!
    @IBOutlet fileprivate weak var wonByOLabel: UILabel!
    
    
    func updateStatsForGame(_ TournamentPlay: TournamentPlay)
    {
        gamesPlayedLabel.text = String(TournamentPlay.gamesPlayed)
        wonByXLabel.text = String(TournamentPlay.gamesWonByX)
        wonByOLabel.text = String(TournamentPlay.gamesWonByO)
    }
    
}
