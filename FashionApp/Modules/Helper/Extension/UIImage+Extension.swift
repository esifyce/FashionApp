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
        public static var skinIcon: UIImage = .init(named: "skinTemplate")!
        public static var skinIcon2: UIImage = .init(named: "skinTemplate2")!
        public static var leftStepIcon: UIImage = .init(named: "leftStep")!
        public static var rightStepIcon: UIImage = .init(named: "rightStep")!
        public static var stackIcon: UIImage = .init(named: "stack")!
        public static var backDrawingIcon: UIImage = .init(named: "backDrawing")!
        public static var ckeckmarkYesIcon: UIImage = .init(named: "ckeckmarkYes")!
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
        public static var upgradeList: UIImage = .init(named: "phoneUpgradeList")!
    }
    
    enum Clothes: Int, CustomStringConvertible {
        case hair = 0
        case pants
        case shoes
        case dress
        
        var getClothes: [String] {
            switch self {
            case .shoes:
                return ["shoes1", "shoes2", "shoes3", "shoes4", "shoes5"]
            case .hair:
                return ["hair1", "hair2", "hair3", "hair4", "hair5"]
            case .pants:
                return ["pants1", "pants2", "pants3", "pants4"]
            case .dress:
                return ["dress1", "dress2", "dress3", "dress4"]
            }
        }
        
        var description: String {
            switch self {
            case .shoes:
                return "Shoes"
            case .hair:
                return "Hair"
            case .pants:
                return "Pants"
            case .dress:
                return "Dress"
            }
        }
    }
}
