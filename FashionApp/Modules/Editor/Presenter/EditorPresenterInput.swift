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
    func updateCollectionByCategory(index: Clothes)
    func layerButtonTapped()
    func doneButtonTapped()
    func getClothesStack() -> [EditorViewModel]
    func getRendoStack() -> [EditorViewModel]
    func setClothesStack(with stack: [EditorViewModel])
    func setRendoStack(with stack: [EditorViewModel])
    func popFromClothes() -> EditorViewModel?
    func popFromRendoClothes() -> EditorViewModel?
}
