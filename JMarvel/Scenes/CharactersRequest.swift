//
//  TestRequest.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 18/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

class CharactersRequest: Request {
    var endpoint: Endpoint {
        Endpoint(path: "/public/characters")
    }
    
    var parameters: Parameters {
        ["orderBy": "name",
         "limit": "20"]
    }
    
    var method: HTTPMethod? {
        .get
    }
}
