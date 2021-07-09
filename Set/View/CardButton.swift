//
//  CustomButton.swift
//  Set
//
//  Created by Alex Cooke on 9/7/21.
//

import UIKit

class CardButton : UIButton {
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
                                   constant: 60)
        self.addConstraints([w])
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
    }
    
    func style() {
        self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.layer.cornerRadius = 5.0
    }
    
    func setAttributes(cardinality : Int, colour: UIColor, shape : String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: colour
        ]
        
        let attributedString = NSAttributedString(string: String(repeating: shape, count: cardinality), attributes: attributes)
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
