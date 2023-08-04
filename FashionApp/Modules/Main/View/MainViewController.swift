//
//  MainViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class MainViewController: BaseViewController {
    // MARK: - Property
    var presenter: MainPresenterInput?
    
    // MARK: - Views

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defer { presenter?.viewDidLoad() }
        setupUI()
        
    }
}

// MARK: - MainViewControllerInput
extension MainViewController: MainViewControllerInput {

}

// MARK: - fileprivate MainViewController
fileprivate extension MainViewController {
    func setupUI() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        
    }
    
    func setConstraints() {
        
    }
}
