//
//  BrushListView.swift
//  FashionApp
//
//  Created by Krasivo on 22.08.2023.
//

import UIKit
import SnapKit

extension BrushListView {
    struct Appearance {
        
    }
}

final class BrushListView: UIView {
    
    // MARK: - Property
    
    private let appearance: Appearance
    private let collectionManager: BrushCollectionManagerProtocol
    
    // MARK: - Views
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.Menu.closeMenu.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var colorPicker: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.applyFigmaShadow(color: UIColor(rgb: 0x000000), alpha: 0.1, x: 0, y: 0, blur: 3, spread: 0)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        appearance = Appearance()
        collectionManager = BrushCollectionManager()
        super.init(frame: frame)
        configureUI()
        injectCollection()
        collectionManager.displaySquareEditors([.init(image: .Pen.penMenu),
                                                .init(image: .Pen.pencilMenu),
                                                .init(image: .Pen.markerMenu),
                                                .init(image: .Pen.feltMenu),
                                                .init(image: .Pen.easicMenu)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - private BrushListView

private extension BrushListView {
    func configureUI() {
        addViews()
        addConstraints()
        addTargets()
    }
    
    func injectCollection() {
        collectionManager.injectCollection(collectionView)
        collectionManager.injectDelegate(self)
    }
    
    func addViews() {
        [closeButton, colorPicker, collectionView].forEach({ self.addSubview($0) })
    }
    
    func addConstraints() {
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.leading.top.equalToSuperview()
        }
        
        colorPicker.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.leading.equalTo(closeButton.snp.trailing).offset(16)
            make.top.equalToSuperview().inset(4)
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.leading.equalTo(colorPicker.snp.trailing).offset(16)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func addTargets() {
        closeButton.addAction(UIAction(handler: { _ in
            
        }), for: .touchUpInside)
        
        colorPicker.addAction(UIAction(handler: { _ in
            
        }), for: .touchUpInside)
    }
}

extension BrushListView: BrushCollectionManagerDelegate {
    
}
