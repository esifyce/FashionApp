//
//  EditorAssembly.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class EditorAssembly {
    static func assemble() -> UIViewController {
        
        let colletionManager: EditorCollectionManagerProtocol = EditorCollectionManager()
        let interactor = EditorInteractor()
        let router = EditorRouter()
        let presenter = EditorPresenter(router: router,
                                        interactor: interactor,
                                        collectionManager: colletionManager)
        let viewController = EditorViewController(presenter: presenter)
        colletionManager.injectCollection(viewController.collectionView)
        colletionManager.injectDelegate(presenter)
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
