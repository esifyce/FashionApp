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
        public static var stackClickedIcon: UIImage = .init(named: "stackClick")!
        public static var backDrawingIcon: UIImage = .init(named: "backDrawing")!
        public static var ckeckmarkYesIcon: UIImage = .init(named: "yesCheckmark")!
        public static var cornerIcon: UIImage = .init(named: "corner")!
        public static var eyeIcon: UIImage = .init(named: "eyeIcon")!
        public static var lineIcon: UIImage = .init(named: "lineIcon")!
        public static var track: UIImage = .init(named: "track")!
        public static var trackLong: UIImage = .init(named: "trackLong")!
        public static var scrubber: UIImage = .init(named: "scrubber")!
        public static var shareSkinPreview: UIImage = .init(named: "shareSkinPreview")!
        public static var downloadSkinPreview: UIImage = .init(named: "downloadSkinPreview")!
    }
    
    enum Iphone {
        public static var upgradeListIcon: UIImage = .init(named: "phoneUpgradeList")!
    }
    
    enum Ipad {
        public static var upgradeListIcon: UIImage = .init(named: "ipadUpgradeList")!
    }
    
    enum Menu {
        public static var standartBrushMenu: UIImage = .init(named: "standartBrushMenu")!
        public static var customBrushMenu: UIImage = .init(named: "customBrushMenu")!
        public static var clothesMenu: UIImage = .init(named: "clothesMenu")!
        public static var closeMenu: UIImage = .init(named: "closeMenu")!
    }
    
    enum PayWall {
        public static var closeIcon: UIImage = .init(named: "close")!
        public static var logo: UIImage = .init(named: "payWallLogo")!
        public static var clockwise: UIImage = .init(named: "clockwise")!
        public static var upgradeList: UIImage = .init(named: "phoneUpgradeList")!
    }
    

    enum Pen {
        public static var penMenu: UIImage = .init(named: "penMenu")!
        public static var pencilMenu: UIImage = .init(named: "pencilMenu")!
        public static var markerMenu: UIImage = .init(named: "markerMenu")!
        public static var feltMenu: UIImage = .init(named: "feltMenu")!
        public static var easicMenu: UIImage = .init(named: "easicMenu")!
    }
    
    enum LayerAction {
        public static var hide: UIImage = .init(named: "hideBlack")!
        public static var lock: UIImage = .init(named: "lockBlack")!
        public static var duplicate: UIImage = .init(named: "duplicateBlack")!
        public static var mergeAll: UIImage = .init(named: "mergeAll")!
        public static var mergePrevious: UIImage = .init(named: "mergePrevious")!
        public static var delete: UIImage = .init(named: "deleteBlack")!
    }
    
    enum Clothes: Int, CustomStringConvertible {
        case hair = 0
        case pants
        case shoes
        case dress
        
        var getClothes: [String] {
            switch self {
            case .shoes:
                return ["shoes1", "shoes2", "shoes3", "shoes4"]
            case .hair:
                return ["hair1", "hair2", "hair3", "hair4", "hair5"]
            case .pants:
                return ["pants1", "pants2", "pants3", "pants4"]
            case .dress:
                return ["dress1", "dress2", "dress3", "dress4"]
            }
        }
        
        var previewClothes: [String] {
            switch self {
            case .shoes:
                return ["previewShoes1", "previewShoes2", "previewShoes3", "previewShoes4"]
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
