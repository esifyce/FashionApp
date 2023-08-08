//
//  NewsDetailScreenPresenter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//
import UIKit

final class MainPresenter {
    weak var view: MainViewControllerInput?
    private var router: MainRouterInput
    private var interactor: MainInteractorInput
    private let collectionManager: MainCollectionManagerProtocol
    
    init(router: MainRouterInput,
         interactor: MainInteractorInput,
         collectionManager: MainCollectionManagerProtocol) {
        self.router = router
        self.interactor = interactor
        self.collectionManager = collectionManager
    }
}

// MARK: - MainPresenterInput
extension MainPresenter: MainPresenterInput {
    func viewDidLoad() {
        interactor.getViewModel { [weak self] viewModel in
            self?.collectionManager.displaySquareTemplates(viewModel, isShowAddTemplate: true, isShowPaywallTemplate: true)
        }
    }
    
    func updateCollection(with traitCollection: UITraitCollection) {
        collectionManager.updateLayout(with: traitCollection)
    }
}

// MARK: - MainPresenter
fileprivate extension MainPresenter {
}

// MARK: - MainCollectionManagerDelegate
extension MainPresenter: MainCollectionManagerDelegate {
    func moreTapped() {
        router.openMore()
    }
    
    func addCellTapped() {
        router.goToAddTemplate()
    }
    
    func paywallCellTapped() {
        router.goToPaywall()
    }
    
    func templateCellTapped() {
        
    }
}
