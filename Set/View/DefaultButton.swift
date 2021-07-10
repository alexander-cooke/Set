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
        self.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1).withAlphaComponent(0.15)
    }
}
