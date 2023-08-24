//
//  SnapshotRouterInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation

protocol SnapshotRouterInput: AnyObject {
    func popViewController()
    func shareImage(with image: UIImage)
    func saveGallery(with image: UIImage)
}
