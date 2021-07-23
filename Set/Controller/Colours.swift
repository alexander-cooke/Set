//
//  Colours.swift
//  Set
//
//  Created by Alex Cooke on 23/7/21.
//

import UIKit

struct Colours {
    struct Primary {
        static let green = #colorLiteral(red: 0.4980392157, green: 0.7215686275, blue: 0, alpha: 1)
        static let yellow = #colorLiteral(red: 1, green: 0.7058823529, blue: 0, alpha: 1)
        static let blue = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.9294117647, alpha: 1)
        static let bg = #colorLiteral(red: 0.05098039216, green: 0.1725490196, blue: 0.3294117647, alpha: 1)
    }
    
    struct Border {
        static let selected = #colorLiteral(red: 0.9647058824, green: 0.3176470588, blue: 0.1137254902, alpha: 1)
        static let hint = Primary.yellow
        static let matched = Primary.green
    }
    
    struct Title {
        static let enabled = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static let disabled = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    struct Bg {
        static let disabled = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    struct Deal {
        static let bgEnable = Primary.green
    }
    
    struct Hint {
        static let bg = Border.hint
    }
    
    struct Default {
        static let bg = Primary.blue
    }
}
