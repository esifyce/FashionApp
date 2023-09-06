//
//  FirebaseManager.swift
//  FashionApp
//
//  Created by Andrey on 6.09.23.
//

import FirebaseStorage
import Kingfisher

enum Child: String {
    case clothes = "clothes"
    case previewClothes = "previewClothes"
    case templates = "templates"
}

enum FirebaseError: String, Error{
    case resultError = "Result Error"
    case failure = "failure"
    case metaDataError = "Meta data error"
    case urlError = "Uncompatible url"
}

struct ImageModel {
    let image: UIImage
    let name: String
}

typealias ImageSuccessCallback = (Result<[ImageModel], Error>) -> Void
typealias StorageResultCallback = ((StorageListResult?, Error) -> Void)


final class FirebaseManager {
    static let shared = FirebaseManager()

    private let storageRef = Storage.storage().reference()
    private let dispatchGroup = DispatchGroup()

    private init() {}

    func getImages(clothes: Clothes?, from child: Child, completion: @escaping ImageSuccessCallback) {
        if let clothes = clothes {
            getClothesImages(clothes: clothes, from: child, completion: completion)
        } else {
            getTemplatesImages(from: child, completion: completion)
        }
    }

    private func getTemplatesImages(from child: Child, completion: @escaping ImageSuccessCallback) {
        let childRef = storageRef.child(child.rawValue)
        listAllImages(in: childRef, completion: completion)
    }

    private func getClothesImages(clothes: Clothes, from child: Child, completion: @escaping ImageSuccessCallback) {
        let childRef = storageRef.child(child.rawValue).child(clothes.description.lowercased())
        listAllImages(in: childRef, completion: completion)
    }

    private func listAllImages(in reference: StorageReference, completion: @escaping ImageSuccessCallback) {
        var imageArray: [ImageModel] = []

        reference.listAll { [weak self] result, error in
            guard let self = self else { return }

            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let result = result else {
                completion(.failure(FirebaseError.resultError))
                return
            }

            for item in result.items {
                self.dispatchGroup.enter()
                
                item.getMetadata { metaData, error in
                    if let error  {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let name = metaData?.name else {
                        completion(.failure(FirebaseError.metaDataError))
                        return
                    }
                    
                    item.downloadURL { url, error in
                        if let error {
                            completion(.failure(error))
                            return
                        }
                        
                        guard let url else {
                            completion(.failure(FirebaseError.urlError))
                            self.dispatchGroup.leave()
                            return
                        }

                        KingfisherManager.shared.retrieveImage(with: url, options: [.fromMemoryCacheOrRefresh]) { [weak self] result in
                            guard let self = self else { return }

                            switch result {
                            case .success(let resultImage):
                                
                                imageArray.append(ImageModel(image: resultImage.image, name: name.truncateAfterDot()))
                            case .failure(let error):
                                completion(.failure(error))
                            }

                            self.dispatchGroup.leave()
                        }
                    }
                }
            }

            self.dispatchGroup.notify(queue: .global(qos: .background)) {
                completion(.success(imageArray))
            }
        }
    }
}
