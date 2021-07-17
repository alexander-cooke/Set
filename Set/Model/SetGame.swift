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
    private(set) var hintCards = [Card]()
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
                let setHasBeenFound = cardsFormASet(selectedCards)
                score += setHasBeenFound ? 3 : -5
                mostRecentSet = setHasBeenFound ? selectedCards : mostRecentSet
            } else if selectedCards.count > 3 {
                selectedCards = selectedCards.filter{$0 == card}
            }
        }
        hintCards = []
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
    
    mutating func cardsFormASet(_ cards : [Card]) -> Bool {
        var theseCardsFormASet = true
        var arrayOfSets = [Set<Card.PermissableValue>]()
        arrayOfSets.append(Set(arrayLiteral:   cards[0].cardinality,   cards[1].cardinality,   cards[2].cardinality))
        arrayOfSets.append(Set(arrayLiteral:   cards[0].colour,   cards[1].colour,   cards[2].colour))
        arrayOfSets.append(Set(arrayLiteral:   cards[0].shape,   cards[1].shape,   cards[2].shape))
        arrayOfSets.append(Set(arrayLiteral:   cards[0].shading,   cards[1].shading,   cards[2].shading))
        
        for set in arrayOfSets {
            if set.count != 1 && set.count != 3 {
                theseCardsFormASet = false
            }
        }
        return theseCardsFormASet
    }
    
    mutating func shuffle() {
        cardsInPlay.shuffle()
    }
    
    mutating func hint() {
        _ = flushMatches()
        selectedCards = []
        if let set = findSet(),
           hintCards.isEmpty {
            hintCards = Array(set[0...1])
            selectedCards = hintCards
        } else {
            hintCards = []
        }
    }
    
    private mutating func findSet() -> [Card]? {
        for firstCard in cardsInPlay {
            for secondCard in cardsInPlay {
                for thirdCard in cardsInPlay {
                    if firstCard != secondCard &&
                       secondCard != thirdCard &&
                        firstCard != thirdCard {
                        let candidateCards = [firstCard, secondCard, thirdCard]
                        if cardsFormASet(candidateCards) {
                            return candidateCards
                        }
                    }
                }
            }
        }
        return nil
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
