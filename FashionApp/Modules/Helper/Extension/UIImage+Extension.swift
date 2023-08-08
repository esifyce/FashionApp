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
    
    enum PayWall {
        public static var closeIcon: UIImage = .init(named: "close")!
        public static var logo: UIImage = .init(named: "payWallLogo")!
    }
}

extension CGFloat {
    var autoIpadHeightSize: CGFloat { return UIScreen.main.bounds.height * self / 1194 }
    var autoIpadHeightLandscapeSize: CGFloat { return UIScreen.main.bounds.width * self / 1194 }
    var autoIphoneHeightSize: CGFloat { return UIScreen.main.bounds.height * self / 844.0 }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}


extension Array where Element: UIView {
    func toStackView(axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 0, distibution: UIStackView.Distribution = .fillEqually, alignment: UIStackView.Alignment = .leading) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distibution
        stackView.spacing = spacing
        for element in self {
            stackView.addArrangedSubview(element)
        }
        
        return stackView
    }
}

extension CALayer {
  func applyFigmaShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    masksToBounds = true
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
