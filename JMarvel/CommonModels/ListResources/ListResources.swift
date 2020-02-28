//
//  ListResources.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 20/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

struct ListResources: Decodable {
    var available: Int?
    var urlPath: String?
    
    enum CodingKeys: String, CodingKey {
        case available
        case urlPath = "collectionURI"
    }
}
