//
//  PaywallRouter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class PaywallRouter {
    weak var view: UIViewController?
}

// MARK: - PaywallRouterInput
extension PaywallRouter: PaywallRouterInput {
    func showSeeOtherScreen() {
        let view = SelectPlanView()
        self.view?.showCustomView(view: view)
    }
}
