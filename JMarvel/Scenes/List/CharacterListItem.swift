//
//  CharacterListItem.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/19/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

struct CharacterListItem {
    var name: String
    var imageURL: URL?
    var isFavorited: Bool
    
    init(_ character: CharacterModel) {
        self.name = character.name ?? ""
        self.imageURL = character.thumbURL
        self.isFavorited = character.isFavorited ?? false
    }
}
