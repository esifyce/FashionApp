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
    var autoIpadHeightSize: CGFloat { return UIScreen.main.bounds.height * self / 1194 }
    var autoIpadHeightLandscapeSize: CGFloat { return UIScreen.main.bounds.width * self / 1194 }
    var autoIphoneHeightSize: CGFloat { return UIScreen.main.bounds.height * self / 844.0 }
}
