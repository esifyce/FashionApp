//
//  WeeklyView.swift
//  FashionApp
//
//  Created by Andrey on 8.08.23.
//

import UIKit

enum Plan {
    case weekly
    case lifetime
}

class WeeklyView: UIView {
    
    
    private lazy var circleView: CircleWithInnerCircleView = {
        let circleView = CircleWithInnerCircleView()
        circleView.hasInnerCircle = false
        return circleView
    }()
    
    private lazy var boldLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(rgb: 0x1C1C1C)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(rgb: 0x1C1C1C)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeRounded()
        applyShadow()
    }
    
    func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        [circleView, boldLabel, priceLabel].forEach({addSubview($0)})
    }
    
    func makeConstraints() {
        circleView.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        boldLabel.snp.makeConstraints { make in
            make.centerY.equalTo(circleView.snp.centerY)
            make.leading.equalTo(circleView.snp.trailing).offset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(circleView.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func makeRounded() {
        layer.cornerRadius = 16
    }
    
    func applyShadow() {
        layer.applyFigmaShadow(color: UIColor(rgb: 0x1C1C1C), alpha: 0.12, x: 0, y: 0, blur: 16, spread: 0)
    }
    
    func update(text: String, price: String) {
        boldLabel.text = text
        priceLabel.text = price
    }
    
    func customize() {
        layer.borderColor = UIColor(rgb: 0x1777F0).cgColor
        layer.borderWidth = 2
        circleView.hasInnerCircle = true
    }
    
    func uncustomize() {
        layer.borderColor = nil
        layer.borderWidth = 0
        circleView.hasInnerCircle = false
    }
}
