//
//  EditorRouter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class EditorRouter {
    weak var view: UIViewController?
}

// MARK: - EditorRouterInput
extension EditorRouter: EditorRouterInput {
    func popViewController() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func shareSkinImage(with image: UIImage?) {
        let controller = SnapshotAssembly.assemble(skinImage: image)
        view?.navigationController?.pushViewController(controller, animated: true)
    }
}
