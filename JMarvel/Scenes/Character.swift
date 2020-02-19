//
//  Character.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

struct CharacterModel: Decodable {
    var name: String?
    var thumbnail: ImageModel?
    
    var thumbURL: URL? {
        if let image = self.thumbnail?.path,
            let imageExtension = self.thumbnail?.extension,
            let url = URL(string: "\(image)/standard_fantastic.\(imageExtension)") {
            return url
        }
        
        return nil
    }
}

struct ImageModel: Decodable {
    var path: String?
    var `extension`: String?
}
