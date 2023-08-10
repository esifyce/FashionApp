//
//  Array+Extension.swift
//  FashionApp
//
//  Created by Andrey on 8.08.23.
//

import UIKit

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
