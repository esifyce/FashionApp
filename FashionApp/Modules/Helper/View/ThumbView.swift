//
//  ThumbView.swift
//  FashionApp
//
//  Created by Andrey on 20.08.23.
//

import UIKit
import FrameBuilder

class ThumbView: UIView {
    // Custom properties and methods will go here

    var innerCircleColor: UIColor = .green {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        let center = CGPoint(x: bounds.midX, y: bounds.midY)

        let outerRadius = min(bounds.width, bounds.height) / 2.0
        let innerRadius = outerRadius - 3

        let outerCirclePath = UIBezierPath(arcCenter: center, radius: outerRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        UIColor.white.setFill()
        outerCirclePath.fill()
        
        let innerCirclePath = UIBezierPath(arcCenter: center, radius: innerRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        innerCircleColor.setFill()
        innerCirclePath.fill()
    }
}
