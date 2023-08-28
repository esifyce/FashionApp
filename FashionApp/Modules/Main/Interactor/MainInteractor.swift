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
            models.append(MainViewModel(projectName: object.name, isCanDeleted: true,
                                        skin: object.skinPath, id: object.id))
        }
        
        for _ in 1...6 {
            models.append(MainViewModel(projectName: "Project Name"))
        }
        return models
    }
    
    func modify(model: MainViewModel) {
        dataBaseManager.modify(model)
    }
    
    func remove(by id: String) {
        dataBaseManager.remove(by: id)
    }
}
