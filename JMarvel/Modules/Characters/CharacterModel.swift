//
//  Character.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

class CharacterModel: Decodable {
    var id: Int
    var name: String?
    var summary: String?
    var image: ImageModel?
    var comics: ListResources?
    var series: ListResources?
    var isFavorited: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case summary = "description"
        case image = "thumbnail"
        case comics
        case series
    }
    
    init(id: Int) {
        self.id = id
    }
    
    init(realm: CharacterRealm) {
        self.id = realm.id
    }
    
    func isNull() -> Bool {
        return self.name == nil && self.summary == nil && self.image == nil
    }
    
    func realmObject() -> CharacterRealm {
        let imageURL = self.image?.image(kind: .square)?.absoluteString
        return CharacterRealm(id, name: name, imageURL: imageURL)
    }
}
