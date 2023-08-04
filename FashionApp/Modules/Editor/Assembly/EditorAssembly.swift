//
//  EditorAssembly.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class EditorAssembly {
    static func assemble() -> UIViewController {
        
        let viewController = EditorViewController()
        let presenter = EditorPresenter()
        let interactor = EditorInteractor()
        let router = EditorRouter()
        
        viewController.presenter = presenter
        router.view = viewController
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
        
        return viewController
    }
}
