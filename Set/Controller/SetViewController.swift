//
//  ViewController.swift
//  Set
//
//  Created by Alex Cooke on 8/7/21.
//

import UIKit

class SetViewController: UIViewController {
    private var game = SetGame()
    
    //MARK: IBOutlet setup
    @IBOutlet var dealButton: DealButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var setContainer: SetContainerView! {didSet {setupGestureRecognisers()}}

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewAccordingToModel()
    }
    
    //MARK: Main update method
    private func updateViewAccordingToModel() {
        var cardViews = [SetCardView]()
        for card in game.cardsInPlay {
            let cardView = Translator.modelToView(using: card, from: game)
            cardView.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
            cardViews.append(cardView)
        }
        setContainer.setCardViews = cardViews //Triggers re-draw
        scoreLabel.text = "Score: \(game.score)"
        if !moreCardsCanBeDealt() {
            dealButton.disable()
        }
    }
    
    //MARK: Gesture Event Handlers
    @objc func cardTapped(_ sender: SetCardView) {
        let underlyingCardModel = Translator.viewToModel(using: sender)
        let flushed = game.flushMatches()
        
        if !flushed.contains(underlyingCardModel) {
            game.choose(card: underlyingCardModel)
        }
        updateViewAccordingToModel()
    }
    
    @objc private func dealCards() {
        if (moreCardsCanBeDealt()) {
            game.dealCards()
            updateViewAccordingToModel()
        }
    }
    
    @objc private func shuffle(recognizer: UIRotationGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            game.shuffle()
            updateViewAccordingToModel()
        default:
            break
        }
    }

    //MARK: IBActions
    @IBAction func dealPressed(_ sender: DealButton) {
        dealCards()
    }
    
    @IBAction func newGamesPressed(_ sender: UIButton) {
        game = SetGame()
        dealButton.enable()
        updateViewAccordingToModel()
    }
    
    @IBAction func hintPressed(_ sender: HintButton) {
        game.hint()
        updateViewAccordingToModel()
    }
    
    private func moreCardsCanBeDealt() -> Bool {
        return game.cardsInPlay.count < Constants.maxCardsOnTable && !game.deck.isEmpty
    }
    
    private func setupGestureRecognisers() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dealCards))
        swipe.direction = .down
        setContainer.addGestureRecognizer(swipe)
        
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(shuffle))
        setContainer.addGestureRecognizer(rotation)
    }
    
    struct Constants {
        static let maxCardsOnTable = 24
    }
}


class Translator {
    static fileprivate func viewToModel(using cardView : SetCardView) -> Card {
        let cardinalityRaw = Card.PermissableValue.RawValue(cardView.viewModel.number - 1)
        let colourRaw = Card.PermissableValue.RawValue(Constants.colours.firstIndex(of: cardView.viewModel.colour)!)
        let shapeRaw = Card.PermissableValue.RawValue(Constants.shapes.firstIndex(of: cardView.viewModel.shape)!)
        let shadingRaw = Card.PermissableValue.RawValue(Constants.shading.firstIndex(of: cardView.viewModel.shading)!)
        
        return Card(cardinality: Card.PermissableValue(rawValue: cardinalityRaw)!,
                    colour: Card.PermissableValue(rawValue: colourRaw)!,
                    shape: Card.PermissableValue(rawValue: shapeRaw)!,
                    shading: Card.PermissableValue(rawValue: shadingRaw)!)
    }
    
    static fileprivate func modelToView(using card : Card, from game : SetGame) -> SetCardView {
        var game = game
        let number = card.cardinality.rawValue + 1
        let colour = Constants.colours[card.colour.rawValue]
        let shape = Constants.shapes[card.shape.rawValue]
        let shading = Constants.shading[card.shading.rawValue]
        let isSelectedAndMatched = game.mostRecentSet.contains(card)
        let isHint = game.hintCards.contains(card)
        let cardViewModel = SetCardViewModel(number: number, colour: colour, shape: shape, shading: shading, isSelectedAndMatched: isSelectedAndMatched, isHint: isHint)
        
        let cardView = SetCardView()
        cardView.viewModel = cardViewModel
        cardView.isSelected = game.selectedCards.contains(card)

        return cardView
    }

    private struct Constants {
        static let colours = [Colours.Primary.blue,
                              Colours.Primary.yellow,
                              Colours.Primary.green]
        
        static let shapes = [SetCardView.Shape.circle,
                             SetCardView.Shape.square,
                             SetCardView.Shape.triangle]
        
        static let shading = [SetCardView.Shading.fill,
                              SetCardView.Shading.outline,
                              SetCardView.Shading.stripe]
    }
}
