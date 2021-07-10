//
//  DealButton.swift
//  Set
//
//  Created by Alex Cooke on 9/7/21.
//

import UIKit

class DealButton : UIButton {
    override func awakeFromNib() {
        setConstraints()
        style()
    }
    
    func setConstraints() {
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
    
    func style() {
        self.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1).withAlphaComponent(0.70)
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
