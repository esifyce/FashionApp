//
//  CustomActivityIndicator.swift
//  FashionApp
//
//  Created by Andrey on 6.09.23.
//

import UIKit

class CustomActivityIndicator: UIView {
    private var circleLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupIndicator() {
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2),
                                radius: bounds.size.width / 2 - 2,
                                startAngle: 0,
                                endAngle: CGFloat(2 * Double.pi),
                                clockwise: true)
        if circleLayer == nil {
            circleLayer = CAShapeLayer()
            circleLayer?.path = path.cgPath
            circleLayer?.fillColor = nil
            circleLayer?.strokeColor = UIColor.mainColor.cgColor
            circleLayer?.lineWidth = 5
            circleLayer?.strokeEnd = 0.30
            circleLayer?.lineCap = .round
            guard let circleLayer else { return }
            layer.addSublayer(circleLayer)
        }
    }
    
    func animate() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        }) { (completed) in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.transform = CGAffineTransform(rotationAngle: 0)
            }) { (completed) in
                self.animate()
            }
        }
    }
    
    func stopAnimation() {
        removeFromSuperview()
    }
}
