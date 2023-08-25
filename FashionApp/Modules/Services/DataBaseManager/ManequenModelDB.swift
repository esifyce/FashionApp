//
//  ManequenModel.swift
//  FashionApp
//
//  Created by Andrey on 25.08.23.
//

import RealmSwift
import Foundation

class ManequenModelDB: Object {
    @Persisted var clothes = List<EditorModel>()
    @Persisted var skinPath: String = ""
    
    
    convenience init(from viewModel: ManequenViewModel) {
        self.init()
        for wear in viewModel.clothes {
            clothes.append(EditorModel(from: wear))
        }
        self.skinPath = viewModel.path
    }
}
