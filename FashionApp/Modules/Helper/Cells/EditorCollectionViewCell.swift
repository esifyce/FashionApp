//
//  EditorCollectionViewCell.swift
//  FashionApp
//
//  Created by Krasivo on 08.08.2023.
//

import UIKit
import SnapKit

extension EditorCollectionViewCell {
    struct Appearance {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    }
}

final class EditorCollectionViewCell: UICollectionViewCell {
    // MARK: - Property
    let appearance: Appearance
    
    // MARK: - Views
    
    private lazy var dressImage: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var selectedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Base.ckeckmarkYesIcon
        imageView.isHidden = true
         return imageView
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
    
    func configureCell(model: EditorViewModel) {
        dressImage.image = UIImage(named: model.previewDress)
        dressImage.contentMode = .scaleAspectFill
        selectedImage.isHidden = !model.isSelectedImage
    }
}

// MARK: - private EditorCollectionViewCell

private extension EditorCollectionViewCell {
    func configureUI() {
        addViews()
        addContraints()
        configStyle()
    }
    
    func addViews() {
        [dressImage].forEach({ contentView.addSubview($0) })
        dressImage.addSubview(selectedImage)
    }
    
    func addContraints() {
        dressImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
            make.width.equalTo(contentView.bounds.width)
            make.height.equalTo(contentView.bounds.height)
        }
        
        selectedImage.snp.makeConstraints { make in
            make.size.equalTo(appearance.isIpad ? 53 : 43)
            make.center.equalToSuperview()
        }
        
    }
    
    func configStyle() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.lightGrayColor.cgColor
    }
}
