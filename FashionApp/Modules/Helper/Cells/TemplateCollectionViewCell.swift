//
//  TemplateCollectionViewCell.swift
//  FashionApp
//
//  Created by Krasivo on 05.08.2023.
//

import UIKit
import SnapKit

class TemplateCollectionViewCell: UICollectionViewCell {
    // MARK: - Property
    
    var showActionSheetCallback: (() -> Void)?
    
    // MARK: - Views
    
    private lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .system)
        moreButton.setImage(UIImage.Base.dotsIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        moreButton.imageView?.tintColor = UIColor.clear
        moreButton.isUserInteractionEnabled = true
        return moreButton
    }()
    
    private lazy var projectNameLabel: UILabel = {
        let projectNameLabel = UILabel()
        projectNameLabel.text = "Project Name"
        projectNameLabel.textColor = UIColor.darkGrayColor
        projectNameLabel.textAlignment = .center
        projectNameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        projectNameLabel.numberOfLines = 1
        return projectNameLabel
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: MainViewModel?, type: MainCollectionCellType) {
        guard let model else { return }
        if type == .mannequinSquare {
            imageView.image = UIImage(named: model.skin)
        } else {
            imageView.image = Utils().obtainImage(from: model.skin)
        }
        projectNameLabel.text = model.projectName
        moreButton.isHidden = !model.isCanDeleted
    }
}


// MARK: - private TemplateCollectionViewCell

private extension TemplateCollectionViewCell {
    func configureUI() {
        addViews()
        addContraints()
        configStyle()
        configureDevice()
        addTargets()
    }
    
    func addViews() {
        contentView.addSubview(imageView)
        [moreButton, projectNameLabel].forEach({ imageView.addSubview($0) })
    }
    
    func addContraints() {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad

        moreButton.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.top.trailing.equalToSuperview().inset(16)
        }
        
        projectNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(isIpad ? 24 : 16)
            make.directionalHorizontalEdges.equalToSuperview().inset(8)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(contentView.snp.size)
        }
    }
    
    func configStyle() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGrayColor.cgColor
    }
    
    func addTargets() {
        guard UIDevice.current.userInterfaceIdiom == .pad else {
            moreButton.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
//            moreButton.addAction(UIAction(handler: { [weak self] _ in
//                self?.showActionSheetCallback?()
//            }), for: .touchUpInside)
            return
        }
        
        let destruct = UIAction(title: "Delete", attributes: .destructive) { _ in }
                
        let items = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Share", handler: { _ in }),
            UIAction(title: "Rename", handler: { _ in }),
        ])
                
        moreButton.menu = UIMenu(title: "", children: [items, destruct])
        moreButton.showsMenuAsPrimaryAction = true
    }
    
    func configureDevice() {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        projectNameLabel.font = UIFont.systemFont(ofSize: isIpad ? 22 : 18, weight: .semibold)
    }
    
    @objc func moreTapped() {
        showActionSheetCallback?()
    }
}
