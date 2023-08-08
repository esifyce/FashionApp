//
//  NewsDetailScreenPresenterInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

protocol TemplatePresenterInput: AnyObject {
    func viewDidLoad()
    func updateCollection(with traitCollection: UITraitCollection)
}
