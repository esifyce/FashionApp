//
//  LayerActionView.swift
//  FashionApp
//
//  Created by Andrey on 20.08.23.
//

import UIKit
import SnapKit


final class LayerActionView: UIView {
    private var isTapped = false
    private var callBack: (() -> ())?
    private var normalImage = UIImage()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage,
               text: String,
               callBack: @escaping () -> ()) {
        self.normalImage = image
        imageView.image = self.normalImage
        titleLabel.text = text
        self.callBack = callBack
    }
}

private extension LayerActionView {
    func setupUI() {
        backgroundColor = UIColor.lightGrayColor
        layer.cornerRadius = 13
        addSubviews()
        makeConstraints()
        setupAction()
    }
    
    func addSubviews() {
        [imageView, titleLabel].forEach({addSubview($0)})
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.centerY)
            make.leading.equalTo(imageView.snp.trailing).offset(13)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setupAction() {
        isUserInteractionEnabled = true
        let gestureRecoginzer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(gestureRecoginzer)
    }
    
    @objc func tapped() {
        callBack?()
        isTapped.toggle()
        
        if isTapped {
            imageView.tintColor = .white
            titleLabel.textColor = .white
            backgroundColor = UIColor.darkBlueColor
        } else {
            imageView.tintColor = .black
            titleLabel.textColor = .black
            backgroundColor = UIColor.lightGrayColor
        }
    }
}
