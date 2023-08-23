//
//  EditorInteractorInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation

protocol EditorInteractorInput: AnyObject {
    func getViewModel(completion: ([EditorViewModel]) -> Void)
    func getLayerViewModels() -> [LayerViewModel]
}
