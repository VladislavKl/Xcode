//
//  CardCollectionViewCell.swift
//  MatchCards
//
//  Created by Klyuev Vladislav on 31/03/2019.
//  Copyright © 2019 Klyuev Vladislav. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card: Card){
        
        //keep track of the card that gets passed in
        self.card = card
        
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        }
        else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //Determine if the card is in flipped up state or flipped down state
        if card.isFlipped == true {
            
            //Make sure the frontImageView is on top
              UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else {
            //Make sure the backImageView is on top
             UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        
        
    }
    
    func flip() {
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6, execute:{
            
            UIView.transition(from: self.frontImageView,
                              to: self.backImageView,
                              duration: 0.3,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion: nil)
            
        })
        
        
    }
    
    func remove() {
        //removes both imageviews from being visible
        backImageView.alpha = 0
        
        //Animate it
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
        
    }
}
