//
//  EditorAssembly.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit
import KMDrawViewSDK

final class EditorAssembly {
    static func assemble(kmDrawView: KMDrawView) -> UIViewController {
        
        let colletionManager: EditorCollectionManagerProtocol = EditorCollectionManager()
        let service = Utils()
        let dataBaseService: DataBaseManagerProtocol = DataBaseManager()
        let interactor = EditorInteractor(service: service, dataBaseService: dataBaseService)
        let router = EditorRouter()
        let presenter = EditorPresenter(router: router,
                                        interactor: interactor,
                                        collectionManager: colletionManager)
        let viewController = EditorViewController(presenter: presenter, kmDrawView: kmDrawView)
        colletionManager.injectCollection(viewController.collectionView)
        colletionManager.injectDelegate(presenter)
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
