//
//  TemplateModel.swift
//  FashionApp
//
//  Created by Andrey on 25.08.23.
//

import RealmSwift
import Foundation

class EditorModel: Object {
    @Persisted var preview: String = ""
    @Persisted var dress: String = ""
    @Persisted var dressType: Int = 0
    
    convenience init(from model: EditorViewModel) {
        self.init()
        preview = model.previewDress
        dress = model.nameDress
        dressType = model.typeDress.rawValue
    }
    
    var editorViewModel: EditorViewModel {
        return EditorViewModel(nameDress: dress,
                               typeDress: UIImage.Clothes(rawValue: dressType) ?? .dress,
                               previewDress: preview,
                               isSelectedImage: true)
    }
}
