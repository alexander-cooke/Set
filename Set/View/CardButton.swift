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
                                   constant: 50)
        self.addConstraints([w])
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
    }
    
    func style() {
        self.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1).withAlphaComponent(0.15)
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setAttributes(cardinality : Int, colour: UIColor, shape : String, shading : ViewController.Shading) {
        var attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 22),
            .foregroundColor: colour,
        ]
        
        switch shading {
        case .hollow:
            attributes[.strokeWidth] = 12
        case .striped:
            attributes[.foregroundColor] = colour.withAlphaComponent(0.40)
        default:
            break
        }
        
        let attributedString = NSAttributedString(string: String(repeating: shape, count: cardinality), attributes: attributes)
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
