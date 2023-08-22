//
//  NewsDetailScreenPresenterInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

protocol MainPresenterInput: AnyObject {
    func viewDidLoad()
    func updateCollection(with traitCollection: UITraitCollection)
    func settingTapped()
}
