//
//  LayerCollectionViewCell.swift
//  FashionApp
//
//  Created by Krasivo on 21.08.2023.
//

import UIKit
import SnapKit

extension LayerCollectionViewCell {
    struct Appearance {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let layerFont: UIFont = UIDevice.current.userInterfaceIdiom == .pad ? .systemFont(ofSize: 16) : .systemFont(ofSize: 10)
    }
}

final class LayerCollectionViewCell: UICollectionViewCell {
    // MARK: - Property
    
    var eyeTapCallBack: (() -> Void)?
    let appearance: Appearance
    
    // MARK: - Views
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.borderColor.cgColor
        return view
    }()
    
    private lazy var layerName: UILabel = {
       let label = UILabel()
        label.font = appearance.layerFont
        label.textColor = UIColor.blackColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var layerImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage.Base.lineIcon
        return imageView
    }()
    
    private lazy var visibleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.Base.eyeIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
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
    
    func configureCell(model: LayerViewModel) {
        layerName.text = model.name
    }
    
    override func prepareForReuse() {
        containerView.layer.borderColor = UIColor.borderColor.cgColor
    }
    
    func setSelected() {
        containerView.layer.borderColor =  UIColor.mainColor.cgColor
    }
    
    func setDeselected() {
        containerView.layer.borderColor =  UIColor.borderColor.cgColor
    }
}

private extension LayerCollectionViewCell {
    func configureUI() {
        self.containerView.backgroundColor = .clear
        addViews()
        addConstraints()
        addTargets()
    }
    
    func addViews() {
        contentView.addSubview(containerView)
        [layerName, layerImageView, visibleButton].forEach({ containerView.addSubview($0) })
    }
    
    func addConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        visibleButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.trailing.equalToSuperview().inset(8)
        }
        
        layerImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        layerName.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(appearance.isIpad ? 12 : 8)
        }
    }
    
    func addTargets() {
        visibleButton.addAction(UIAction(handler: { [weak self] _ in
            self?.eyeTapCallBack?()
        }), for: .touchUpInside)
    }
}
