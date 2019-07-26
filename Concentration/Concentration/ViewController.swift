//
//  ViewController.swift
//  Concentration
//
//  Created by Vladislav Klyuev on 03/04/2019.
//  Copyright © 2019 Vladislav Klyuev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1)/2
        }
    }
    
    private(set) var flipCount = 0 {
        didSet{
           updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key: Any] = [.strokeWidth: 5.0, .strokeColor: UIColor.orange]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton){
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let  card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            }
            else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
            
        }
    }
    
//    private lazy var themeDictionary = [1: ["🐶","🐱","🐭","🐹","🐰","🦊"],
//        2:["🌵","🌱","🎍","🎋","🌷","🌺"],
//        3:["🍏","🍐","🍊","🍋","🍌","🍉"],
//        4:["🥛","☕️","🥤","🍺","🥂","🥃"],
//        5:["⚽️","🏀","🏈","⚾️","🏐","🎱"],
//        6:["🚑","🛴","🚲","🏍","🚘","✈️"]
//    ]
    
    private lazy var themeDictionary = [1: "🐶🐱🐭🐹🐰🦊",
                                        2: "🌵🌱🎍🎋🌷🌺",
                                        3: "🍏🍐🍊🍋🍌🍉",
                                        4: "🥛☕️🥤🍺🥂🥃",
                                        5: "⚽️🏀🏈⚾️🏐🎱",
                                        6: "🚑🛴🚲🏍🚘✈️"
    ]
    private lazy var theme = Int.random(in: 1...themeDictionary.count)
    
    private lazy var emojiChoices = themeDictionary[theme]
    
    private var emoji =  [Card: String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card] == nil, emojiChoices!.count > 0 {
            let randomStringIndex = emojiChoices!.index(emojiChoices!.startIndex, offsetBy: Int.random(in: 0..<emojiChoices!.count))
            emoji[card] = String(emojiChoices!.remove(at: randomStringIndex))
            }
        return emoji[card] ?? "?"
    }
    
//    @IBAction func startNewGame(_ sender: Any) {
//        self.game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
//        self.emojiChoices = themeDictionary[Int.random(in: 1...themeDictionary.count)]
//        updateViewFromModel()
//    }
    
}

//extension Int {
//    var arc4random: Int {
//        if self > 0 {
//        return Int(arc4random_uniform(UInt32(self)))
//        } else if self < 0{
//            return -Int(arc4random_uniform(UInt32(abs(self))))
//        } else {
//            return 0
//        }
//    }
//}
