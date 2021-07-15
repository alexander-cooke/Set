//
//  SetCardView.swift
//  Set
//
//  Created by Alex Cooke on 13/7/21.
//

/*
 #colorLiteral(red: 0.4901960784, green: 0.5764705882, blue: 0.5411764706, alpha: 1).setFill
 https://coolors.co/f6511d-ffb400-00a6ed-7fb800-0d2c54
 
 */

import UIKit

class SetCardView: UIButton {
    var number : Int = 1 {didSet{setNeedsDisplay()}}
    var colour : UIColor = UIColor.white {didSet{setNeedsDisplay()}}
    var shape : Shape = .square {didSet{setNeedsDisplay()}}
    var shading : Shading = .fill {didSet{setNeedsDisplay()}}
    var isMatched : Bool = false {didSet{setNeedsDisplay()}}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
        self.contentMode = .redraw
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundRect.addClip()
        #colorLiteral(red: 0.05098039216, green: 0.1725490196, blue: 0.3294117647, alpha: 1).setFill()
        roundRect.fill()
        
        let borderPath = roundRect
        var borderColour = isSelected ? #colorLiteral(red: 0.9647058824, green: 0.3176470588, blue: 0.1137254902, alpha: 1) : UIColor.clear
        borderColour = isMatched ? #colorLiteral(red: 0.4980392157, green: 0.7215686275, blue: 0, alpha: 1) : borderColour
        borderColour.setStroke()
        borderPath.lineWidth = 10
        borderPath.stroke()
        
//        self.layer.borderWidth = 1.0
//        self.layer.borderColor =
        
        
        // Get grid size based on cardinality and dimensions of bounds
        let (rows, columns) = bounds.width > bounds.height ? (1, number) : (number, 1)
        let grid = Grid(layout: .dimensions(rowCount: rows, columnCount: columns), frame: symbolDrawingArea)
        for idx in 0..<number {
            if let symbolFrame = grid[idx]?.inset(by: interSymbolInset) {
                drawTheSymbol(in: symbolFrame)
            }
        }
    }
    
    enum Shading {
        case fill
        case outline
        case stripe
    }
    
    private func drawTheSymbol(in symbolFrame : CGRect) {
        let path = makeShapePath(in: symbolFrame)
        
        switch shading {
        case .fill:
            colour.setFill()
            path.fill()
        case .outline:
            colour.setStroke()
            path.lineWidth = 2
            path.stroke()
        case .stripe:
            drawStriped(shape: path, in: symbolFrame)
        }
    }
    
    private func drawStriped(shape path: UIBezierPath, in symbolFrame: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.saveGState()
            path.addClip()
            let stripePath = UIBezierPath()
            for yPosition in stride(from: symbolFrame.minY, through: symbolFrame.maxY, by: numberOfLines) {
                stripePath.move(to: CGPoint(x: symbolFrame.minX, y: yPosition))
                let endOfStripe = CGPoint(x: symbolFrame.maxX, y: yPosition)
                stripePath.addLine(to: endOfStripe)
            }
            colour.setStroke()
            stripePath.lineWidth = 1
            stripePath.stroke()
            path.lineWidth = 5
            path.stroke()
            context.restoreGState()
        }
    }
    
    enum Shape {
        case circle
        case square
        case triangle
    }
    
    private func makeShapePath(in symbolFrame: CGRect) -> UIBezierPath {
        var shapeGraphic : UIBezierPath
        switch shape {
        case .circle:
            shapeGraphic = makeCirclePath(in: symbolFrame)
        case .square:
            shapeGraphic = makeSquarePath(in: symbolFrame)
        case .triangle:
            shapeGraphic = makeTrianglePath(in: symbolFrame)
        }
        return shapeGraphic
    }
    
    private func makeCirclePath(in frame : CGRect) -> UIBezierPath {
        let center = CGPoint(x: frame.midX, y: frame.midY)
        let radius = frame.height > frame.width ? frame.width / 2 : frame.height / 2
        return UIBezierPath(arcCenter: center,
                            radius: radius,
                            startAngle: CGFloat.zero,
                            endAngle: 2 * CGFloat.pi,
                            clockwise: true)
    }
    
    private func makeSquarePath(in frame: CGRect) -> UIBezierPath  {
        let sideLength = frame.height > frame.width ? frame.width : frame.height
        let origin = CGPoint(x: frame.midX - sideLength / 2.0, y: frame.midY - sideLength / 2.0)
        let size = CGSize(width: sideLength, height: sideLength)
        let square = CGRect(origin: origin, size: size)
        return UIBezierPath(rect: square)
    }
    
    private func makeTrianglePath(in frame: CGRect) -> UIBezierPath {
        let trianglePath = UIBezierPath()
        let triangleHeight = frame.height > frame.width ? frame.width : frame.height
        let sideLength = (2 * triangleHeight) / sqrt(3.0)
        let startingYPosition = CGFloat(frame.midY - 0.5 * triangleHeight)
        let topPoint = CGPoint(x: frame.midX, y: startingYPosition)
        trianglePath.move(to: topPoint)
        let bottomLeftPoint = CGPoint(x: frame.midX - 0.5 * sideLength, y: startingYPosition + triangleHeight)
        trianglePath.addLine(to: bottomLeftPoint)
        let bottomRightPoint = CGPoint(x: frame.midX + 0.5 * sideLength, y: startingYPosition + triangleHeight)
        trianglePath.addLine(to: bottomRightPoint)
        trianglePath.close()
        return trianglePath
    }
}

extension SetCardView {
    private struct SizeRatios {
        static let numberOfLinesRatio : CGFloat = 0.02
        static let drawingAreaToBoundsRatio: CGFloat = 0.8
        static let circleRadiusToBoundsSizeRatio: CGFloat = 0.5
        static let cornerRadiusToBoundsHeight : CGFloat = 0.06
        static let cornerFontSizeToBoundsHeight : CGFloat = 0.085
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
    }
    
    private var numberOfLines : CGFloat {
        return bounds.height * SizeRatios.numberOfLinesRatio
    }
    
    private var interSymbolInset: CGSize {
        return CGSize(width: 5, height: 5)
    }
    
    private var symbolDrawingArea: CGRect {
        let size = CGSize(width: bounds.width * SizeRatios.drawingAreaToBoundsRatio,
                          height: bounds.height * SizeRatios.drawingAreaToBoundsRatio)
        let origin = CGPoint(x: bounds.midX - size.width / 2.0, y: bounds.midY - size.height / 2.0)
        return CGRect(origin: origin, size: size)
    }
    
    private var centerOfBounds: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var radius: CGFloat {
        let smallestDimension = min(bounds.size.height, bounds.size.width)
        return smallestDimension * SizeRatios.circleRadiusToBoundsSizeRatio
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
