//
//  NewsDetailScreenPresenter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit


final class EditorPresenter {
    weak var view: EditorViewControllerInput?
    private let router: EditorRouterInput
    private let interactor: EditorInteractorInput
    private let collectionManager: EditorCollectionManagerProtocol
    
    init(router: EditorRouterInput,
         interactor: EditorInteractorInput,
         collectionManager: EditorCollectionManagerProtocol) {
        self.router = router
        self.interactor = interactor
        self.collectionManager = collectionManager
    }
}

// MARK: - EditorPresenterInput
extension EditorPresenter: EditorPresenterInput {
    func viewDidLoad() {}
    
    func popViewController() {
        router.popViewController()
    }
    
    func updateCollectionByCategory(index: UIImage.Clothes) {
        let viewModel = index.getClothes.map({ EditorViewModel(dressName: $0) })
        collectionManager.displaySquareEditors(viewModel)
    }
}

// MARK: - private EditorPresenter
private extension EditorPresenter {
}

// MARK: - EditorCollectionManagerDelegate
extension EditorPresenter: EditorCollectionManagerDelegate {
    func addedItemToManiquen(dressName: String) {
        view?.addedItemToManiquen(dressName: dressName)
    }
}
