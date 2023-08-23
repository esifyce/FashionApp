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
    static var borderColor: UIColor = UIColor(rgb: 0xCACBD0)
    static var shadowColor: UIColor = UIColor(rgb: 0x051C39)
    static var secondGrayColor: UIColor = UIColor(rgb: 0x3C3C43).withAlphaComponent(0.60)
    static var thirdGrayColor: UIColor = UIColor(rgb: 0xD1D1D6)
    static var darkBlueColor: UIColor = UIColor(rgb: 0x0E4790)
    static var blackShadowColor: UIColor = UIColor(rgb: 0x051C39)
    static var systemWhiteColor: UIColor = UIColor(rgb: 0xF2F2F7)
    static var secondBlackColor: UIColor = UIColor(rgb: 0x060606)

    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
