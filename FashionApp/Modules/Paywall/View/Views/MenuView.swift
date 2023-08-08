//
//  MenuView.swift
//  FashionApp
//
//  Created by Andrey on 7.08.23.
//

import UIKit

extension MenuView {
    struct Appearance {
        let font: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        let spacing: CGFloat = 16
        let blackColor = UIColor(rgb: 0x50505)
    }
}

final class MenuView: UIView {
    let appearance = Appearance()
    
    private lazy var stackView: UIStackView = {
        return [makeLabel(font: appearance.font, text: "👑 Premium fashion templates"),
                makeLabel(font: appearance.font, text: "👙 Premium modular patterns"),
                makeLabel(font: appearance.font, text: "🎨 Premium modular patterns"),
                makeLabel(font: appearance.font, text: "🙌🏻 Save in high quality"),
                makeLabel(font: appearance.font, text: "📆 Weekly update")].toStackView(spacing: appearance.spacing)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
}

private extension MenuView {
    func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        addSubview(stackView)
    }
    
    func makeConstraints() {
        stackView.frame = bounds
    }
    
    func makeLabel(font: UIFont, text: String, alignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.textColor = appearance.blackColor
        label.text = text
        label.font = font
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.backgroundColor = .clear
        
        return label
    }
}
