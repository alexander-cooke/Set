//
//  CustomButton.swift
//  Set
//
//  Created by Alex Cooke on 9/7/21.
//

import UIKit

class CardButton : DefaultButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.clear.cgColor
        let w = NSLayoutConstraint(item: self,
                                   attribute: NSLayoutConstraint.Attribute.width,
                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                   toItem: nil,
                                   attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                   multiplier: 1,
                                   constant: 50)
        self.addConstraints([w])
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
    }
    
    func showAsSelected(_ isSelected : Bool) {
        layer.borderColor = isSelected ? UIColor.orange.cgColor : UIColor.clear.cgColor
    }
    
    func showAsMatched(_ isMatched : Bool) {
        layer.borderColor = isMatched ? UIColor.green.cgColor : UIColor.clear.cgColor
    }
    
    func setAttributes(_ text : String, _ attr : [NSAttributedString.Key: Any]) {
        var attributes = attr
        attributes[.font] = UIFont.systemFont(ofSize: 22)
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
