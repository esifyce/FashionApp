//
//  LayersView.swift
//  FashionApp
//
//  Created by Krasivo on 20.08.2023.
//

import UIKit
import SnapKit

extension LayersView {
    struct Appearance {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    }
}

final class LayersView: UIView {
    
    // MARK: - Property
    
    private let appearance: Appearance
    private let collectionManager: LayersCollectionManagerProtocol
    
    // MARK: - Views
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.borderColor.cgColor
        view.layer.cornerRadius = 13
        return view
    }()
    
    private lazy var cornerImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage.Base.cornerIcon
        return imageView
    }()
    
    private lazy var plusLayerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.Base.plusIcon, for: .normal)
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
        collectionManager = LayersCollectionManager()
        super.init(frame: frame)
        injectCollection()
        configureUI()
        collectionManager.displaySquareEditors([.init(layerName: "Layers 445"),
                                                .init(layerName: "Layers 445"),
                                                .init(layerName: "Layers 445"),
                                                .init(layerName: "Layers 445"),
                                                .init(layerName: "Layers 445")])
    }
    
    required init?(coder aDecoder: NSCoder) {
        appearance = Appearance()
        collectionManager = LayersCollectionManager()
        super.init(coder: aDecoder)
    }
    
    // MARK: - Helpers
    
    func show(_ isShow: Bool) {
        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
             self.alpha = isShow ? 1.0 : 0.0
         }.startAnimation()
         
         self.isHidden = !isShow
    }
}

// MARK: - Private extension

private extension LayersView {
    func configureUI() {
        self.alpha = 0
        self.backgroundColor = .white
        mainView.layer.applyFigmaShadow(color: .shadowColor, alpha: 0.2, x: 4, y: 0, blur: 40)
        addViews()
        addConstraints()
        addTargets()
    }
    
    func injectCollection() {
        collectionManager.injectCollection(collectionView)
        collectionManager.injectDelegate(self)
    }
    
    func addViews() {
        [mainView, cornerImageView].forEach({ self.addSubview($0) })
        [plusLayerButton, collectionView].forEach({ mainView.addSubview($0) })
    }
    
    func addConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.directionalVerticalEdges.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
        }
        
        cornerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(appearance.isIpad ? 21 : 38)
            make.trailing.equalToSuperview()
            make.height.equalTo(47)
            make.width.equalTo(13)
        }
        
        plusLayerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(appearance.isIpad ? 37 : 29)
            make.top.equalToSuperview().inset(appearance.isIpad ? 35 : 22)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(plusLayerButton.snp.bottom).offset(appearance.isIpad ? 36 : 15)
            make.bottom.directionalHorizontalEdges.equalToSuperview()
        }
        
    }
    
    func addTargets() {
        plusLayerButton.addAction(UIAction(handler: { _ in
            print("addLayer")
        }), for: .touchUpInside)
    }
}

extension LayersView: LayersCollectionManagerDelegate {
    
}