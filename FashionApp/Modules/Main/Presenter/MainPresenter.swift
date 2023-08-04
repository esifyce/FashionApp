//
//  NewsDetailScreenPresenter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//


final class MainPresenter {
    weak var view: MainViewControllerInput?
    var router: MainRouterInput?
    var interactor: MainInteractorInput?
}

// MARK: - MainPresenterInput
extension MainPresenter: MainPresenterInput {
    func viewDidLoad() {
    }
}

// MARK: - MainPresenter
fileprivate extension MainPresenter {
}
