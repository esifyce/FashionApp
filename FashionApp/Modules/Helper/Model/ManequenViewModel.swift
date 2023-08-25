//
//  ManequenViewModel.swift
//  FashionApp
//
//  Created by Andrey on 25.08.23.
//

import Foundation


struct ManequenViewModel {
    let clothes: [EditorViewModel]
    var path: String
    
    init(clothes: [EditorViewModel], path: String = "") {
        self.clothes = clothes
        self.path = path
    }
}
