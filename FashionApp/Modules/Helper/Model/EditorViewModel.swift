//
//  EditorViewModel.swift
//  FashionApp
//
//  Created by Krasivo on 08.08.2023.
//

import UIKit

struct EditorViewModel {
    let nameDress: String
    let typeDress: Clothes
    let previewDress: String
    var isSelectedImage: Bool
    var path: String
    
    init(nameDress: String, typeDress: Clothes, previewDress: String, isSelectedImage: Bool, path: String = "") {
        self.nameDress = nameDress
        self.typeDress = typeDress
        self.previewDress = previewDress
        self.isSelectedImage = isSelectedImage
        self.path = path
    }
}
