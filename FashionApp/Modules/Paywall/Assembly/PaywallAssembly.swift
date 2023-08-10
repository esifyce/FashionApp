//
//  PaywallAssembly.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class PaywallAssembly {
    static func assemble() -> UIViewController {
        
        let presenter = PaywallPresenter()
        let viewController = PaywallViewController(presenter: presenter)
        let interactor = PaywallInteractor()
        let router = PaywallRouter()
        
        viewController.presenter = presenter
        viewController.modalPresentationStyle = .overFullScreen
        router.view = viewController
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = viewController
        
        return viewController
    }
}
