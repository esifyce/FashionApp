//
//  MainRouter.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit
import SnapKit

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
        
        alert.addAction(UIAlertAction(title: "Rename", style: .default , handler:{ [weak self] (UIAlertAction)in
            let innerAlert = UIAlertController(title: "Rename project", message: name, preferredStyle: .alert)
            innerAlert.addTextField { textField in
                textField.text = ""
            }
            
            innerAlert.addAction(UIKit.UIAlertAction(title: "Save", style: UIKit.UIAlertAction.Style.default, handler: { [weak innerAlert] (_) in
                rename(innerAlert?.textFields?[0].text)
            }))

            innerAlert.addAction(UIKit.UIAlertAction(title: "Cancel", style: .default , handler: { _ in
            }))
            self?.view?.present(innerAlert, animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ [weak self] (UIAlertAction)in
            let deleteAlert = UIAlertController(title: "Do you really want to delete project?", message: "We have no trash and your project will be deleted immediately", preferredStyle: .alert)
            let deleteAction = UIKit.UIAlertAction(title: "Delete", style: UIKit.UIAlertAction.Style.default , handler:{ _ in
                delete()
            })
            deleteAlert.addAction(deleteAction)
            deleteAlert.addAction(UIKit.UIAlertAction(title: "Cancel", style: .cancel , handler:{ _ in
            }))
            self?.view?.present(deleteAlert, animated: true, completion: nil)
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
        if UIDevice.current.userInterfaceIdiom == .pad {
            let popoverController = TestController()
            popoverController.modalPresentationStyle = .popover
            popoverController.preferredContentSize = CGSize(width: 390, height: 242)
            if let presentation = popoverController.popoverPresentationController {
                presentation.permittedArrowDirections = .up
                presentation.barButtonItem = view?.navigationItem.rightBarButtonItem
                view?.present(popoverController, animated: true)
            }
        } else {
            let settingView = IphoneSettingsView()
            view?.showCustomView(view: settingView)
        }
    }
}

class TestController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = "Hello"
        cell.selectionStyle = .none
        return cell
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .gray
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
