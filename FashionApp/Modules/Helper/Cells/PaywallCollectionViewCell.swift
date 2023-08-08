//
//  PaywallCollectionViewCell.swift
//  FashionApp
//
//  Created by Krasivo on 05.08.2023.
//

import UIKit
import SnapKit

class PaywallCollectionViewCell: UICollectionViewCell {
    // MARK: - Views
    
    private lazy var upgradeListImageView: UIImageView = {
        UIImageView()
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Upgrade Now!"
        titleLabel.textColor = UIColor.mainColor
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 2
        let attributedString = NSMutableAttributedString(string: "Unlock all features \n and content")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        titleLabel.attributedText = attributedString
        titleLabel.textAlignment = .center
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

// MARK: - private PaywallCollectionViewCell

private extension PaywallCollectionViewCell {
    func configureUI() {
        addViews()
        addContraints()
        configStyle()
        configureDevice()
    }
    
    func addViews() {
        [upgradeListImageView, titleLabel, subTitleLabel].forEach({ contentView.addSubview($0) })

    }
    
    func addContraints() {
        upgradeListImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
        }
    
        titleLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(upgradeListImageView.snp.bottom).offset(24)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    func configStyle() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGrayColor.cgColor
    }
    
    func configureDevice() {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        titleLabel.font = UIFont.systemFont(ofSize: isIpad ? 22 : 18, weight: isIpad ? .semibold : .bold)
        upgradeListImageView.image =  isIpad ? .Ipad.upgradeListIcon : .Iphone.upgradeListIcon
    }
}
