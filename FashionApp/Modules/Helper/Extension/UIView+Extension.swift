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
}
