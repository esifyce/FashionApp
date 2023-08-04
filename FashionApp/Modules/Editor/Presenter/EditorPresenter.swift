//
//  NewsDetailScreenPresenter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//


final class EditorPresenter {
    weak var view: EditorViewControllerInput?
    var router: EditorRouterInput?
    var interactor: EditorInteractorInput?
}

// MARK: - EditorPresenterInput
extension EditorPresenter: EditorPresenterInput {
    func viewDidLoad() {
    }
}

// MARK: - EditorPresenter
fileprivate extension EditorPresenter {
}
