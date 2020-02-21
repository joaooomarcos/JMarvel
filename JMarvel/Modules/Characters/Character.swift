//
//  Character.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import RealmSwift

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
}

class CharacterRealm: Object {
    @objc dynamic var id: Int
    @objc dynamic var name: String?
    @objc dynamic var imageURL: String?
    
    init(_ model: CharacterModel) {
        self.id = model.id
        self.name = model.name
        self.imageURL = model.image?.image(kind: .square)?.absoluteString
    }
    
    required init() {
        self.id = 0
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
