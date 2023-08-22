//
//  PercentLabel.swift
//  FashionApp
//
//  Created by Andrey on 20.08.23.
//

import UIKit


class PercentLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
