//
//  NewsDetailScreenPresenter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//


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
    func viewDidLoad() {
        interactor.getViewModel { [weak self] viewModel in
            self?.collectionManager.displaySquareEditors(viewModel)
        }
    }
    
    func popViewController() {
        router.popViewController()
    }
}

// MARK: - private EditorPresenter
private extension EditorPresenter {
}

// MARK: - EditorCollectionManagerDelegate
extension EditorPresenter: EditorCollectionManagerDelegate {
    
}
