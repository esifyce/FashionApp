//
//  UIImage+Extension.swift
//  FashionApp
//
//  Created by Krasivo on 06.08.2023.
//

import UIKit

extension UIImage {
    enum Base {
        public static var infoIcon: UIImage = .init(named: "infoBar")!
        public static var settingIcon: UIImage = .init(named: "settingBar")!
    }
}

extension CGFloat {
    var autoHeightSize: CGFloat { return UIScreen.main.bounds.height * self / 844.0 }
    var autoWidthSize: CGFloat { return UIScreen.main.bounds.width * self / 390.0 }
}
