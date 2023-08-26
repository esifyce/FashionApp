//
//  ManequenModel.swift
//  FashionApp
//
//  Created by Andrey on 25.08.23.
//

import RealmSwift
import Foundation

class ManequenModelDB: Object {
    @Persisted var id: String = ""
    @Persisted var clothes = List<EditorModel>()
    @Persisted var skinPath: String = ""
    @Persisted var name: String = ""
    
    
    convenience init(from viewModel: ManequenViewModel) {
        self.init()
        for wear in viewModel.clothes {
            clothes.append(EditorModel(from: wear))
        }
        skinPath = viewModel.path
        id = UUID().uuidString
        name = viewModel.name
    }
}
