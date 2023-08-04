//
//  MainAssembly.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class MainAssembly {
    static func assemble() -> UIViewController {
        
        let viewController = MainViewController()
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let router = MainRouter()
        
        viewController.presenter = presenter
        router.view = viewController
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
        
        return viewController
    }
}
