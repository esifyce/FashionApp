//
//  DescriptionView.swift
//  FashionApp
//
//  Created by Andrey on 10.08.23.
//

import UIKit


final class DescriptionView: UIView {
    var stackView: UIStackView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeLayout()
    }
    
    func setupUI() {
        let mappedLabels = [("Today", "Get access to all premium features"),
                           ("Tomorrow", "Start drawing trending designs and growing your audience"),
                            ("In 48 hours", "Well remind you 24 hours before charging your card (if notifications are enabled")].map({ (self.makeLabel(text: $0.0, font: UIFont.systemFont(ofSize: 18, weight: .bold), textColor: UIColor(rgb: 0x050505), number: 1), self.makeLabel(text: $0.1, font: UIFont.systemFont(ofSize: 13), textColor: UIColor(rgb: 0x66676B)))})
        
        let stackViews = mappedLabels.map({ [$0.0, $0.1].toStackView(spacing: 4, distibution: .fill, alignment: .leading)})
        
        stackView = stackViews.toStackView(axis: .vertical, spacing: 24, distibution: .fill, alignment: .leading)
        stackView?.removeFromSuperview()
        guard let stackView else { return } 
        addSubview(stackView)
    }

    func makeLayout() {
        guard let stackView else { return }
        stackView.frame = bounds
    }
    
    func makeLabel(text: String, font: UIFont, textColor: UIColor,  number: Int = 0) -> UILabel {
        let label = UILabel()
        label.font = font
        label.text = text
        label.textColor = textColor
        label.numberOfLines = number
        
        return label
    }
}
