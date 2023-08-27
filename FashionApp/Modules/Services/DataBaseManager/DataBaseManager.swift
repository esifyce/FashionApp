//
//  DataBaseManager.swift
//  FashionApp
//
//  Created by Andrey on 25.08.23.
//

import Foundation
import RealmSwift

protocol DataBaseManagerProtocol {
    func save(_ model: ManequenViewModel)
    func obtainAll() -> Results<ManequenModelDB>?
    func remove(by id: String)
    func modify(_ model: MainViewModel)
}

class DataBaseManager: DataBaseManagerProtocol {
    func save(_ model: ManequenViewModel) {
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
    
    func obtainAll() -> Results<ManequenModelDB>? {
        do {
            let realm = try Realm()
            let objects = realm.objects(ManequenModelDB.self)
            return objects
        } catch(let error) {
            print(error)
            return nil
        }
    }
    
    func remove(by id: String) {
        do {
            let realm = try Realm()
            let objects = realm.objects(ManequenModelDB.self)
            if let deleteObject = objects.first(where: { $0.id == id }) {
                try realm.write {
                    realm.delete(deleteObject)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func modify(_ model: MainViewModel) {
        do {
            let realm = try Realm()
            let objects = realm.objects(ManequenModelDB.self)
            if let object = objects.first(where: { $0.id == model.id }) {
                try realm.write {
                    object.name = model.projectName
                }
            }
            
        } catch(let error) {
            print(error)
        }
    }
}

