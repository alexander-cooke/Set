//
//  Set.swift
//  Set
//
//  Created by Alex Cooke on 9/7/21.
//

import Foundation

struct SetGame {

    private var cards = [Card]()
    private(set) var cardsInPlay = [Card]()
    lazy private(set) var selectedCards =  [Card]()
    private(set) var mostRecentSet = [Card]()
    private(set) var matchedCardsHistory = [Card]()
    private(set) var score = 0
    
    mutating func dealCards(_ N : Int = 3) {
        for _ in 1...N {
            if cards.count > 0 {
                cardsInPlay += [draw()]
            } else {
                print("No more cards left to draw")
            }
                
        }
    }
    
    mutating private func draw() -> Card {
       return cards.remove(at: cards.count.arc4random)
    }
    
    mutating func choseCard(at index : Int) {
        // If the chosen card is already selected, de-select it.
        if let index = selectedCards.firstIndex(of: cardsInPlay[index]) {
            selectedCards.remove(at: index)
        } else {
            if selectedCards.count < 2 {
                selectedCards += [cardsInPlay[index]]
            } else if selectedCards.count == 2 {
                selectedCards += [cardsInPlay[index]]
                if selectedCardsFormASet() {
                    score += 3
                    mostRecentSet = selectedCards
                    selectedCards.removeAll()
                } else {
                    score -= 5
                }
            } else {
                selectedCards.removeAll()
                selectedCards += [cardsInPlay[index]]
            }
        }
    }
    
    mutating func flushMatches() {
        if !mostRecentSet.isEmpty {
            for recentlyMatchedCard in mostRecentSet {
                if let idx = cardsInPlay.firstIndex(of: recentlyMatchedCard) {
                    if cards.count > 0 {
                        cardsInPlay[idx] = draw()
                    }
                }
            }
            matchedCardsHistory += mostRecentSet
            mostRecentSet = []
        }
    }
    
    mutating func selectedCardsFormASet() -> Bool {
        var theseCardsFormASet = true
        var arrayOfSets = [Set<Card.PermissableValue>]()
        arrayOfSets.append(Set(arrayLiteral: selectedCards[0].cardinality, selectedCards[1].cardinality, selectedCards[2].cardinality))
        arrayOfSets.append(Set(arrayLiteral: selectedCards[0].colour, selectedCards[1].colour, selectedCards[2].colour))
        arrayOfSets.append(Set(arrayLiteral: selectedCards[0].shape, selectedCards[1].shape, selectedCards[2].shape))
        arrayOfSets.append(Set(arrayLiteral: selectedCards[0].shading, selectedCards[1].shading, selectedCards[2].shading))
        
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
                        cards.append(Card(cardinality: cardinality, colour: colour, shape: shape, shading: shading))
                    }
                }
            }
        }
        dealCards(12)
    }
    
    
//    // Tester Init
//    init() {
//        var id = 0
//        let allCases = Card.PermissableValue.allCases
//        for _ in 0...29 {
//            cards.append(Card(cardinality: Card.PermissableValue.A, colour: Card.PermissableValue.A, shape: Card.PermissableValue.A, shading: Card.PermissableValue.A, id: id))
//            id += 1
//        }
//        dealCards(12)
//    }
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
