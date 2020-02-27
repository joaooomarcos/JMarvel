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
    
    init() {
        self.configure()
    }
    
    func configure() {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.jm.JMarvel")
        let realmURL = container!.appendingPathComponent("default.realm")
        var config = Realm.Configuration()
        config.fileURL = realmURL
        Realm.Configuration.defaultConfiguration = config
    }
    
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
    
    func delete<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    func object<T: CharacterRealm>(_ object: T) -> T? {
        do {
            let realm = try Realm()
            return realm.objects(T.self).first { $0.id == object.id }
        } catch {
            print(error)
            return nil
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
