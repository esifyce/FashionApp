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
    private var models: [MainViewModel] = []
    
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
    func viewWillAppear() {
        models = interactor.getModels()
        collectionManager.displaySquareTemplates(models, isShowAddTemplate: true, isShowPaywallTemplate: true)
    }
    
    func updateCollection(with traitCollection: UITraitCollection) {
        collectionManager.updateLayout(with: traitCollection)
    }
    
    func settingTapped() {
        router.settingTapped()
    }
}

// MARK: - MainPresenter
fileprivate extension MainPresenter {
}

// MARK: - MainCollectionManagerDelegate
extension MainPresenter: MainCollectionManagerDelegate {
    func moreTapped(with model: MainViewModel) {
        router.openMore(with: model.projectName) { [weak self] name in
            self?.rename(with: name, in: model)
        } shareTo: { [weak self] in
            
        } delete: { [weak self] in
            
        }
    }
    
    private func rename(with name: String?, in model: MainViewModel) {
        guard let name else { return }
        
        if let index = models.firstIndex(where: { $0.id == model.id }), let model = models[safe: index] {
            let newModel = MainViewModel(projectName: name,
                                         isCanDeleted: model.isCanDeleted,
                                         createdAt: model.createdAt,
                                         skin: model.skin,
                                         id: model.id)
            self.models[index] = newModel
            interactor
        }
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
