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
        self.backgroundColor = Colours.Default.bg
        self.setTitleColor(Colours.Title.enabled, for: .normal)
    }
}
