//
//  MainAssembly.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class MainAssembly {
    static func assemble() -> UIViewController {
        
        let collectionManager: MainCollectionManagerProtocol = MainCollectionManager()
        let interactor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(router: router,
                                      interactor: interactor,
                                      collectionManager: collectionManager)
        let viewController = MainViewController(presenter: presenter)
        collectionManager.injectCollection(viewController.collectionView)
        collectionManager.injectDelegate(presenter)

        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
