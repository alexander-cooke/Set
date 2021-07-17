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
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dealCards))
            swipe.direction = .down
            setContainer.addGestureRecognizer(swipe)
            
            let rotation = UIRotationGestureRecognizer(target: self, action: #selector(shuffle))
            setContainer.addGestureRecognizer(rotation)
        }
    }
    
    var game = SetGame()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewAccordingToModel()
    }
    
    func updateViewAccordingToModel() {
        var cardViews = [SetCardView]()
        for card in game.cardsInPlay {
            let cardView = translateCardModelToView(using: card)
            cardViews.append(cardView)
        }
        setContainer.setCardViews = cardViews
        scoreLabel.text = "Score: \(game.score)"
        
        if game.cardsInPlay.count >= Constants.maxCardsOnTable || game.deck.isEmpty {
            dealButton.isEnabled = false
            dealButton.backgroundColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            dealButton.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        }
    }
    
    @objc func cardTapped(_ sender: SetCardView) {
        let underlyingCardModel = translateCardViewToModel(using: sender)
        let flushed = game.flushMatches()
        
        if !flushed.contains(underlyingCardModel) {
            game.choose(card: underlyingCardModel)
        }
        updateViewAccordingToModel()
    }
    
    private func translateCardViewToModel(using cardView : SetCardView) -> Card {
        let cardinalityRaw = Card.PermissableValue.RawValue(cardView.number - 1)
        let colourRaw = Card.PermissableValue.RawValue(Constants.colours.firstIndex(of: cardView.colour)!)
        let shapeRaw = Card.PermissableValue.RawValue(Constants.shapes.firstIndex(of: cardView.shape)!)
        let shadingRaw = Card.PermissableValue.RawValue(Constants.shading.firstIndex(of: cardView.shading)!)
        
        return Card(cardinality: Card.PermissableValue(rawValue: cardinalityRaw)!,
                    colour: Card.PermissableValue(rawValue: colourRaw)!,
                    shape: Card.PermissableValue(rawValue: shapeRaw)!,
                    shading: Card.PermissableValue(rawValue: shadingRaw)!)
    }
    
    private func translateCardModelToView(using card : Card) -> SetCardView {
        let cardView = SetCardView()
        cardView.number = card.cardinality.rawValue + 1
        cardView.colour = Constants.colours[card.colour.rawValue]
        cardView.shape = Constants.shapes[card.shape.rawValue]
        cardView.shading = Constants.shading[card.shading.rawValue]
        cardView.isSelected = game.selectedCards.contains(card)
        cardView.isSelectedAndMatched = game.mostRecentSet.contains(card)
        cardView.isHint = game.hintCards.contains(card)
        cardView.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
        return cardView
    }
    
    @objc private func dealCards() {
        if (game.cardsInPlay.count < Constants.maxCardsOnTable && !game.deck.isEmpty) {
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

    @IBAction func dealPressed(_ sender: DealButton) {
        dealCards()
    }
    
    @IBAction func newGamesPressed(_ sender: UIButton) {
        game = SetGame()
        dealButton.isEnabled = true
        dealButton.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.7215686275, blue: 0, alpha: 1)
        dealButton.setTitleColor(.white, for: .normal)
        updateViewAccordingToModel()
    }
    
    @IBAction func hintPressed(_ sender: HintButton) {
        game.hint()
        updateViewAccordingToModel()
    }
    
    
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
}


