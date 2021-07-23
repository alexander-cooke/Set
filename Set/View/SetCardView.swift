//
//  SetCardView.swift
//  Set
//
//  Created by Alex Cooke on 13/7/21.
//

import UIKit

struct SetCardViewModel {
    var number = 1
    var colour = Colours.Primary.blue
    var shape = SetCardView.Shape.square
    var shading = SetCardView.Shading.fill
    var isSelectedAndMatched = false
    var isHint = false
}

class SetCardView: UIButton {
    var viewModel : SetCardViewModel! {didSet {setNeedsDisplay()}}

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
        self.contentMode = .redraw
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawBackgroundOfCard()
        drawBorderOfCard()
        drawFaceOfCard()
    }
    
    private func drawBackgroundOfCard() {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundRect.addClip()
        Colours.Primary.bg.setFill()
        roundRect.fill()
    }
    
    private func drawBorderOfCard() {
        let borderPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        var borderColour = isSelected ? Colours.Border.selected : UIColor.clear
        borderColour = viewModel.isHint ? Colours.Border.hint : borderColour
        borderColour = viewModel.isSelectedAndMatched ? Colours.Border.matched : borderColour
        borderColour.setStroke()
        borderPath.lineWidth = 10
        borderPath.stroke()
    }
    
    private func drawFaceOfCard() {
        // Get grid size based on cardinality and dimensions of bounds
        let (rows, columns) = bounds.width > bounds.height ? (1, viewModel.number) : (viewModel.number, 1)
        let grid = Grid(layout: .dimensions(rowCount: rows, columnCount: columns), frame: bounds.zoom(by: 0.85))
        for idx in 0..<viewModel.number {
            if let symbolFrame = grid[idx]?.inset(by: interSymbolSpacing) {
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
        
        switch viewModel.shading {
        case .fill:
            viewModel.colour.setFill()
            path.fill()
        case .outline:
            viewModel.colour.setStroke()
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
            viewModel.colour.setStroke()
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
        switch viewModel.shape {
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
        static let cornerRadiusToBoundsHeight : CGFloat = 0.06
    }
    
    private var numberOfLines : CGFloat {
        return bounds.height * SizeRatios.numberOfLinesRatio
    }

    private var interSymbolSpacing: CGSize {
        return CGSize(width: 5, height: 5)
    }

    private var cornerRadius : CGFloat {
        bounds.size.height * SizeRatios.cornerRadiusToBoundsHeight
    }
}

extension CGRect {
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }

    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

