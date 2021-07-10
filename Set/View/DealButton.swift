//
//  DealButton.swift
//  Set
//
//  Created by Alex Cooke on 9/7/21.
//

import UIKit

class DealButton : DefaultButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shouldEnable(true)
        
        let w = NSLayoutConstraint(item: self,
                                   attribute: NSLayoutConstraint.Attribute.width,
                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                   toItem: nil,
                                   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                   multiplier: 1,
                                   constant: 240)
        
        let h = NSLayoutConstraint(item: self,
                                   attribute: NSLayoutConstraint.Attribute.height,
                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                   toItem: nil,
                                   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                   multiplier: 1,
                                   constant: 30)
        self.addConstraints([w, h])
    }
    
    func shouldEnable(_ enable : Bool) {
        self.isEnabled = enable ? enable : !enable
        self.backgroundColor = enable ?  #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1).withAlphaComponent(0.60) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.setTitleColor(enable ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
    }
}
