//
//  NewsDetailScreenPresenterInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import UIKit

protocol SnapshotPresenterInput: AnyObject {
    func viewDidLoad()
    func popViewController()
    func didTapShareImage(with image: UIImage)
    func didTapSaveGalleryImage(with image: UIImage)
}
