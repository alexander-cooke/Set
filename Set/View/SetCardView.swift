//
//  SetCardView.swift
//  Set
//
//  Created by Alex Cooke on 13/7/21.
//

import UIKit

class SetCardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension SetCardView {
    private struct SizeRatios {
        static let cornerRadiusToBoundsHeight : CGFloat = 0.06
        static let cornerFontSizeToBoundsHeight : CGFloat = 0.085
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
    }
    
    private var cornerRadius : CGFloat {
        bounds.size.height * SizeRatios.cornerRadiusToBoundsHeight
    }
    
    private var cornerFontSize : CGFloat {
        bounds.size.height * SizeRatios.cornerFontSizeToBoundsHeight
    }
    
    private var cornerOffset : CGFloat {
        return cornerRadius * SizeRatios.cornerOffsetToCornerRadius
    }
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
