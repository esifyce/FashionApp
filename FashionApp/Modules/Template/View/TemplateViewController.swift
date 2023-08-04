//
//  TemplateViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class TemplateViewController: BaseViewController {
    // MARK: - Property
    var presenter: TemplatePresenterInput?
    
    // MARK: - Views

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defer { presenter?.viewDidLoad() }
        setupUI()
        
    }
}

// MARK: - TemplateViewControllerInput
extension TemplateViewController: TemplateViewControllerInput {

}

// MARK: - fileprivate TemplateViewController
fileprivate extension TemplateViewController {
    func setupUI() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        
    }
    
    func setConstraints() {
        
    }
}
