//
//  ViewController.swift
//  Set
//
//  Created by Alex Cooke on 8/7/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var stackRow1: UIStackView!
    @IBOutlet var stackRow6: UIStackView!
    @IBOutlet var changeStacksDependingOnOrientation: [UIButton]!
    @IBOutlet var visibleRegardlessOfOrientation: [UIStackView]!
    @IBOutlet var hiddenIfLandscape: [UIStackView]!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Check orientation and do re-distribution and hiding if landscape
        for button in changeStacksDependingOnOrientation {
            button.frame.size = CGSize(width: 60, height: 60)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            toggleHiddenStacks()
            redistributeChildren()
            
        } else {
            print("Portrait")
            toggleHiddenStacks()
        }
    }
    
    func redistributeChildren() {
        var n = changeStacksDependingOnOrientation.count - 1
        let btns = changeStacksDependingOnOrientation
        let x = visibleRegardlessOfOrientation.count
        let stacks = visibleRegardlessOfOrientation
        var i = 0
        
        while n >= 0 {
            print(i)
            if let stack = stacks?[i],
               let btn = btns?[n] {
                stack.addArrangedSubview(btn)
                n -= 1
                i = (i + 1) % x
            }
        }
    }
    
    func toggleHiddenStacks() {
        for stack in hiddenIfLandscape {
            stack.isHidden = !stack.isHidden
        }
    }


}

