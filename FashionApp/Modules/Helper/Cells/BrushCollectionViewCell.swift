//
//  BrushCollectionViewCell.swift
//  FashionApp
//
//  Created by Krasivo on 22.08.2023.
//

import UIKit
import SnapKit

extension BrushCollectionViewCell {
    struct Appearance {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    }
}

final class BrushCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    var penTapCallBack: (() -> Void)?
    let appearance: Appearance
    
    // MARK: - Views
    
    private lazy var penButton: UIButton = {
        let button = UIButton(type: .system)
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
    
    func configureCell(viewModel: BrushViewModel) {
        penButton.setImage(viewModel.image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}

// MARK: - private BrushCollectionViewCell

private extension BrushCollectionViewCell {
    func configureUI() {
        addViews()
        addConstraints()
        addTargets()
    }
    
    func addViews() {
        [penButton].forEach({ contentView.addSubview($0) })
    }
    
    func addConstraints() {
        penButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {

    }
}
