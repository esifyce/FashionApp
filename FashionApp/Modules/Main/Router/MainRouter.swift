//
//  MainRouter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

final class MainRouter {
    weak var view: UIViewController?
}

// MARK: - MainRouterInput
extension MainRouter: MainRouterInput {
    func openMore(with name: String,
                  rename: @escaping (String?) -> (),
                  shareTo: @escaping () -> (),
                  delete: @escaping () -> ()) {
        let alert = UIAlertController(title: name, message: "What do you want to do with this projects", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Share", style: .default , handler:{ (UIAlertAction)in
            shareTo()
        }))
        
        alert.addAction(UIAlertAction(title: "Rename", style: .default , handler:{ (UIAlertAction)in
            let innerAlert = UIAlertController(title: "Rename project", message: name, preferredStyle: .alert)
            var text: String?
            innerAlert.addTextField { textField in
                text = textField.text
            }
            
            innerAlert.addAction(UIKit.UIAlertAction(title: "Save", style: UIKit.UIAlertAction.Style.default, handler: { _ in
                rename(text)
            }))

            innerAlert.addAction(UIKit.UIAlertAction(title: "Cancel", style: .default , handler: { _ in
            }))
        }))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            let deleteAlert = UIAlertController(title: "Do you really want to delete project?", message: "We have no trash and your project will be deleted immediately", preferredStyle: .alert)
            let deleteAction = UIKit.UIAlertAction(title: "Delete", style: UIKit.UIAlertAction.Style.default , handler:{ _ in
                delete()
            })
            deleteAlert.addAction(deleteAction)
            deleteAlert.addAction(UIKit.UIAlertAction(title: "Cancel", style: .cancel , handler:{ _ in
            }))
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        view?.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func goToAddTemplate() {
        let controller = TemplateAssembly.assemble()
        view?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func goToPaywall() {
        let controller = PaywallAssembly.assemble()
        controller.modalPresentationStyle = .overFullScreen
        view?.present(controller, animated: true)
    }
    
    func settingTapped() {
        let settingView = IphoneSettingsView()
        view?.showCustomView(view: settingView)
    }
}
