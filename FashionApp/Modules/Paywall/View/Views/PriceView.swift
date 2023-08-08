//
//  PriceView.swift
//  FashionApp
//
//  Created by Andrey on 7.08.23.
//

import UIKit
import FrameBuilder
import SnapKit

extension PriceView {
    struct Appearance {
        let blueColor: UIColor = UIColor(rgb: 0x1777F0)
        let grayColor: UIColor = UIColor(rgb: 0x66676B)
    }
}

final class PriceView: UIView {
    let appearance = Appearance()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = appearance.grayColor
        label.text = "Then US $24,99/year. Billed yearly, Cancel anytime"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAtributes()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setupAtributes() {
        let partOne = NSMutableAttributedString(string: "Only US $0,99 • ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor: appearance.blueColor])
        let partTwo = NSMutableAttributedString(string: "57% off", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .heavy), .foregroundColor: appearance.blueColor])
        let attributedString = NSMutableAttributedString("")
        attributedString.append(partOne)
        attributedString.append(partTwo)
        
        titleLabel.attributedText = attributedString
    }
}

private extension PriceView {
    func setupUI() {
        addSubviews()
        makeConstraints()
        makeBorder()
    }
    
    func addSubviews() {
        [titleLabel, subtitleLabel].forEach({addSubview($0)})
    }
    
    func makeConstraints() {
        titleLabel.buildFrame(
            FrameBuilder()
                .x(46)
                .top(equalTo: .top, ofView: self, withOffset: 8)
                .width(frame.size.width - 92)
                .height(24)
        )

        subtitleLabel.buildFrame(
            FrameBuilder()
                .x(11.5)
                .top(equalTo: .bottom, ofView: titleLabel, withOffset: 4)
                .width(frame.size.width - 23)
                .height(22)
        )
    }
    
    func makeBorder() {
        layer.cornerRadius = 16
        layer.borderColor = appearance.blueColor.cgColor
        layer.borderWidth = 2
    }
}



