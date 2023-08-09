//
//  EditorCollectionViewCell.swift
//  FashionApp
//
//  Created by Krasivo on 08.08.2023.
//

import UIKit
import SnapKit

class EditorCollectionViewCell: UICollectionViewCell {
    // MARK: - Property
    
    // MARK: - Views
    
    private lazy var dressImage: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: EditorViewModel) {
        dressImage.image = UIImage(named: model.dressName)
        dressImage.contentMode = .scaleToFill
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
    }
    
    func addContraints() {
        dressImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
            make.width.equalTo(contentView.bounds.width)
            make.height.equalTo(contentView.bounds.height)
        }
    }
    
    func configStyle() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.lightGrayColor.cgColor
    }
}
