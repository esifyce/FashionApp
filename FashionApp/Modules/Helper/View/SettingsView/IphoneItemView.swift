//
//  IphoneItemView.swift
//  FashionApp
//
//  Created by Andrey on 22.08.23.
//

import UIKit
import FrameBuilder


final class IphoneItemView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor.blackColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.frame = CGRect(x: 16, y: 12, width: bounds.width - 32, height: 20)
        layer.cornerRadius = 13
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
