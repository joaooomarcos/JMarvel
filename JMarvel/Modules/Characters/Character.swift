//
//  Character.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

struct CharacterModel: Decodable {
    var id: Int?
    var name: String?
    var description: String?
    var image: ImageModel?
    var comics: ListResources?
    var series: ListResources?
    var isFavorited: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image = "thumbnail"
        case comics
        case series
    }
}
