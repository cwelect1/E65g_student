//
//  GridView.swift
//  Assignment3
//
//  Created by Weinberg, Corbett on 3/23/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    @IBInspectable var size: Int = 20 {
        didSet {
            grid = Grid(size, size)
        }
    }
    
    @IBInspectable var livingColor: UIColor = UIColor.darkGray
    @IBInspectable var emptyColor: UIColor   = UIColor.clear
    @IBInspectable var bornColor: UIColor   = UIColor.lightText
    @IBInspectable var diedColor: UIColor   = UIColor.black
    @IBInspectable var gridColor: UIColor   = UIColor.lightGray
    
    @IBInspectable var gridWidth: CGFloat = 0
    
    var grid = Grid(3,3)
    
    override func draw(_ rect: CGRect){
        
        let boxSize = CGSize(
            width: rect.size.width / CGFloat(size),
            height: rect.size.height / CGFloat(size)
        )
        
        let circleSize = CGSize(
            width: (rect.size.width / CGFloat(size)) * 0.90,
            height: (rect.size.height / CGFloat(size)) * 0.90
        )
        
        let base = rect.origin
        (0 ..< size).forEach { i in
            (0 ..< size).forEach { j in
                let origin = CGPoint(
                    x: base.x + ((CGFloat(j) * boxSize.width) + circleSize.height * 0.05),
                    y: base.y + ((CGFloat(i) * boxSize.height) + circleSize.height * 0.05)
                )
                let subRect = CGRect(
                    origin: origin,
                    size: circleSize
                )
                
                //This, of course, is where I am screwing up. I don't understand how to reference a cell in the grid
                switch grid[(i, j)]{
                case .alive:
                    livingColor.setFill()
                case .born:
                    bornColor.setFill()
                case .died:
                    diedColor.setFill()
                case .empty:
                    emptyColor.setFill()
                }
                
                let path = UIBezierPath(ovalIn: subRect)
                path.fill()
            }
        }
        
        //create the path
        (0 ..< size + 1).forEach {
            drawLine(
                start: CGPoint(x: CGFloat($0)/CGFloat(size) * rect.size.width, y: 0.0),
                end:   CGPoint(x: CGFloat($0)/CGFloat(size) * rect.size.width, y: rect.size.height)
            )
            
            drawLine(
                start: CGPoint(x: 0.0, y: CGFloat($0)/CGFloat(size) * rect.size.height ),
                end: CGPoint(x: rect.size.width, y: CGFloat($0)/CGFloat(size) * rect.size.height)
            )
        }
}
    
    func drawLine(start:CGPoint, end: CGPoint) {
        let path = UIBezierPath()
        
        path.lineWidth = gridWidth
        path.move(to: start)
        path.addLine(to: end)
        
        //draw the stroke
        UIColor.black.setStroke()
        path.stroke()
    }
    
    // touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = nil
    }
    
    // Updated since class
    typealias Position = (row: Int, col: Int)
    var lastTouchedPosition: Position?
    
    func process(touches: Set<UITouch>) -> Position? {
        guard touches.count == 1 else { return nil }
        let pos = convert(touch: touches.first!)
        guard lastTouchedPosition?.row != pos.row
            || lastTouchedPosition?.col != pos.col
            else { return pos }
        
        grid[(pos.row, pos.col)] = grid[(pos.row, pos.col)].toggle(state: grid[(pos.row, pos.col)])
        setNeedsDisplay()
        return pos
    }
    
    func convert(touch: UITouch) -> Position {
        let touchY = touch.location(in: self).y
        let gridHeight = frame.size.height
        let row = touchY / gridHeight * CGFloat(size)
        let touchX = touch.location(in: self).x
        let gridWidth = frame.size.width
        let col = touchX / gridWidth * CGFloat(size)
        let position = (row: Int(row), col: Int(col))
        return position
    }
}
