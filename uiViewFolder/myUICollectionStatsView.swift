//
//  myUICollectionStatsView.swift
//  ticTacToeEricW
//
//  Created by Macbook on 4/9/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//

import UIKit

class myUICollectionStatsView: UICollectionReusableView
{
    
    @IBOutlet fileprivate weak var gamesPlayedLabel: UILabel!
    
    
    @IBOutlet fileprivate weak var wonByXLabel: UILabel!
    @IBOutlet fileprivate weak var wonByOLabel: UILabel!
    
    
    func updateStatsForGame(_ tournament: Tournament)
    {
        gamesPlayedLabel.text = String(tournament.gamesPlayed)
        wonByXLabel.text = String(tournament.gamesWonByX)
        wonByOLabel.text = String(tournament.gamesWonByO)
    }
    
}
