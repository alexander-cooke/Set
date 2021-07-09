//
//  ViewController.swift
//  Set
//
//  Created by Alex Cooke on 8/7/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var allCardButtons: [UIButton]!
    @IBOutlet var mainStacks: [UIStackView]!
    @IBOutlet var auxStacks: [UIStackView]!
    @IBOutlet var auxStackButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleOrientation()
    }
    
//MARK: Handling Orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        handleOrientation()
    }
    
    func handleOrientation() {
        if UIDevice.current.orientation.isLandscape {
            hideAuxStacks(true)
            distributeChildren(among: mainStacks)
        } else {
            hideAuxStacks(false)
            distributeChildren(among: auxStacks)
        }
    }
    
    func distributeChildren(among stack : [UIStackView]) {
        var n = auxStackButtons.count - 1, idx = 0
        while n >= 0 {
            if let btn = auxStackButtons?[n] {
                stack[idx].addArrangedSubview(btn)
                n -= 1
                idx = (idx + 1) % stack.count
            }
        }
    }
    
    func hideAuxStacks(_ hide : Bool) {
        for stack in auxStacks {
            stack.isHidden = hide
        }
    }


}

