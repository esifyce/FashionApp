//
//  ClothesView.swift
//  FashionApp
//
//  Created by Krasivo on 28.08.2023.
//

import UIKit
import SnapKit

extension ClothesView {
    struct Appearance {
        
    }
}

protocol ClothesViewDelegate: AnyObject {
    func closeTapped()
}

final class ClothesView: UIView {
    
    // MARK: - Property
    
    private let appearance: Appearance
    weak var delegate: ClothesViewDelegate?
    
    // MARK: - Views
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGrayColor
        view.clipsToBounds = false
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.Menu.closeMenu.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let categoryClothes: StatusBar = {
        StatusBar()
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        appearance = Appearance()
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - private ClothesView

private extension ClothesView {
    func configureUI() {
        addViews()
        addConstraints()
        addTargets()
    }
    
    func addViews() {
        self.addSubview(containerView)
        [closeButton, categoryClothes].forEach({ containerView.addSubview($0) })
    }
    
    func addConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.leading.equalToSuperview().inset(8)
            make.top.equalToSuperview()
        }
        
        categoryClothes.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalToSuperview()
            make.leading.equalTo(closeButton.snp.trailing)
            make.trailing.equalToSuperview()
        }
    }
    
    func addTargets() {
        closeButton.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.closeTapped()
        }), for: .touchUpInside)
    }
}
