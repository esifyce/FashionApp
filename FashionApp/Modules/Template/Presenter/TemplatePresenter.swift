//
//  NewsDetailScreenPresenter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class TemplatePresenter {
    weak var view: TemplateViewControllerInput?
    private var router: TemplateRouterInput
    private var interactor: TemplateInteractorInput
    private var collectionManager: TemplateCollectionManagerProtocol
    
    init(router: TemplateRouterInput,
         interactor: TemplateInteractorInput,
         collectionManager: TemplateCollectionManagerProtocol) {
        self.router = router
        self.interactor = interactor
        self.collectionManager = collectionManager
    }
}

// MARK: - TemplatePresenterInput
extension TemplatePresenter: TemplatePresenterInput {
    func viewDidLoad() {
        interactor.getViewModel { [weak self] viewModel in
            self?.collectionManager.displaySquareTemplates(viewModel)
        }
    }
    
    func updateCollection(with traitCollection: UITraitCollection) {
        collectionManager.updateLayout(with: traitCollection)
    }
    
    func popViewController() {
        router.popViewController()
    }
    
    func goToEditor() {
        router.goToEditor()
    }
}

// MARK: - TemplatePresenter
fileprivate extension TemplatePresenter {
}

// MARK: - TemplateCollectionManagerDelegate
extension TemplatePresenter: TemplateCollectionManagerDelegate {
    func templateCellTapped() {
        
    }
    
    func moreTapped() {
        router.openMore()
    }
    
    
}
