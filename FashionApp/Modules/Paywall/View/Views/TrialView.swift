//
//  TrialView.swift
//  FashionApp
//
//  Created by Andrey on 8.08.23.
//

import UIKit
import FrameBuilder


final class TrialView: UIView {
    var startCallBack: (() -> ())?
    var seeOtherCallBack: (() -> ())?
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start 3-Day Free Trial", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(rgb: 0x1777F0)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var seeOtherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See other plan", for: .normal)
        button.setTitleColor(UIColor(rgb: 0xCACBD0), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(seeOtherButtonTapped), for: .touchUpInside)
        return button
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

private extension TrialView {
    func setupUI() {
        backgroundColor = .white
        addSubviews()
        makeLayout()
    }
    
    func addSubviews() {
        [startButton, seeOtherButton].forEach({ addSubview($0) })
    }
    
    func makeLayout() {
        startButton.buildFrame(
            FrameBuilder()
                .x(24)
                .top(equalTo: .top, ofView: self, withOffset: 16)
                .width(bounds.size.width - 48)
                .height(56)
        )

        seeOtherButton.buildFrame(
            FrameBuilder()
                .top(equalTo: .bottom, ofView: startButton, withOffset: 24)
                .centerXToCenterX(ofView: self, offset: -50)
                .width(100)
                .height(24)
        )
    }
}

@objc
private extension TrialView {
    func startButtonTapped() {
        startCallBack?()
    }
    
    func seeOtherButtonTapped() {
        seeOtherCallBack?()
    }
}
