//
//  PotusViewCell.swift
//  ticTacToeEricW
//
//  Created by Macbook on 4/11/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//


//
//  Created by Macbook on 4/4/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//

import UIKit


class PotusViewCell: UICollectionViewCell {
    
    //MARK: Public vars
    
    var check: Player? = nil {
        didSet {
            checkView?.check = check
            setNeedsDisplay()
        }
    }
    var checked: Bool {
        return check != .none
    }
    
    var isInWinningPath = false {
        didSet {
            if isInWinningPath {
                self.alpha = 0.65
            }
            else {
                self.alpha = 1.0
            }
        }
    }
    
    //MARK: Private vars
    
    @IBOutlet weak fileprivate var checkView: CheckView! {
        didSet {
            checkView.check = check
        }
    }
    
    
    //MARK: Public func
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor.white
    }
    
    
    
    
    //MARK: Private func
    
    
}
