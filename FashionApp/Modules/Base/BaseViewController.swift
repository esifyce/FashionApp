//
//  BaseViewController.swift
//  FashionApp
//
//  Created by Krasivo on 05.08.2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true
    }
    
    func showActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}

// MARK: - private BaseViewController

private extension BaseViewController {
    
}
