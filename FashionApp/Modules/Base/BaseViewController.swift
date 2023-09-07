//
//  BaseViewController.swift
//  FashionApp
//
//  Created by Krasivo on 05.08.2023.
//

import UIKit

extension BaseViewController {
    struct BaseAppearance {
        let size: CGFloat = 50
    }
}

class BaseViewController: UIViewController {
    let baseAppearance = BaseAppearance()
    
    private lazy var activityIndicator: CustomActivityIndicator = {
        let indicator = CustomActivityIndicator(frame: CGRect(x: 0, y: 0, width: baseAppearance.size, height: baseAppearance.size))
        indicator.tintColor = .black
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
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.animate()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimation()
    }
}

// MARK: - private BaseViewController

private extension BaseViewController {
    
}
