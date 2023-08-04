//
//  TemplateAssembly.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class TemplateAssembly {
    static func assemble() -> UIViewController {
        
        let viewController = TemplateViewController()
        let presenter = TemplatePresenter()
        let interactor = TemplateInteractor()
        let router = TemplateRouter()
        
        viewController.presenter = presenter
        router.view = viewController
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
        
        return viewController
    }
}
