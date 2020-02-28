//
//  CharacterDetailRequest.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/27/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

class CharacterDetailRequest: Request {
    
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var endpoint: Endpoint {
        Endpoint(path: "/public/characters/\(id)")
    }
}
