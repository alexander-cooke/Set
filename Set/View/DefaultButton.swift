//
//  DefaultButton.swift
//  Set
//
//  Created by Alex Cooke on 17/7/21.
//

import UIKit

class DefaultButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
        self.backgroundColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.9294117647, alpha: 1)
        self.setTitleColor(.white, for: .normal)
    }
}
