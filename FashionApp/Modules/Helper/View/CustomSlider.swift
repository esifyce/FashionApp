//
//  BlueSlider.swift
//  FashionApp
//
//  Created by Andrey on 20.08.23.
//

import UIKit

enum SliderType {
    case opacity, size
}


class CustomSlider: UISlider {
    let gradientLayer = CAGradientLayer()
    let baseLayer = CALayer()
    
    var backgroundValueColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var gradientColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var thumbImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    
    private func setup() {
        clear()
        createBaseLayer()
        setThumbImage()
    }
    
    private func clear() {
        tintColor = .clear
        maximumTrackTintColor = .clear
        backgroundColor = .clear
        thumbTintColor = .clear
    }
    
    private func createBaseLayer() {
        baseLayer.removeFromSuperlayer()
        baseLayer.masksToBounds = true
        baseLayer.frame = .init(x: 0, y: 0, width: frame.width, height: frame.height)
        baseLayer.cornerRadius = baseLayer.frame.height / 2
        self.layer.insertSublayer(baseLayer, at: 0)

        if let gradientColor {
            gradientLayer.removeFromSuperlayer()
            gradientLayer.frame = baseLayer.frame
            gradientLayer.cornerRadius = baseLayer.frame.height / 2
            
            let startColor = gradientColor.withAlphaComponent(0).cgColor
            let endColor = gradientColor.withAlphaComponent(1).cgColor
            gradientLayer.colors = [startColor, endColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            self.layer.insertSublayer(gradientLayer, at: 1)
        }
        
        if let backgroundValueColor {
            gradientLayer.removeFromSuperlayer()
            baseLayer.backgroundColor = backgroundValueColor.cgColor
        }
        
    }
    
    private func setThumbImage() {
        let view = ThumbView()
        view.frame = .init(x: 0, y: 0, width: frame.size.height - 4, height: frame.size.height - 4)
        view.innerCircleColor = gradientColor ?? .clear
        setThumbImage(view.snapshot, for: .normal)
        setThumbImage(view.snapshot, for: .focused)
        setThumbImage(view.snapshot, for: .highlighted)
    }
}
