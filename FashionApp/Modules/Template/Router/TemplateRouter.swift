//
//  TemplateRouter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class TemplateRouter {
    weak var view: UIViewController?
}

// MARK: - TemplateRouterInput
extension TemplateRouter: TemplateRouterInput {
    func openMore() {
        let alert = UIAlertController(title: "Project name", message: "What do you want to do with this projects", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Share", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
        }))
        
        alert.addAction(UIAlertAction(title: "Rename", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
        }))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        view?.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func popViewController() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func goToEditor() {
        let controller = EditorAssembly.assemble()
        view?.navigationController?.pushViewController(controller, animated: true)
    }
}
