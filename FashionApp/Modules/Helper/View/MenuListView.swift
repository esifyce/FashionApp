//
//  MenuListView.swift
//  FashionApp
//
//  Created by Krasivo on 22.08.2023.
//

import UIKit
import SnapKit

class MenuListView: UIView {
    
    // MARK: - Views

    private lazy var clothesMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.Menu.clothesMenu.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var standartBrushMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.Menu.standartBrushMenu.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var customBrushMenuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.Menu.customBrushMenu.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var stackContainer: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [clothesMenuButton, standartBrushMenuButton, customBrushMenuButton])
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MenuListView {
    func configureUI() {
        addViews()
        addTargets()
        addConstrains()
    }
    
    func addViews() {
        self.addSubview(stackContainer)
    }
    
    func addConstrains() {
        clothesMenuButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        
        standartBrushMenuButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        
        customBrushMenuButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
    
        stackContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        clothesMenuButton.addAction(UIAction(handler: { _ in
            print("1")
        }), for: .touchUpInside)
        
        standartBrushMenuButton.addAction(UIAction(handler: { _ in
            print("2")
        }), for: .touchUpInside)
        
        customBrushMenuButton.addAction(UIAction(handler: { _ in
            print("3")
        }), for: .touchUpInside)
    }
}

