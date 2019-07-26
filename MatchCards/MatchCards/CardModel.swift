//
//  CardModule.swift
//  MatchCards
//
//  Created by Klyuev Vladislav on 31/03/2019.
//  Copyright © 2019 Klyuev Vladislav. All rights reserved.
//

import Foundation

class CardModel{
    
    func getCards() -> [Card]{
        //Declare an array to store numbers we've already generated
        var generatedNumbersArray = [Int]()
        
        //Declare an array to store generated cards
        var generatedCardsArray = [Card]()
        
        //Randomly generate pairs of cards
        while generatedNumbersArray.count < 8 {
            
            let randomNumber = arc4random_uniform(13) + 1
            
            //Ensure that the random number hasn't happened before
            if generatedNumbersArray.contains(Int(randomNumber)) == false{
                
                generatedNumbersArray.append(Int(randomNumber))
                
                let cardTemp1 = Card()
                cardTemp1.imageName = "card\(randomNumber)"
                generatedCardsArray.append(cardTemp1)
                
                let cardTemp2 = Card()
                cardTemp2.imageName = "card\(randomNumber)"
                generatedCardsArray.append(cardTemp2)
            }
            
            
        }
        
        for i in 0..<generatedCardsArray.count{
        
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
        
            //Swap two cards
            let temp = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = temp
        }
        
        return generatedCardsArray
        
    }
}
