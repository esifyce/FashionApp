//
//  NewsDetailScreenPresenter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//


final class PaywallPresenter {
    weak var view: PaywallViewControllerInput?
    var router: PaywallRouterInput?
    var interactor: PaywallInteractorInput?
}

// MARK: - PaywallPresenterInput
extension PaywallPresenter: PaywallPresenterInput {
    func viewDidLoad() {
    }
    
    func seeOtherTapped() {
        router?.showSeeOtherScreen()
    }
}

// MARK: - PaywallPresenter
fileprivate extension PaywallPresenter {
}
