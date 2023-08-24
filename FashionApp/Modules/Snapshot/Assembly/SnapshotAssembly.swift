//
//  SnapshotAssembly.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class SnapshotAssembly {
    static func assemble(skinImage: UIImage?) -> UIViewController {
        
        let interactor = SnapshotInteractor()
        let router = SnapshotRouter()
        let presenter = SnapshotPresenter(router: router,
                                          interactor: interactor)
        let viewController = SnapshotViewController(presenter: presenter, skinImage: skinImage)
        
        router.view = viewController
        presenter.view = viewController
        
        return viewController
    }
}
