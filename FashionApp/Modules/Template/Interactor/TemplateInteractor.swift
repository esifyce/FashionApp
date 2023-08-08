//
//  TemplateInteractor.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation

final class TemplateInteractor {
    private let viewModel: [MainViewModel] = [
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970),
        .init(projectName: "Project Name", isCanDeleted: true, createdAt: Date().timeIntervalSince1970)
    ]
}

// MARK: - TemplateInteractorInput
extension TemplateInteractor: TemplateInteractorInput {
    func getViewModel(completion: ([MainViewModel]) -> Void) {
        completion(viewModel)
    }
}
