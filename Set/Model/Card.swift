//
//  Card.swift
//  Set
//
//  Created by Alex Cooke on 9/7/21.
//

import Foundation

struct Card : CustomStringConvertible, Equatable {
    let cardinality : PermissableValue
    let colour : PermissableValue
    let shape : PermissableValue
    let shading : PermissableValue
//    let id : Int
    
    enum PermissableValue : Int, CaseIterable {
        case A = 0
        case B
        case C
    }
    
    var description: String {
        var description = "---CARD---\n"
        description += "Cardinality: \(cardinality), "
        description += "Colour: \(colour)\n"
        description += "Shape : \(shape), "
        description += "Shading: \(shading)\n\n"
        return description
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (

            (lhs.cardinality == rhs.cardinality) &&
            (lhs.colour == rhs.colour) &&
            (lhs.shape == rhs.shape) &&
            (lhs.shading == rhs.shading)
//            && (lhs.id == rhs.id)
        )
    }
}
