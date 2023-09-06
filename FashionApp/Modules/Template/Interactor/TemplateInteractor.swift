//
//  TemplateInteractor.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation
import Firebase
import FirebaseStorage

final class TemplateInteractor {

}

// MARK: - TemplateInteractorInput
extension TemplateInteractor: TemplateInteractorInput {
    func getViewModel(completion: @escaping ([MainViewModel]) -> Void) {
        FirebaseManager.shared.getImages(clothes: nil, from: .templates) { [weak self] result in
            switch result {
            case .success(let model):
                let images = model.map{ MainViewModel(projectName: $0.name, image: $0.image)}
                completion(images)
            case .failure(let error):
                print(error)
            }
        }
    }
}
