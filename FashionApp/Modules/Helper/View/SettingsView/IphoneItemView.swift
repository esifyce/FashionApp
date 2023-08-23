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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.buildFrame(
            FrameBuilder()
                .x(16)
                .height(20)
                .centerYToCenterY(ofView: self)
        )
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
