//
//  CharacterRealm.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 21/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import RealmSwift

class CharacterRealm: Object {
    @objc dynamic var id: Int
    @objc dynamic var name: String?
    @objc dynamic var imageURL: String?
    
    init(_ id: Int, name: String?, imageURL: String?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
    
    required init() {
        self.id = 0
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
