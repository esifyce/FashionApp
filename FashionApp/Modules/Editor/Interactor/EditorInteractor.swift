//
//  EditorInteractor.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation

final class EditorInteractor {
    private let viewModel: [EditorViewModel] = []
}

// MARK: - EditorInteractorInput
extension EditorInteractor: EditorInteractorInput {
    func getViewModel(completion: ([EditorViewModel]) -> Void) {
        completion(viewModel)
    }
    
    func getLayerViewModels() -> [LayerViewModel] {
        let models: [LayerViewModel] = [.init(name: "Layers 445", color: .red, actions: [.hide, .duplicate], opacity: 0),
                                        .init(name: "Layers 445", color: .green, actions: [.mergeAll, .delete], opacity: 0),
                                        .init(name: "Layers 445", color: .blue, actions: [], opacity: 0),
                                        .init(name: "Layers 445", color: .yellow, actions: [], opacity: 0),
                                        .init(name: "Layers 445", color: .red, actions: [], opacity: 0),
                                        .init(name: "Layers 445", color: .red, actions: [], opacity: 0),
                                        .init(name: "Layers 445", color: .red, actions: [], opacity: 0),
                                        .init(name: "Layers 445", color: .gray, actions: [], opacity: 0),
                                        .init(name: "Layers 445", color: .red, actions: [], opacity: 0),
                                        .init(name: "Layers 445", color: .red, actions: [], opacity: 0)]
        return models
    }
}
