//
//  UIColor+Extension.swift
//  FashionApp
//
//  Created by Krasivo on 08.08.2023.
//

import UIKit

extension UIColor {
    static var backgroundColor: UIColor = UIColor(rgb: 0xFFFFFF)
    static var mainColor: UIColor = UIColor(rgb: 0x1777F0)
    static var darkGrayColor: UIColor = UIColor(rgb: 0x66676B)
    static var blackColor: UIColor = UIColor(rgb: 0x050505)
    static var redColor: UIColor = UIColor(rgb: 0xFF3B30)
    static var lightGrayColor: UIColor = UIColor(rgb: 0xE4E5EA)
    static var separatorColor: UIColor = UIColor(rgb: 0x3C3C43).withAlphaComponent(0.36)

    
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
