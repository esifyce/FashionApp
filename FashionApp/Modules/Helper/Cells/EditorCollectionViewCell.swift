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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        [].forEach({ contentView.addSubview($0) })
    }
    
    func addContraints() {
    }
    
    func configStyle() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.lightGrayColor.cgColor
    }
}
