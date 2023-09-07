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
        let models: [LayerViewModel] = []
        return models
    }
    
    func saveObject(image: UIImage, model: ManequenViewModel) {
        var viewModel = model
        service.saveImage(image: image, filename: model.name) { [weak self] path in
            viewModel.path = path
            self?.dataBaseService.save(viewModel)
        }
    }
}
