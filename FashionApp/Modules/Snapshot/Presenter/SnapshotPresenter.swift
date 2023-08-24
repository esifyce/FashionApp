//
//  NewsDetailScreenPresenter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class SnapshotPresenter {
    weak var view: SnapshotViewControllerInput?
    private var router: SnapshotRouterInput
    private var interactor: SnapshotInteractorInput
    
    init(router: SnapshotRouterInput,
         interactor: SnapshotInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SnapshotPresenterInput
extension SnapshotPresenter: SnapshotPresenterInput {
    func viewDidLoad() {
    }
    
    func popViewController() {
        router.popViewController()
    }
    
    func didTapShareImage(with image: UIImage) {
        router.shareImage(with: image)
    }
    
    func didTapSaveGalleryImage(with image: UIImage) {
        router.saveGallery(with: image)
    }
}

// MARK: - SnapshotPresenter
fileprivate extension SnapshotPresenter {
}
