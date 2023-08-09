//
//  NewsDetailScreenPresenterInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

protocol EditorPresenterInput: AnyObject {
    func viewDidLoad()
    func popViewController()
    func updateCollectionByCategory(index: UIImage.Clothes)
}
