//
//  CustomButton.swift
//  Set
//
//  Created by Alex Cooke on 9/7/21.
//

import UIKit

class CustomButton : UIButton {
    override func awakeFromNib() {
        setWidthAndHeightConstraints()
        style()
    }
    
    func setWidthAndHeightConstraints() {
        let w = NSLayoutConstraint(item: self,
                                   attribute: NSLayoutConstraint.Attribute.width,
                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                   toItem: nil,
                                   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                   multiplier: 1,
                                   constant: 60)
        
        let h = NSLayoutConstraint(item: self,
                                   attribute: NSLayoutConstraint.Attribute.height,
                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                   toItem: nil,
                                   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                   multiplier: 1,
                                   constant: 60)
        
        self.addConstraints([w, h])
    }
    
    func style() {
        self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.layer.cornerRadius = 5.0
        
        // TODO: Implement using NSAttributedString
        self.setTitle("?", for: .normal)
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }
}
