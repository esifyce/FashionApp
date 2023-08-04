//
//  EditorViewController.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class EditorViewController: BaseViewController {
    // MARK: - Property
    var presenter: EditorPresenterInput?
    
    // MARK: - Views

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defer { presenter?.viewDidLoad() }
        setupUI()
        
    }
}

// MARK: - EditorViewControllerInput
extension EditorViewController: EditorViewControllerInput {

}

// MARK: - fileprivate EditorViewController
fileprivate extension EditorViewController {
    func setupUI() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        
    }
    
    func setConstraints() {
        
    }
}
