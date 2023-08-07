//
//  TemplateCollectionViewCell.swift
//  FashionApp
//
//  Created by Krasivo on 05.08.2023.
//

import UIKit

class TemplateCollectionViewCell: UICollectionViewCell {
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


// MARK: - private TemplateCollectionViewCell

private extension TemplateCollectionViewCell {
    func configureUI() {
        addViews()
        addContraints()
        self.backgroundColor = .green
    }
    
    func addViews() {
        
    }
    
    func addContraints() {
        
    }
}
