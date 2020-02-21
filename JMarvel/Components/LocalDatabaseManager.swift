//
//  LocalDatabaseManager.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/21/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import RealmSwift

class LocalDatabaseManager {
    func save<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(T.self, value: object)
            }
        } catch {
            print(error)
        }
    }
    
    func objects<T: Object>(_ type: T.Type) -> [T] {
        do {
            let realm = try Realm()
            let models = realm.objects(T.self)
            return Array(models)
        } catch {
            print(error)
            return []
        }
    }
}
