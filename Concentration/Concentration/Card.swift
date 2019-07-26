//
//  Concentration.swift
//  Concentration
//
//  Created by Vladislav Klyuev on 03/04/2019.
//  Copyright © 2019 Vladislav Klyuev. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    func hash(into hasher: inout Hasher){
        hasher.combine(self.identifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        Card.identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
