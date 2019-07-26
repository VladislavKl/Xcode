//
//  ViewController.swift
//  MatchCards
//
//  Created by Klyuev Vladislav on 31/03/2019.
//  Copyright © 2019 Klyuev Vladislav. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var model = CardModel()
    var cardArray = [Card]()

    var firstFlippedCardIndex: IndexPath?
    
    var timer: Timer?
    var milliseconds: Float = 60 * 1000 //30 seconds
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the getCards method of the CardModel
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }
    
    @objc func timerElapsed(){
        milliseconds -= 1
        
        //Convert to seconds
        
        let seconds = String(format: "%.2f", milliseconds/1000)
        //Set label
        timerLabel.text = "Time Remaining: \(seconds)"
        
        if milliseconds <= 0 {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            //Check if there are any cards unmatched
            checkGameEnded()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        //Get a CardCollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //Get the card that the CollectionView is trying to
        let card = cardArray[indexPath.row]
        cell.setCard(card)
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if milliseconds <= 0 {
            return
        }
        
        //Get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //Get the card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            cell.flip()
            card.isFlipped = true
            SoundManager.playSound(.flip)
            //Determine if it is the first or the second card that's flipped over
            
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else{
                //This is the second card being flipped
                //TODO: perform the matching logic
                checkForMatches(indexPath)
            }
        }
        
        
    }// End the didSelectItemAt method
    
    //MARK: -Game Logic Methods
    
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName {
            //It's a match
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6, execute:{
                SoundManager.playSound(.match)
            })
            //Check if there are any cards left unmatched
            checkGameEnded()
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute:{
                SoundManager.playSound(.nomatch)
            })
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        //Tell the collectionView to reload the cell of the first card if it is nil
        if cardOneCell == nil{
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        //We set the property that tracks the first cardFlipped
        firstFlippedCardIndex = nil
    }
    
    func checkGameEnded() {
        var isWon = true
        
        for card in cardArray{
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        
        //Messaginf variables
        var title = ""
        var message = ""
        if isWon {
            if milliseconds > 0{
                timer?.invalidate()
            }
            
            title = "Congratulations"
            message = "You have won!"
        }
        else {
            
            if milliseconds > 0{
                return
            }
            
            title = "Game over"
            message = "You have lost!"
        }
       
        showAlert(title, message)
    }
    
    func showAlert(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert,animated: true, completion: nil)
    }
    
} //End ViewContoller class

