//
//  CGFloat+Extension.swift
//  FashionApp
//
//  Created by Andrey on 8.08.23.
//

import UIKit

extension CGFloat {
    var autoIpadHeightSize: CGFloat { return UIScreen.main.bounds.height * self / 1194 }
    var autoIpadHeightLandscapeSize: CGFloat { return UIScreen.main.bounds.width * self / 1194 }
    var autoIphoneHeightSize: CGFloat { return UIScreen.main.bounds.height * self / 844.0 }
}
