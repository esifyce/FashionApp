//
//  TemplateInteractor.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation

final class TemplateInteractor {
    private let viewModel: [MainViewModel] = [
        .init(projectName: "Mannequin 1", skin: "skinTemplate2"),
        .init(projectName: "Mannequin 2", skin: "skinTemplate"),
        .init(projectName: "Mannequin 3", skin: "skinTemplate2"),
        .init(projectName: "Mannequin 4", skin: "skinTemplate"),
        .init(projectName: "Mannequin 5", skin: "skinTemplate"),
        .init(projectName: "Mannequin 6", skin: "skinTemplate2"),
    ]
}

// MARK: - TemplateInteractorInput
extension TemplateInteractor: TemplateInteractorInput {
    func getViewModel(completion: ([MainViewModel]) -> Void) {
        completion(viewModel)
    }
}
