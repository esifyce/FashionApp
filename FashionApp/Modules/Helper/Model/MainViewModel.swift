//
//  MainViewModel.swift
//  FashionApp
//
//  Created by Krasivo on 05.08.2023.
//

import Foundation
import RealmSwift

struct MainViewModel {
    let projectName: String
    let isCanDeleted: Bool
    let createdAt: Double
    var skin: String
    
    init(projectName: String, isCanDeleted: Bool, createdAt: Double, skin: String = "") {
        self.projectName = projectName
        self.isCanDeleted = isCanDeleted
        self.createdAt = createdAt
        self.skin = skin
    }
}
