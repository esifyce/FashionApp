//
//  NewsDetailScreenPresenter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//


final class TemplatePresenter {
    weak var view: TemplateViewControllerInput?
    var router: TemplateRouterInput?
    var interactor: TemplateInteractorInput?
}

// MARK: - TemplatePresenterInput
extension TemplatePresenter: TemplatePresenterInput {
    func viewDidLoad() {
    }
}

// MARK: - TemplatePresenter
fileprivate extension TemplatePresenter {
}
