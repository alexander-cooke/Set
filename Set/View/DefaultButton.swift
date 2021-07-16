//
//  Default Button.swift
//  Set
//
//  Created by Alex Cooke on 10/7/21.
//


import UIKit

class DefaultButton : UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.backgroundColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.9294117647, alpha: 1)
        self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    }
}
