//
//  AddCollectionViewCell.swift
//  FashionApp
//
//  Created by Krasivo on 05.08.2023.
//

import UIKit
import SnapKit

class AddCollectionViewCell: UICollectionViewCell {
    // MARK: - Views
    
    private lazy var plusImageView: UIImageView = {
        let plusImageView = UIImageView(frame: .init(x: 0, y: 0, width: 47, height: 47))
        plusImageView.image = UIImage.Base.plusIcon
        return plusImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "New Project"
        titleLabel.textColor = UIColor.mainColor
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.numberOfLines = 1
        return titleLabel
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

// MARK: - private AddCollectionViewCell

private extension AddCollectionViewCell {
    func configureUI() {
        addViews()
        addContraints()
        configStyle()
        configureDevice()
    }
    
    func addViews() {
        [plusImageView, titleLabel].forEach({ contentView.addSubview($0) })
    }
    
    func addContraints() {
        
        plusImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
            make.size.equalTo(47)
        }
    
        titleLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(plusImageView.snp.bottom).offset(16)
        }
    }
    
    func configStyle() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.mainColor.cgColor
    }
    
    func configureDevice() {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        titleLabel.font = UIFont.systemFont(ofSize: isIpad ? 22 : 18,
                                            weight: isIpad ? .semibold : .bold)
    }
}
