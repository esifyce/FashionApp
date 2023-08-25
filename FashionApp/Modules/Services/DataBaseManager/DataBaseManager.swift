//
//  DataBaseManager.swift
//  FashionApp
//
//  Created by Andrey on 25.08.23.
//

import Foundation
import RealmSwift

protocol DataBaseManagerProtocol {
    func saveModelToDB(model: ManequenViewModel)
    func obtain() -> ManequenModelDB?
}

class DataBaseManager: DataBaseManagerProtocol {
    func saveModelToDB(model: ManequenViewModel) {
        do {
            let realm = try Realm()
            let manequenModel = ManequenModelDB(from: model)
            try realm.write {
                realm.add(manequenModel)
            }
        } catch(let error) {
            print(error)
        }
    }
    
    func obtain() -> ManequenModelDB? {
        do {
            let realm = try Realm()
            let object = realm.objects(ManequenModelDB.self).first
            return object
        } catch(let error) {
            
            print(error)
            return nil
        }
    }
}

