//
//  BaseViewController.swift
//  FashionApp
//
//  Created by Krasivo on 05.08.2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true
    }
}

// MARK: - private BaseViewController

private extension BaseViewController {
    
}
