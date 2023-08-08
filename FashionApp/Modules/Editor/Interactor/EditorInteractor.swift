//
//  EditorInteractor.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation

final class EditorInteractor {
    private let viewModel: [EditorViewModel] = [
        .init(dressName: "Project Name"),
        .init(dressName: "Project Name"),
        .init(dressName: "Project Name"),
        .init(dressName: "Project Name"),
        .init(dressName: "Project Name"),
        .init(dressName: "Project Name"),
    ]
}

// MARK: - EditorInteractorInput
extension EditorInteractor: EditorInteractorInput {
    func getViewModel(completion: ([EditorViewModel]) -> Void) {
        completion(viewModel)
    }
}
