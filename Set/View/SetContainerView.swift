//  SetContainerView.swift
//  Created by Alex Cooke on 13/7/21.

/*
 Purpose: This class dynamically re-sizes its subviews ([SetCardView]),
 so that each SetCardView is as large as possible at any given time,
 depending on factors such as device size, screen orientation
 and the number of cards currently in play.
 */

import UIKit

class SetContainerView: UIView {
    var setCardViews : [SetCardView]! { didSet {flushAndReset(); setNeedsLayout()}}
    
    private func flushAndReset() {
        self.subviews.forEach{$0.removeFromSuperview()}
        setCardViews.forEach{addSubview($0)}
    }
    
    private var idealGridSize : (Int, Int) {
        let factors = setCardViews.count.factors
        let middleIdx = factors.middleIdx
        let middleFactor = factors[middleIdx]
        let complementFactor = setCardViews.count / middleFactor
        let more = middleFactor > complementFactor ? middleFactor : complementFactor
        let less = middleFactor > complementFactor ? complementFactor : middleFactor
        
        return UIDevice.current.orientation.isPortrait ? (rows: more, columns: less) :
                                                         (rows: less, columns : more)
    }
    
    override func layoutSubviews() {
        print(idealGridSize)
    }
}

extension SetContainerView {
    private struct Constants {
        static let MAX_FACTOR_THAT_AXIS_CAN_DIFFER_BY = 5.0
    }
}

extension Int {
    var factors : [Int] {
        let sqrtn = Int(Double(self).squareRoot())
        var factors: [Int] = []
        factors.reserveCapacity(2 * sqrtn)
        for i in 1...sqrtn {
            if self % i == 0 {
                factors.append(i)
            }
        }
        var j = factors.count - 1
        if factors[j] * factors[j] == self {
            j -= 1
        }
        while j >= 0 {
            factors.append(self / factors[j])
            j -= 1
        }
        return factors
    }
}

extension Array {
    var middleIdx: Int {
        return (self.isEmpty ? self.startIndex : self.count - 1) / 2
    }
}
