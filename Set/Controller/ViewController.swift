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
    @IBOutlet var setContainer: SetContainerView! {
        didSet {
            setContainer.setCardViews = Array.init(repeating: SetCardView(), count: 48)
        }
    }
    
    
//    let MAX_NUMBER_OF_CARDS_ON_TABLE = 24
//    var game = SetGame()
//
    override func viewDidLoad() {
        super.viewDidLoad()
//        handleOrientation()
//        updateViewAccordingToModel()
    }
//
//    func updateViewAccordingToModel() {
//        let numberOfCardsToDisplay = game.cardsInPlay.count
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
//        scoreLabel.text = "Score: \(game.score)"
//    }
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
    
//    @IBAction func cardButtonPressed(_ sender: CardButton) {
//        game.flushMatches()
//        let idx = allCardButtons.firstIndex(of: sender)
//
//        if let idx = idx {
//            print(idx)
//            game.choseCard(at: idx)
//            updateViewAccordingToModel()
//        }
//    }
    
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
    
//MARK: Handling Orientation (Extra)
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        handleOrientation()
//    }
//
//    private func handleOrientation() {
//        if UIDevice.current.orientation.isLandscape {
//            hideOrientationDependentStacks(true)
//            distributeOrientationDependentCards(among: mainStacks)
//        } else {
//            hideOrientationDependentStacks(false)
//            distributeOrientationDependentCards(among: orientationDependentStacks)
//        }
//    }
//
//    private func distributeOrientationDependentCards(among stack : [UIStackView]) {
//        var n = orientationDependentCards.count - 1, idx = 0
//        while n >= 0 {
//            if let btn = orientationDependentCards?[n] {
//                stack[idx].addArrangedSubview(btn)
//                n -= 1
//                idx = (idx + 1) % stack.count
//            }
//        }
//    }
//
//    private func hideOrientationDependentStacks(_ hide : Bool) {
//        for stack in orientationDependentStacks {
//            stack.isHidden = hide
//        }
//    }
}


