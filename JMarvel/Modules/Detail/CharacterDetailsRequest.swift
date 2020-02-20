//
//  CharacterDetailsRequest.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/20/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

class CharacterDetailsRequest: Request {
    
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var endpoint: Endpoint {
        Endpoint(path: "/public/characters/\(id)/series")
    }
    
    var parameters: Parameters {
        ["orderBy": "-startYear",
         "limit": "10"]
    }
    
    var method: HTTPMethod? {
        .get
    }
}
