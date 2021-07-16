//
//  Set.swift
//  Set
//
//  Created by Alex Cooke on 9/7/21.
//

import Foundation

struct SetGame {

    private(set) var deck = [Card]()
    private(set) var cardsInPlay = [Card]()
    lazy private(set) var selectedCards =  [Card]()
    private(set) var mostRecentSet = [Card]()
    private(set) var matchedCardsHistory = [Card]()
    private(set) var score = 0
    
    mutating func dealCards(_ N : Int = 3) {
        for _ in 1...N {
            if deck.count > 0 {
                cardsInPlay += [draw()]
            } else {
                print("No more cards left to draw")
            }
                
        }
    }
    
    mutating private func draw() -> Card {
       return deck.remove(at: deck.count.arc4random)
    }
    
    mutating func choose(card : Card) {
        if selectedCards.contains(card) {
            selectedCards.remove(element: card)
        } else {
            selectedCards.append(card)
            if selectedCards.count == 3 {
                let setHasBeenFound = selectedCardsFormASet()
                score += setHasBeenFound ? 3 : -5
                mostRecentSet = setHasBeenFound ? selectedCards : mostRecentSet
            } else if selectedCards.count > 3 {
                selectedCards = selectedCards.filter{$0 == card}
            }
        }
    }
    
    mutating func flushMatches() -> [Card] {
        if !mostRecentSet.isEmpty {
            for card in mostRecentSet {
                if let idx = cardsInPlay.firstIndex(of: card),
                   deck.count > 0 {
                    cardsInPlay[idx] = draw()
                } else {
                    cardsInPlay.remove(element: card)
                }
            }
        }
        let flushed = mostRecentSet
        mostRecentSet = []
        return flushed
    }
    
    mutating func selectedCardsFormASet() -> Bool {
        var theseCardsFormASet = true
        var arrayOfSets = [Set<Card.PermissableValue>]()
//        arrayOfSets.append(Set(arrayLiteral: selectedCards[0].cardinality, selectedCards[1].cardinality, selectedCards[2].cardinality))
//        arrayOfSets.append(Set(arrayLiteral: selectedCards[0].colour, selectedCards[1].colour, selectedCards[2].colour))
        arrayOfSets.append(Set(arrayLiteral: selectedCards[0].shape, selectedCards[1].shape, selectedCards[2].shape))
//        arrayOfSets.append(Set(arrayLiteral: selectedCards[0].shading, selectedCards[1].shading, selectedCards[2].shading))
        
        for set in arrayOfSets {
            if set.count != 1 && set.count != 3 {
                theseCardsFormASet = false
            }
        }
        return theseCardsFormASet
    }
    
    init() {
        let allCases = Card.PermissableValue.allCases
        for cardinality in allCases {
            for colour in allCases {
                for shape in allCases {
                    for shading in allCases {
                        deck.append(Card(cardinality: cardinality, colour: colour, shape: shape, shading: shading))
                    }
                }
            }
        }
        dealCards(12)
    }
}

extension Int {
    var arc4random : Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}

extension Array where Element: Equatable{
    mutating func remove (element: Element) {
        if let i = self.firstIndex(of: element) {
            self.remove(at: i)
        }
    }
}
