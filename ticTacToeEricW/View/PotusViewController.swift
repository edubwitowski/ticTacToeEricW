//
//  PotusViewController.swift
//  ticTacToeEricW
//
//  Created by Macbook on 4/9/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//

import UIKit


class potusViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, TicTacToePotusDelegate
{
    
    //MARK: Private var
    fileprivate struct StoryBoard
    {
        static let cellReuseIdentifier = "NaughtyCell"
        static let footerReuseIdentifier = "PotusFooter"
        static let navBarSpacing = CGFloat(64.0)
        static let cellsPerRow = 3
    }
    fileprivate struct AlertMessage
    {
        static let youWin = "Congratulations! You won."
        static let youLoose = "Your opponent won."
        static let nobodyWins = "This game ended in a stalemate."
        static let title = "Game over!"
        static let ok = "Ok"
    }
    fileprivate let tournamentPlay = TournamentPlay()
    var gameOver = false
    fileprivate weak var potusFooter: PotusViewCell!
    
    
    //MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tournamentPlay.game.delegate = self
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 40.0/255.0, green: 140.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        let titleDict: [String : AnyObject] = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleDict
        /// make modal segues for viewcontrollers that have clear / see-through backgrounds work
        self.modalPresentationStyle = .overFullScreen
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    
    //MARK: - Actions
    
    
    @IBAction func pressedResetButton(_ sender: UIButton)
    {
        for i in 0..<tournamentPlay.game.numberOfPositions {
            let path = IndexPath(item: i, section: 0)
            if let cell = collectionView?.cellForItem(at: path) as? PotusViewCell {
                cell.check = nil
                cell.isInWinningPath = false
            }
        }
        tournamentPlay.newGame()
        tournamentPlay.game.delegate = self
        gameOver = false
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tournamentPlay.game.numberOfPositions
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        var reuseView = UICollectionReusableView()
        if kind == UICollectionElementKindSectionFooter {
            potusFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: StoryBoard.footerReuseIdentifier, for: indexPath) as! PotusFooterView
            reuseView = potusFooterView
        }
        
        return reuseView
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.cellReuseIdentifier, for: indexPath) as! PotusViewCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !gameOver else { return }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PotusViewCell {
            guard !cell.checked else { return }
            
            cell.check = .x
            tournamentPlay.game.playPosition(indexPath.item, forPlayer: .x)
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    /// Return a CGSize for the collectionView footer view based on available space (i.e., space not taken up by the cells)
    /// in the collectionView.
    /// - returns CGSize
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let availableWidth = (collectionView.bounds.width - 2.0*(layout.minimumInteritemSpacing + layout.sectionInset.left + layout.sectionInset.right))
        let availableHeight = collectionView.bounds.height - (2.0*layout.minimumLineSpacing + layout.sectionInset.top + layout.sectionInset.bottom + availableWidth + StoryBoard.navBarSpacing)
        return CGSize(width: availableWidth, height: availableHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let availableWidth = (collectionView.bounds.width - 2.0*(layout.minimumInteritemSpacing + layout.sectionInset.left + layout.sectionInset.right))
        return CGSize(width: availableWidth/CGFloat(StoryBoard.cellsPerRow), height: availableWidth/CGFloat(StoryBoard.cellsPerRow))
    }
    
    
    //MARK: - PotusViewCellDelegate
    
    func computerPlayedPosition(_ position: Int) {
        let cellPath = IndexPath(item: position, section: 0)
        if let cell = collectionView?.cellForItem(at: cellPath) as? PotusViewCell{
            cell.check = .o
        }
    }
    
    func player(_ player: Player, wonWithPositions positions: [Int]) {
        var message: String = ""
        switch player {
        case .x:
            tournamentPlay.gamesWonByX += 1
            message = AlertMessage.youWin
        default:
            tournamentPlay.gamesWonByO += 1
            message = AlertMessage.youLoose
        }
        tournamentPlay.gamesPlayed += 1
        gameOver = true
        potusFooterView.updateStatsForGame(tournamentPlay)
        showAlertMessage(message)
        for position in positions {
            let indexPath = IndexPath(item: position, section: 0)
            if let cell = collectionView?.cellForItem(at: indexPath) as? PotusViewCell {
                cell.isInWinningPath = true
            }
        }
    }
    
    func gameInStalement() {
        tournamentPlay.gamesPlayed += 1
        gameOver = true
        potusFooterView.updateStatsForGame(tournamentPlay)
        showAlertMessage(AlertMessage.nobodyWins)
    }
    
    
    
    //MARK: - Private
    
    
    fileprivate func showAlertMessage(_ message: String)
    {
        let alert = UIAlertController(
            title: AlertMessage.title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        
        alert.addAction(UIAlertAction(title: AlertMessage.ok,
                                      style: UIAlertActionStyle.cancel,
                                      handler: { (action) in
                                        
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
