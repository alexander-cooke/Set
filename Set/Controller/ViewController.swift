//
//  ViewController.swift
//  Set
//
//  Created by Alex Cooke on 8/7/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var dealButton: DealButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var setContainer: SetContainerView!
    
    var game = SetGame()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewAccordingToModel()
    }

    func updateViewAccordingToModel() {
        var cardViews = [SetCardView]()
        for card in game.cardsInPlay {
            let cardView = SetCardView()
            cardView.number = card.cardinality.rawValue + 1
            cardView.colour = Constants.colours[card.colour.rawValue]
            cardView.shape = Constants.shapes[card.shape.rawValue]
            cardView.shading = Constants.shading[card.shading.rawValue]
            cardView.isSelected = game.selectedCards.contains(card)
            cardView.isMatched = game.mostRecentSet.contains(card)
            cardView.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
            cardViews.append(cardView)
        }
        setContainer.setCardViews = cardViews
        scoreLabel.text = "Score: \(game.score)"
    }
    
    @objc func cardTapped(_ sender: SetCardView) {
        game.flushMatches()
        let idx = setContainer.setCardViews.firstIndex(of: sender)

        if let idx = idx {
            game.choseCard(at: idx)
            updateViewAccordingToModel()

        }
    }
    
    //
    //
    //
    //        for cardIndex in 0..<allCardButtons.count {
    //            let relevantButton = allCardButtons[cardIndex]
    //            relevantButton.isEnabled = true
    //            relevantButton.alpha = 100.0
    //            if cardIndex < numberOfCardsToDisplay {
    //                let card = game.cardsInPlay[cardIndex]
    //                displayCard(card, on: relevantButton)
    //            } else {
    //                relevantButton.isEnabled = false
    //                relevantButton.alpha = 0.0
    //            }
    //        }
    
//    @IBAction func cardButtonPressed(_ sender: CardButton) {
//        game.flushMatches()

//    }
    
    private struct Constants {
        static let maxCardsOnTable = 24
        static let colours = [#colorLiteral(red: 1, green: 0.7058823529, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.6509803922, blue: 0.9294117647, alpha: 1), #colorLiteral(red: 0.4980392157, green: 0.7215686275, blue: 0, alpha: 1)]
        static let shapes = [SetCardView.Shape.circle,
                             SetCardView.Shape.square,
                             SetCardView.Shape.triangle]
        static let shading = [SetCardView.Shading.fill,
                              SetCardView.Shading.outline,
                              SetCardView.Shading.stripe]
    }
//
//    private func displayCard(_ card : Card, on button : CardButton) {
//        let (text, attributes) = getAttributeTuple(for: card)
//        button.setAttributes(text, attributes)
//
//        if game.mostRecentSet.contains(card) {
//            button.showAsMatched(true)
//        } else if game.selectedCards.contains(card) {
//            button.showAsSelected(true)
//        } else {
//            button.showAsSelected(false)
//        }
//        button.isHidden = false
//
//        if game.matchedCardsHistory.contains(card) {
//            button.isEnabled = false
//            button.alpha = 0.0
//        }
//    }
//
    @IBAction func dealPressed(_ sender: DealButton) {
//        game.dealCards()
//        updateViewAccordingToModel()
//        if game.cardsInPlay.count >= MAX_NUMBER_OF_CARDS_ON_TABLE {
//            sender.shouldEnable(false)
//        }
    }
    
    @IBAction func newGamesPressed(_ sender: UIButton) {
//        game = SetGame()
//        for button in allCardButtons {
//            button.isEnabled = true
//            button.alpha = 100.0
//        }
//        dealButton.shouldEnable(true)
//        updateViewAccordingToModel()
        
    }
    

    
//    func getAttributeTuple(for card : Card) -> (String, [NSAttributedString.Key: Any]) {
//        let shapes = ["●", "▲", "■"]
//        let shape = shapes[card.shape.rawValue]
//        let cardinality = card.cardinality.rawValue + 1
//        let text = String(repeating: shape, count: cardinality)
//
//        let colours = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)]
//        let colour = colours[card.colour.rawValue]
//        var attributes = [NSAttributedString.Key: Any]()
//        switch card.shading {
//        case .A:
//            attributes = [.foregroundColor: colour]
//        case .B:
//            attributes = [.foregroundColor: colour, .strokeWidth: 10]
//        case .C:
//            attributes = [.foregroundColor: colour.withAlphaComponent(0.30)]
//        }
//        return (text, attributes)
//    }
}


