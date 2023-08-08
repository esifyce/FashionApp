//
//  UIImage+Extension.swift
//  FashionApp
//
//  Created by Krasivo on 06.08.2023.
//

import UIKit
import SnapKit

extension UIImage {
    enum Base {
        public static var infoIcon: UIImage = .init(named: "infoBar")!
        public static var settingIcon: UIImage = .init(named: "settingBar")!
        public static var dotsIcon: UIImage = .init(named: "threeDots")!
        public static var plusIcon: UIImage = .init(named: "plus")!
    }
    
    enum Iphone {
        public static var upgradeListIcon: UIImage = .init(named: "phoneUpgradeList")!
    }
    
    enum Ipad {
        public static var upgradeListIcon: UIImage = .init(named: "ipadUpgradeList")!
    }
    
    enum PayWall {
        public static var closeIcon: UIImage = .init(named: "close")!
        public static var logo: UIImage = .init(named: "payWallLogo")!
        public static var clockwise: UIImage = .init(named: "clockwise")!
        public static var upgradeList: UIImage = .init(named: "upgradeList")!
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

extension UIView {
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 12
        layer.shadowOffset = CGSize(width: 0, height: -8)
        layer.shadowRadius = 16
        layer.shouldRasterize = true
        layer.rasterizationScale =  UIScreen.main.scale
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
    masksToBounds = false
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

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}


extension UIViewController {
    func showCustomView(view: UIView, inWindow: Bool = true) {
        if inWindow {
            let keyWindow: UIWindow? = UIApplication
                .shared
                .windows
                .filter({ $0.isKeyWindow })
                .first
            keyWindow?.addSubview(view)
        } else {
            self.view.addSubview(view)
        }
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
