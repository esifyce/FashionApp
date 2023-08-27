//
//  MainInteractorInput.swift
//  NewsApp
//
//  Created by Krasivo on 04.02.2023.
//

import Foundation

protocol MainInteractorInput: AnyObject {
    func getModels() -> [MainViewModel]
    func modify(model: MainViewModel)
    func remove(by id: String)
}
