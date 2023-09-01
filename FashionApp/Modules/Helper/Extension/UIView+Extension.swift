//
//  UIView+Extension.swift
//  FashionApp
//
//  Created by Andrey on 20.08.23.
//

import UIKit

extension UIView {
 
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let capturedImage = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return capturedImage
    }
    
    func setAnchorPoint(anchorPoint: CGPoint) {
        let oldOrigin = frame.origin
        layer.anchorPoint = anchorPoint
        let newOrigin = frame.origin
        
        let transition: CGPoint = CGPoint(x: newOrigin.x - oldOrigin.x, y: newOrigin.y - oldOrigin.y)
        center = CGPoint(x: center.x - transition.x, y: center.y - transition.y)
    }
}
