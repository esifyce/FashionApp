//
//  File.swift
//  FashionApp
//
//  Created by Andrey on 8.08.23.
//

import UIKit

class CircleWithInnerCircleView: UIView {
    private let innerCircleLayer: CAShapeLayer = CAShapeLayer()
    private let outerCircleLayer = CAShapeLayer()
    
    var hasInnerCircle: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawCircle()
    }

    private func drawCircle() {
        let circleRadius: CGFloat = min(bounds.width, bounds.height) / 2.0

        // Create the outer circle path with stroke only
        let outerCirclePath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                           radius: circleRadius,
                                           startAngle: 0,
                                           endAngle: CGFloat.pi * 2,
                                           clockwise: true)

        // Create the inner circle path with fill color
        let innerCircleRadius: CGFloat = circleRadius * 0.5
        let innerCirclePath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                           radius: innerCircleRadius,
                                           startAngle: 0,
                                           endAngle: CGFloat.pi * 2,
                                           clockwise: true)

        // Create a CAShapeLayer for the outer circle and set its path with stroke only
        outerCircleLayer.path = outerCirclePath.cgPath
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        outerCircleLayer.strokeColor = UIColor(rgb: 0x1777F0).cgColor
        outerCircleLayer.lineWidth = 2.0

        // Create a CAShapeLayer for the inner circle and set its path with fill color
        
        innerCircleLayer.path = innerCirclePath.cgPath
        innerCircleLayer.fillColor = UIColor(rgb: 0x1777F0).cgColor

        // Add the shape layers to the view's layer
        layer.addSublayer(outerCircleLayer)
        if hasInnerCircle {
            layer.addSublayer(innerCircleLayer)
        } else {
            if innerCircleLayer.superlayer != nil {
                innerCircleLayer.removeFromSuperlayer()
            }
        }
    }
}
