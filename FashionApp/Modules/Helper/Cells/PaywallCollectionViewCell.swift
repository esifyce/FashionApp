//
//  PaywallCollectionViewCell.swift
//  FashionApp
//
//  Created by Krasivo on 05.08.2023.
//

import UIKit

class PaywallCollectionViewCell: UICollectionViewCell {
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

// MARK: - private PaywallCollectionViewCell

private extension PaywallCollectionViewCell {
    func configureUI() {
        addViews()
        addContraints()
        
        self.backgroundColor = .red
    }
    
    func addViews() {
        
    }
    
    func addContraints() {
        
    }
}
