//
//  ViewController.swift
//  Set
//
//  Created by Alex Cooke on 8/7/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var allCardButtons: [CardButton]!
    
    @IBOutlet private var mainStacks: [UIStackView]!
    @IBOutlet private var orientationDependentStacks: [UIStackView]!
    @IBOutlet private var orientationDependentCards: [UIButton]!
    
    var game = SetGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleOrientation()
        updateViewAccordingToModel()
    }
    
    func updateViewAccordingToModel() {
        let numberOfCardsToDisplay = game.cardsInPlay.count
        print(numberOfCardsToDisplay)
        for cardIndex in 0..<allCardButtons.count {
            if cardIndex < numberOfCardsToDisplay {
                let card = game.cardsInPlay[cardIndex]
                let (cardinality, colour, shape) = getAttributeTuple(for: card)
                allCardButtons[cardIndex].isHidden = false
                allCardButtons[cardIndex].setAttributes(cardinality: cardinality, colour: colour, shape: shape)
                
                if game.selectedCards.contains(game.cardsInPlay[cardIndex]) {
                    allCardButtons[cardIndex].layer.borderWidth = 3.0
                    allCardButtons[cardIndex].layer.borderColor = UIColor.orange.cgColor
                } else {
                    allCardButtons[cardIndex].layer.borderColor = UIColor.clear.cgColor
                }
            } else {
                allCardButtons[cardIndex].isHidden = true
            }
        }
    }
    
    @IBAction func deal3MorePressed(_ sender: UIButton) {
        game.dealCards()
        updateViewAccordingToModel()
    }
    
    @IBAction func cardButtonPressed(_ sender: CardButton) {
        let idx = allCardButtons.firstIndex(of: sender)
        if let idx = idx {
            game.choseCard(at: idx)
            updateViewAccordingToModel()
        }
    }
    
    
    func getAttributeTuple(for card : Card) -> (Int, UIColor, String) {
        let colour = getColourValue(of: card)
        let shape = getShapeValue(of: card)
        let cardinality = getCardinalityValue(of: card)
        return (cardinality, colour, shape)
    }
    
    func getColourValue(of card : Card) -> UIColor {
        switch card.colour {
        case .A:
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case .B:
            return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case .C:
            return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
    }
    
    func getShapeValue(of card : Card) -> String {
        switch card.shape {
        case .A:
            return "●"
        case .B:
            return "▲"
        case .C:
            return "■"
        }
    }
    
    func getCardinalityValue(of card : Card) -> Int {
        switch card.cardinality {
        case .A:
            return 1
        case .B:
            return 2
        case .C:
            return 3
        }
    }
    
//MARK: Handling Orientation (Extra)
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        handleOrientation()
    }
    
    private func handleOrientation() {
        if UIDevice.current.orientation.isLandscape {
            hideOrientationDependentStacks(true)
            distributeOrientationDependentCards(among: mainStacks)
        } else {
            hideOrientationDependentStacks(false)
            distributeOrientationDependentCards(among: orientationDependentStacks)
        }
    }
    
    private func distributeOrientationDependentCards(among stack : [UIStackView]) {
        var n = orientationDependentCards.count - 1, idx = 0
        while n >= 0 {
            if let btn = orientationDependentCards?[n] {
                stack[idx].addArrangedSubview(btn)
                n -= 1
                idx = (idx + 1) % stack.count
            }
        }
    }
    
    private func hideOrientationDependentStacks(_ hide : Bool) {
        for stack in orientationDependentStacks {
            stack.isHidden = hide
        }
    }


}


