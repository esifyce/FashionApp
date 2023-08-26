//
//  MainInteractor.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation
import RealmSwift

final class MainInteractor {
    let dataBaseManager: DataBaseManagerProtocol
    
    init(dataBaseManager: DataBaseManagerProtocol) {
        self.dataBaseManager = dataBaseManager
    }
//    private let viewModel: [MainViewModel] = [
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
//        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970)
//    ]
}

// MARK: - MainInteractorInput
extension MainInteractor: MainInteractorInput {
    func getModels() -> [MainViewModel] {
        guard let objects = dataBaseManager.obtainAll() else { return [] }
        var models: [MainViewModel] = []
        for object in objects {
            models.append(MainViewModel(projectName: "Hello \(object.id)", isCanDeleted: true,
                                        createdAt: Date().timeIntervalSince1970, skin: object.skinPath, id: object.id))
        }
        return models
    }
    
    func modify(model: MainViewModel) {
        dataBaseManager.modify(model)
    }
}
