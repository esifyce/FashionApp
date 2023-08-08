//
//  CustomLineView.swift
//  FashionApp
//
//  Created by Andrey on 8.08.23.
//

import UIKit
import FrameBuilder

final class CustomLineView: UIView {
    private lazy var rectangle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x1777F0).withAlphaComponent(0.15)
        view.layer.cornerRadius = 3
        return view
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
    
    func setupUI() {
        addSubview(rectangle)
        rectangle.buildFrame(
            FrameBuilder()
                .x(5)
                .top(equalTo: .top, ofView: self)
                .width(bounds.size.width - 10)
                .height(bounds.size.height)
        )
        
        let view1 = UIView()
        view1.backgroundColor = UIColor(rgb: 0x1777F0)
        addSubview(view1)
        view1.buildFrame(
            FrameBuilder()
                .x(0)
                .top(equalTo: .top, ofView: self, withOffset: 17)
                .width(16)
                .height(16)
        )
        view1.layer.cornerRadius = 8
        
        let view2 = UIView()
        view2.backgroundColor = UIColor(rgb: 0x1777F0)
        addSubview(view2)
        view2.buildFrame(
            FrameBuilder()
                .x(0)
                .top(equalTo: .bottom, ofView: view1, withOffset: 69)
                .width(16)
                .height(16)
        )
        view2.layer.cornerRadius = 8
        
        let view3 = UIView()
        view3.backgroundColor = UIColor(rgb: 0x1777F0)
        addSubview(view3)
        view3.buildFrame(
            FrameBuilder()
                .x(0)
                .top(equalTo: .bottom, ofView: view2, withOffset: 80)
                .width(16)
                .height(16)
        )
        view3.layer.cornerRadius = 8
    }
}
