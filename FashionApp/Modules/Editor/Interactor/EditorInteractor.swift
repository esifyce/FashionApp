//
//  EditorInteractor.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation
import RealmSwift

final class EditorInteractor {
    private let viewModel: [EditorViewModel] = []
    private let service: UtilsProtocol
    private let dataBaseService: DataBaseManagerProtocol
    
    init(service: UtilsProtocol, dataBaseService: DataBaseManagerProtocol) {
        self.service = service
        self.dataBaseService = dataBaseService
    }
}

// MARK: - EditorInteractorInput
extension EditorInteractor: EditorInteractorInput {
    func getViewModel(completion: ([EditorViewModel]) -> Void) {
        completion(viewModel)
    }
    
    func getLayerViewModels() -> [LayerViewModel] {
        let models: [LayerViewModel] = [.init(name: "Layers 445", color: .red, actions: [.hide, .duplicate], opacity: 100),
                                        .init(name: "Layers 445", color: .green, actions: [.mergeAll, .delete], opacity: 100),
                                        .init(name: "Layers 445", color: .blue, actions: [], opacity: 100),
                                        .init(name: "Layers 445", color: .yellow, actions: [], opacity: 100),
                                        .init(name: "Layers 445", color: .red, actions: [], opacity: 100),
                                        .init(name: "Layers 445", color: .red, actions: [], opacity: 100),
                                        .init(name: "Layers 445", color: .red, actions: [], opacity: 100),
                                        .init(name: "Layers 445", color: .gray, actions: [], opacity: 100),
                                        .init(name: "Layers 445", color: .red, actions: [], opacity: 100),
                                        .init(name: "Layers 445", color: .red, actions: [], opacity: 100)]
        return models
    }
    
    func saveObject(image: UIImage, name: String, model: ManequenViewModel) {
        var viewModel = model
        service.saveImage(image: image, filename: name) { [weak self] path in
            viewModel.path = path
            self?.dataBaseService.saveModelToDB(model: viewModel)
        }
    }
}
