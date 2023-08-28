//
//  TemplateAssembly.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class TemplateAssembly {
    static func assemble(kmDrawView: KMDrawView) -> UIViewController {
        
        let collectionManager: TemplateCollectionManagerProtocol = TemplateCollectionManager()
        let interactor = TemplateInteractor()
        let router = TemplateRouter()
        let presenter = TemplatePresenter(router: router,
                                          interactor: interactor,
                                          collectionManager: collectionManager)
        let viewController = TemplateViewController(presenter: presenter, kmDrawView: kmDrawView)
        collectionManager.injectCollection(viewController.collectionView)
        collectionManager.injectDelegate(presenter)
        
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
