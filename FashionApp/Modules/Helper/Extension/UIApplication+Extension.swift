//
//  UIApplication+Extension.swift
//  FashionApp
//
//  Created by Andrey on 8.08.23.
//

import UIKit


extension UIApplication {
    var isLandscape: Bool {
        if UIDevice.current.orientation == .unknown {
            if let orientation = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.windowScene?.interfaceOrientation {
                if orientation == .landscapeLeft || orientation == .landscapeRight {
                    return true
                }
            }
        }
        
        return UIDevice.current.orientation.isLandscape
    }
}
