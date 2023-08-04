//
//  PaywallViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class PaywallViewController: BaseViewController {
    // MARK: - Property
    var presenter: PaywallPresenterInput?
    
    // MARK: - Views

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defer { presenter?.viewDidLoad() }
        setupUI()
        
    }
}

// MARK: - PaywallViewControllerInput
extension PaywallViewController: PaywallViewControllerInput {

}

// MARK: - fileprivate PaywallViewController
fileprivate extension PaywallViewController {
    func setupUI() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        
    }
    
    func setConstraints() {
        
    }
}
