//
//  DealButton.swift
//  Set
//
//  Created by Alex Cooke on 17/7/21.
//

import UIKit

class DealButton: DefaultButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        enable()
    }
    
    func disable() {
        self.isEnabled = false
        self.backgroundColor = Colours.Bg.disabled
        self.setTitleColor(Colours.Title.disabled, for: .normal)
    }
    
    func enable() {
        self.isEnabled = true
        self.backgroundColor = Colours.Deal.bgEnable
        self.setTitleColor(Colours.Title.enabled, for: .normal)
    }

}
