//
//  String+Extension.swift
//  FashionApp
//
//  Created by Andrey on 8.08.23.
//

import UIKit

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
    
    func truncateAfterDot() -> String {
        if let dotRange = self.range(of: ".") {
            let dotIndex = self.distance(from: self.startIndex, to: dotRange.upperBound)
            
            if dotIndex < self.count {
                let endIndex = self.index(self.startIndex, offsetBy: dotIndex)
                return String(self[..<endIndex])
            }
        }
        
        return self
    }
}
