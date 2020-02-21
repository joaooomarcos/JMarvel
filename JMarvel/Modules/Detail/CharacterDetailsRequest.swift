//
//  CharacterDetailsRequest.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/20/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

class CharacterDetailsRequest: Request {
    
    enum Kind: String {
        case series
        case comics
    }
    
    private var id: Int
    private var kind: Kind
    
    init(id: Int, kind: Kind) {
        self.id = id
        self.kind = kind
    }
    
    var endpoint: Endpoint {
        Endpoint(path: "/public/characters/\(id)/\(kind.rawValue)")
    }
    
    var parameters: Parameters {
        ["limit": "10"]
    }
    
    var method: HTTPMethod? {
        .get
    }
}
