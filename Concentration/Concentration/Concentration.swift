//
//  Card.swift
//  Concentration
//
//  Created by Vladislav Klyuev on 03/04/2019.
//  Copyright © 2019 Vladislav Klyuev. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index is not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
         assert(numberOfPairsOfCards > 0, "Concentration.chooseCard(at: \(numberOfPairsOfCards)): at least one pair of cards is to be here")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        for _ in cards.indices {
            let temp = Int.random(in: 0..<cards.count)
            var temp2 = Int.random(in: 0..<cards.count)
            while temp == temp2{
                temp2 = Int.random(in: 0..<cards.count)
            }
            let temporary = cards[temp]
            cards[temp] = cards[temp2]
            cards[temp2] = temporary
        }
        
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
